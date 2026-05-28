from ftplib import FTP
from pathlib import Path
import re

# =========================
# ROBOT FTP INSTELLINGEN
# =========================
ROBOT_IP = "192.168.125.1"
FTP_USER = "abb"
FTP_PASS = "abb"
FTP_DIR = "HOME"

# =========================
# PLEXIGLAS INSTELLINGEN
# =========================
PLEXI_W = 300.0
PLEXI_H = 140.0
MARGIN = 10.0

# =========================
# GCODE PARSING
# =========================
RX_X = re.compile(r"\bX(-?\d+(?:\.\d+)?)")
RX_Y = re.compile(r"\bY(-?\d+(?:\.\d+)?)")


def extract_xy(line: str):
    mx = RX_X.search(line)
    my = RX_Y.search(line)
    if mx and my:
        return float(mx.group(1)), float(my.group(1))
    return None


def compute_bbox(lines):
    pts = []
    for ln in lines:
        xy = extract_xy(ln)
        if xy:
            pts.append(xy)
    if not pts:
        raise ValueError("Geen X/Y-coördinaten in gcode gevonden.")
    xs = [p[0] for p in pts]
    ys = [p[1] for p in pts]
    return min(xs), max(xs), min(ys), max(ys)


def scale_and_center_transform(bbox):
    minx, maxx, miny, maxy = bbox
    w = maxx - minx
    h = maxy - miny

    max_w = PLEXI_W - 2 * MARGIN
    max_h = PLEXI_H - 2 * MARGIN

    scale = min(max_w / w, max_h / h)

    scaled_w = w * scale
    scaled_h = h * scale

    tx = MARGIN + (max_w - scaled_w) / 2 - minx * scale
    ty = MARGIN + (max_h - scaled_h) / 2 - miny * scale

    return scale, tx, ty


def transform_xy(x, y, scale, tx, ty):
    return x * scale + tx, y * scale + ty


def gcode_to_moves(gcode_lines, pen_on="M106", pen_off="M107"):
    bbox = compute_bbox(gcode_lines)
    scale, tx, ty = scale_and_center_transform(bbox)

    moves = []
    draw = False

    for ln in gcode_lines:
        s = ln.strip()

        if s.startswith(pen_on):
            draw = True
            continue

        if s.startswith(pen_off):
            draw = False
            continue

        xy = extract_xy(ln)
        if xy:
            x, y = xy
            X, Y = transform_xy(x, y, scale, tx, ty)
            moves.append((X, Y, draw))

    return moves, scale


# =========================
# RAPID MODULE GENEREREN
# =========================
def make_rapid_module(moves):
    lines = []

    lines.append("MODULE AlienDraw")
    lines.append("")
    lines.append("    CONST num Z_UP := 10;")
    lines.append("    CONST num Z_DOWN := 0;")
    lines.append("")
    lines.append("    CONST speeddata V_TRAVEL := [200,500,5000,1000];")
    lines.append("    CONST speeddata V_DRAW   := [50,200,2000,1000];")
    lines.append("")
    lines.append("    ! Deze positie moet je op de robot nog goed zetten")
    lines.append('    PERS robtarget pPlotStart := [[150,70,50],[1,0,0,0],[0,0,1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];')
    lines.append("")
    lines.append("    PROC MoveToXY(num x, num y, bool draw)")
    lines.append("        VAR robtarget p;")
    lines.append("")
    lines.append("        p := CRobT(\\Tool:=toolPen,\\WObj:=wobjPlexi);")
    lines.append("        p.trans.x := x;")
    lines.append("        p.trans.y := y;")
    lines.append("")
    lines.append("        IF draw THEN")
    lines.append("            p.trans.z := p.trans.z + Z_DOWN;")
    lines.append("            MoveL p, V_DRAW, fine, toolPen\\WObj:=wobjPlexi;")
    lines.append("        ELSE")
    lines.append("            p.trans.z := p.trans.z + Z_UP;")
    lines.append("            MoveL p, V_TRAVEL, z10, toolPen\\WObj:=wobjPlexi;")
    lines.append("        ENDIF")
    lines.append("    ENDPROC")
    lines.append("")
    lines.append("    PROC DrawAlien()")
    lines.append("        ConfL \\Off;")
    lines.append("        SingArea \\Wrist;")
    lines.append("")
    lines.append("        MoveJ pPlotStart, V_TRAVEL, fine, toolPen\\WObj:=wobjPlexi;")
    lines.append("")

    for x, y, draw in moves:
        rapid_bool = "TRUE" if draw else "FALSE"
        lines.append(f"        MoveToXY {x:.3f}, {y:.3f}, {rapid_bool};")

    lines.append("")
    lines.append("        TPWrite \"Alien klaar\";")
    lines.append("    ENDPROC")
    lines.append("")
    lines.append("ENDMODULE")
    lines.append("")

    return "\n".join(lines)


# =========================
# FTP UPLOAD
# =========================
def ftp_upload(local_path: Path, remote_name: str):
    ftp = FTP(ROBOT_IP)
    ftp.login(FTP_USER, FTP_PASS)

    try:
        ftp.cwd(FTP_DIR)
    except Exception:
        pass

    with local_path.open("rb") as f:
        ftp.storbinary(f"STOR {remote_name}", f)

    ftp.quit()
    print(f"[OK] geupload: {local_path.name} -> {FTP_DIR}/{remote_name}")


# =========================
# MAIN
# =========================
def main():
    folder = Path(".").resolve()

    gcodes = sorted(folder.glob("*.gcode"))
    if not gcodes:
        print("❌ Geen .gcode gevonden in deze map.")
        return

    gcode_path = gcodes[0]
    print(f"[i] Gebruik gcode: {gcode_path.name}")

    gcode_lines = gcode_path.read_text(encoding="utf-8", errors="ignore").splitlines()

    moves, scale = gcode_to_moves(gcode_lines)

    mod_text = make_rapid_module(moves)

    mod_path = folder / "AlienDraw.mod"
    mod_path.write_text(mod_text, encoding="utf-8")

    print(f"[OK] module gemaakt: {mod_path.name}")
    print(f"[OK] schaalfactor: {scale:.4f}")

    print("Verbinding maken...")
    ftp_upload(mod_path, "AlienDraw.mod")

    print("")
    print("Volgende stap op robot:")
    print("1) Load AlienDraw.mod")
    print("2) Leer pPlotStart in op een veilige positie boven je plexiglas")
    print("3) In MainModule: DrawAlien;")
    print("4) Test eerst met Z_DOWN := 0 en speed 10%")


if __name__ == "__main__":
    main()