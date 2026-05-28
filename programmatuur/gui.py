import tkinter as tk
import re

MAX_LETTERS = 6

# =========================
# ROBOT KOPPELING
# =========================
def stuur_naar_robot(naam):
    # Hier koppel je later je ABB / Python script of FTP upload aan
    print(f"[ROBOT] Naam om te tekenen: {naam}")


# =========================
# GUI FUNCTIES
# =========================
def only_letters(text):
    # Verwijder alles wat geen letter is en maak er hoofdletters van (max 6)
    return re.sub(r"[^A-Z]", "", text.upper())[:MAX_LETTERS]

def update_input(*args):
    current = name_var.get()
    cleaned = only_letters(current)

    if current != cleaned:
        name_var.set(cleaned)
        # BUG FIX: Geen 'return' hier, code loopt netjes door om UI te updaten!

    # Update teller
    counter_label.config(text=f"{len(cleaned)}/{MAX_LETTERS}")

    # Update knop stijl gebaseerd op inhoud
    if cleaned:
        # Actieve "TEKEN" knop (Neon Groen)
        draw_button.config(bg=BTN_ACTIVE, fg=BG_DARK, activebackground=BTN_HOVER, activeforeground=BG_DARK)
    else:
        # Inactieve "TEKEN" knop (Grijs)
        draw_button.config(bg="#444444", fg="#888888", activebackground="#444444")

def start_drawing():
    naam = name_var.get().strip().upper()

    if not naam:
        status_label.config(text="⚠️ Fout: Vul eerst je naam in!", fg=ROBOT_ACCENT)
        root.after(2500, reset_status)
        return

    # Visuele feedback start
    status_label.config(text=f"Robotarm maakt zich klaar voor: {naam}", fg=BTN_ACTIVE)
    root.after(700, lambda: status_label.config(text=f"Tekenen bezig... {naam}"))
    root.after(1000, lambda: stuur_naar_robot(naam))

def reset_status():
    status_label.config(text="Systeem gereed. Wachten op invoer...", fg=TEXT_LIGHT)

def clear_name():
    name_var.set("")
    entry.focus()
    reset_status()

# =========================
# CANVAS TEKEN FUNCTIES
# =========================
def draw_rounded_rect(canvas, x1, y1, x2, y2, r, fill, outline="", width=1):
    canvas.create_arc(x1, y1, x1 + r, y1 + r, start=90, extent=90, fill=fill, outline=outline, width=width)
    canvas.create_arc(x2 - r, y1, x2, y1 + r, start=0, extent=90, fill=fill, outline=outline, width=width)
    canvas.create_arc(x1, y2 - r, x1 + r, y2, start=180, extent=90, fill=fill, outline=outline, width=width)
    canvas.create_arc(x2 - r, y2 - r, x2, y2, start=270, extent=90, fill=fill, outline=outline, width=width)
    canvas.create_rectangle(x1 + r / 2, y1, x2 - r / 2, y2, fill=fill, outline=outline, width=width)
    canvas.create_rectangle(x1, y1 + r / 2, x2, y2 - r / 2, fill=fill, outline=outline, width=width)

def draw_robot_arm(canvas, x, y, mirror=False):
    direction = -1 if mirror else 1

    # Basis scharnierpunt
    canvas.create_oval(x - 42, y - 42, x + 42, y + 42, fill=PANEL_BG, outline=TEXT_LIGHT, width=4)
    canvas.create_oval(x - 18, y - 18, x + 18, y + 18, fill=ROBOT_ACCENT, outline=TEXT_LIGHT, width=3)

    # Arm segmenten
    p1 = (x + direction * 38, y - 18)
    p2 = (x + direction * 125, y - 95)
    p3 = (x + direction * 215, y - 55)
    p4 = (x + direction * 245, y + 5)

    canvas.create_line(*p1, *p2, fill=ROBOT_ACCENT, width=14, capstyle="round", joinstyle="round")
    canvas.create_line(*p2, *p3, fill=ROBOT_ACCENT, width=14, capstyle="round", joinstyle="round")

    canvas.create_oval(p2[0] - 22, p2[1] - 22, p2[0] + 22, p2[1] + 22, fill=PANEL_BG, outline=TEXT_LIGHT, width=4)
    canvas.create_oval(p3[0] - 18, p3[1] - 18, p3[0] + 18, p3[1] + 18, fill=PANEL_BG, outline=TEXT_LIGHT, width=4)

    # Penhouder en stift
    canvas.create_line(*p3, *p4, fill=TEXT_LIGHT, width=8, capstyle="round")
    canvas.create_polygon(
        p4[0] - direction * 14, p4[1],
        p4[0] + direction * 14, p4[1],
        p4[0], p4[1] + 42,
        fill=ROBOT_ACCENT,
        outline=TEXT_LIGHT,
        width=3
    )
    canvas.create_polygon(
        p4[0] - direction * 8, p4[1] + 42,
        p4[0] + direction * 8, p4[1] + 42,
        p4[0], p4[1] + 58,
        fill=TEXT_LIGHT,
        outline=TEXT_LIGHT
    )


# =========================
# KLEURENPALET (Dark Mode Industrial)
# =========================
BG_DARK = "#15151A"         # Diep donkergrijze achtergrond
PANEL_BG = "#2B2B36"        # Iets lichtere grijze panelen
TEXT_LIGHT = "#F4F4F6"      # Helder witte tekst
TEXT_SUBTLE = "#A0A0B0"     # Grijze subtiele tekst
ROBOT_ACCENT = "#FF5722"    # Safety Orange voor de robot armen
BTN_ACTIVE = "#00E676"      # Neon groen voor de actieknop
BTN_HOVER = "#00C853"       # Donkerder groen bij hover

