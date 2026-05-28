from ftplib import FTP
from pathlib import Path

ROBOT_IP = "192.168.125.1"
FTP_USER = "abb"
FTP_PASS = "abb"
FTP_DIR = "HOME"


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


def main():
    folder = Path(".").resolve()

    test_path = folder / "test5.mod"
    if not test_path.exists():
        print("❌ test.mod niet gevonden in deze map.")
        return

    print(f"[i] Bestand gevonden: {test_path.name}")
    print("Verbinding maken...")
    ftp_upload(test_path, "test.mod")


if __name__ == "__main__":
    main()