# =========================
# WINDOW SETUP & KIOSK MODE
# =========================
root = tk.Tk()
root.title("Letter Fabriek - Kiosk")
root.configure(bg=BG_DARK)

# Maak de applicatie Fullscreen (geen taakbalk meer)
root.attributes("-fullscreen", True)

# Sluit de app door op ESCAPE te drukken (Noodknop)
root.bind("<Escape>", lambda event: root.destroy())

# Container zorgt ervoor dat de 1100x720 app exact in het midden
# van de grote monitor blijft zweven.
container = tk.Frame(root, bg=BG_DARK)
container.pack(expand=True)

name_var = tk.StringVar()
name_var.trace_add("write", update_input)

canvas = tk.Canvas(container, width=1100, height=720, bg=BG_DARK, highlightthickness=0)
canvas.pack()

# =========================
# BACKGROUND & HEADER
# =========================
canvas.create_rectangle(0, 0, 1100, 100, fill="#0A0A0D", outline="")
canvas.create_rectangle(0, 620, 1100, 720, fill="#0A0A0D", outline="")

for i in range(0, 1100, 55):
    canvas.create_rectangle(i, 90, i + 28, 100, fill=ROBOT_ACCENT, outline="")

canvas.create_text(
    550, 50,
    text="LETTER FABRIEK",
    font=("Arial Black", 42),
    fill=ROBOT_ACCENT
)

# Robot armen links en rechts tekenen
draw_robot_arm(canvas, 175, 345, mirror=False)
draw_robot_arm(canvas, 925, 345, mirror=True)

# =========================
# MAIN MACHINE PANEL
# =========================
draw_rounded_rect(canvas, 305, 200, 795, 520, 30, PANEL_BG, "", 0)

canvas.create_text(
    550, 260,
    text="VUL JE NAAM IN:",
    font=("Arial", 22, "bold"),
    fill=TEXT_LIGHT
)

# Invoerveld achtergrond (wit vlak)
draw_rounded_rect(canvas, 385, 300, 715, 375, 15, "#FFFFFF", "", 0)

entry = tk.Entry(
    container,
    textvariable=name_var,
    font=("Arial Black", 32),
    justify="center",
    bg="#FFFFFF",
    fg="#000000",
    bd=0,
    insertbackground=ROBOT_ACCENT,
    highlightthickness=0
)
canvas.create_window(550, 338, window=entry, width=280, height=55)

counter_label = tk.Label(
    container,
    text="0/6",
    font=("Arial", 14, "bold"),
    bg="#FFFFFF",
    fg="#999999"
)
canvas.create_window(695, 338, window=counter_label)

# Grote Actieknop
draw_button = tk.Button(
    container,
    text="TEKENEN",
    command=start_drawing,
    font=("Arial Black", 24),
    bg="#444444",
    fg="#888888",
    activebackground="#444444",
    activeforeground="white",
    bd=0,
    relief="flat",
    width=12,
    cursor="hand2"
)
canvas.create_window(550, 435, window=draw_button)

# Wissen knop
clear_button = tk.Button(
    container,
    text="wissen",
    command=clear_name,
    font=("Arial", 12, "bold"),
    bg=PANEL_BG,
    fg=TEXT_SUBTLE,
    activebackground="#3B3B4A",
    activeforeground=TEXT_LIGHT,
    bd=0,
    cursor="hand2"
)
canvas.create_window(550, 490, window=clear_button, width=80, height=25)

# Status tekst (Kiosk proof, geen popups)
status_label = tk.Label(
    container,
    text="Systeem gereed. Wachten op invoer...",
    font=("Arial", 15, "bold"),
    bg="#0A0A0D",
    fg=TEXT_LIGHT
)
canvas.create_window(550, 670, window=status_label)

# Decoratieve bouten in de hoeken
for x, y in [(330, 225), (770, 225), (330, 495), (770, 495)]:
    canvas.create_oval(x - 6, y - 6, x + 6, y + 6, fill="#555566", outline="", width=0)

# =========================
# FOOTER DETAILS (Naam & Logo)
# =========================
# Naam links onderaan
canvas.create_text(
    40, 670,
    text="LARS SCHRIJVERS  •  6META",
    font=("Arial", 12, "bold"),
    fill=TEXT_SUBTLE,
    anchor="w"
)

# School Logo proberen in te laden rechts onderaan
try:
    # Sla het image object op in het canvas om garbage collection te voorkomen
    origineel_logo = tk.PhotoImage(file="vtiz.png")
    
    # Schaalt het logo dynamisch. Pas deze getallen aan (bijv 2,2 of 4,4) 
    # als hij groter of kleiner moet zijn!
    canvas.vtiz_logo = origineel_logo.subsample(3, 3) 
    
    canvas.create_image(1060, 670, image=canvas.vtiz_logo, anchor="e")
except tk.TclError:
    # Fallback als vtiz.png niet gevonden wordt in dezelfde map
    canvas.create_text(
        1060, 670,
        text="VTI ZANDHOVEN",
        font=("Arial", 14, "bold"),
        fill=TEXT_SUBTLE,
        anchor="e"
    )

# Focus direct op het inputveld en start loop
entry.focus()
root.mainloop()