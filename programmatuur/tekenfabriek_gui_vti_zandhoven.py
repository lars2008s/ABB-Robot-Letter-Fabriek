import tkinter as tk
from tkinter import messagebox
import random

MAX_CHARS = 6


class TekenFabriekApp:
    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title("VTI Zandhoven - Tekenfabriek")
        self.root.geometry("1100x700")
        self.root.minsize(980, 620)
        self.root.configure(bg="#FFF7E8")

        self.name_var = tk.StringVar()
        self.status_var = tk.StringVar(value="Typ je naam en druk op START")
        self.char_count_var = tk.StringVar(value=f"0 / {MAX_CHARS}")

        self._build_ui()
        self._animate_gears()

    def _build_ui(self):
        title = tk.Label(
            self.root,
            text="TEKENFABRIEK",
            font=("Arial Rounded MT Bold", 32, "bold"),
            bg="#FFF7E8",
            fg="#E4572E",
        )
        title.pack(pady=(18, 2))

        subtitle = tk.Label(
            self.root,
            text="Laat de robot jouw naam tekenen!",
            font=("Arial", 18, "bold"),
            bg="#FFF7E8",
            fg="#2E4057",
        )
        subtitle.pack(pady=(0, 10))

        main = tk.Frame(self.root, bg="#FFF7E8")
        main.pack(fill="both", expand=True, padx=24, pady=8)

        left = tk.Frame(main, bg="#FFF7E8")
        left.pack(side="left", fill="both", expand=True, padx=(0, 12))

        right = tk.Frame(main, bg="#FFF7E8", width=340)
        right.pack(side="right", fill="y", padx=(12, 0))
        right.pack_propagate(False)

        # Factory / drawing area
        self.canvas = tk.Canvas(
            left,
            bg="#FFFDF6",
            highlightthickness=4,
            highlightbackground="#F3C969",
            relief="flat",
        )
        self.canvas.pack(fill="both", expand=True)

        self._draw_factory_scene()

        # Right control panel
        panel = tk.Frame(
            right,
            bg="#FFFFFF",
            highlightthickness=4,
            highlightbackground="#8AC926",
            bd=0,
        )
        panel.pack(fill="both", expand=True)

        panel_title = tk.Label(
            panel,
            text="Naam invoeren",
            font=("Arial Rounded MT Bold", 24, "bold"),
            bg="#FFFFFF",
            fg="#2E4057",
        )
        panel.pack_propagate(False)
        panel_title.pack(pady=(28, 10))

        info = tk.Label(
            panel,
            text="Maximaal 6 letters of cijfers",
            font=("Arial", 13),
            bg="#FFFFFF",
            fg="#5C677D",
        )
        info.pack(pady=(0, 14))

        entry_frame = tk.Frame(panel, bg="#FFFFFF")
        entry_frame.pack(padx=24, fill="x")

        self.entry = tk.Entry(
            entry_frame,
            textvariable=self.name_var,
            font=("Arial Rounded MT Bold", 26),
            justify="center",
            relief="flat",
            bd=0,
            bg="#F6F9FC",
            fg="#2E4057",
            insertbackground="#E4572E",
        )
        self.entry.pack(fill="x", ipady=18)
        self.entry.bind("<KeyRelease>", self._on_text_change)
        self.entry.bind("<Return>", self._submit_name)
        self.entry.focus_set()

        self.char_label = tk.Label(
            panel,
            textvariable=self.char_count_var,
            font=("Arial", 12, "bold"),
            bg="#FFFFFF",
            fg="#E4572E",
        )
        self.char_label.pack(pady=(10, 18))

        hint = tk.Label(
            panel,
            text="Voorbeelden: LARS, EMMA, NOAH",
            font=("Arial", 11),
            bg="#FFFFFF",
            fg="#7A8598",
        )
        hint.pack(pady=(0, 20))

        self.preview_label = tk.Label(
            panel,
            text="Jouw naam komt hier",
            font=("Arial Rounded MT Bold", 22, "bold"),
            bg="#FFF4D6",
            fg="#2E4057",
            width=18,
            height=2,
            relief="flat",
            bd=0,
        )
        self.preview_label.pack(padx=26, fill="x")

        buttons = tk.Frame(panel, bg="#FFFFFF")
        buttons.pack(pady=24, padx=24, fill="x")

        self.start_btn = tk.Button(
            buttons,
            text="START ROBOT",
            command=self._submit_name,
            font=("Arial Rounded MT Bold", 18, "bold"),
            bg="#E4572E",
            fg="white",
            activebackground="#CC4720",
            activeforeground="white",
            relief="flat",
            bd=0,
            cursor="hand2",
            pady=14,
        )
        self.start_btn.pack(fill="x", pady=(0, 12))

        clear_btn = tk.Button(
            buttons,
            text="WISSEN",
            command=self._clear_name,
            font=("Arial Rounded MT Bold", 15, "bold"),
            bg="#2E86AB",
            fg="white",
            activebackground="#256C8A",
            activeforeground="white",
            relief="flat",
            bd=0,
            cursor="hand2",
            pady=10,
        )
        clear_btn.pack(fill="x")

        status_box = tk.Frame(panel, bg="#F6F9FC", highlightthickness=2, highlightbackground="#D7E3F0")
        status_box.pack(fill="x", padx=24, pady=(24, 18))

        tk.Label(
            status_box,
            text="Status",
            font=("Arial", 12, "bold"),
            bg="#F6F9FC",
            fg="#2E4057",
        ).pack(anchor="w", padx=12, pady=(10, 2))

        tk.Label(
            status_box,
            textvariable=self.status_var,
            wraplength=260,
            justify="left",
            font=("Arial", 12),
            bg="#F6F9FC",
            fg="#44546A",
        ).pack(anchor="w", padx=12, pady=(0, 10))

        footer = tk.Label(
            panel,
            text="Open deurdag • VTI Zandhoven",
            font=("Arial", 10, "italic"),
            bg="#FFFFFF",
            fg="#8C96A8",
        )
        footer.pack(side="bottom", pady=16)

    def _draw_factory_scene(self):
        c = self.canvas
        c.delete("all")

        w = max(c.winfo_width(), 600)
        h = max(c.winfo_height(), 500)

        # Sky / background blocks
        c.create_rectangle(0, 0, w, h, fill="#FFFDF6", outline="")
        c.create_rectangle(0, h - 120, w, h, fill="#D9EBC8", outline="")
        c.create_rectangle(0, h - 70, w, h, fill="#B8D8A8", outline="")

        # Conveyor belt
        c.create_rectangle(60, h - 160, w - 60, h - 110, fill="#495057", outline="")
        for x in range(80, w - 80, 40):
            c.create_rectangle(x, h - 150, x + 18, h - 120, fill="#ADB5BD", outline="")

        # Robot arm base
        c.create_oval(80, h - 260, 200, h - 140, fill="#2E86AB", outline="")
        c.create_rectangle(130, h - 310, 150, h - 210, fill="#2E86AB", outline="")
        c.create_rectangle(145, h - 330, 250, h - 305, fill="#8AC926", outline="")
        c.create_rectangle(238, h - 350, 260, h - 270, fill="#8AC926", outline="")
        c.create_rectangle(250, h - 355, 320, h - 335, fill="#F4A261", outline="")
        c.create_rectangle(310, h - 365, 330, h - 310, fill="#F4A261", outline="")
        c.create_line(320, h - 310, 345, h - 275, fill="#2E4057", width=5)
        c.create_line(345, h - 275, 360, h - 250, fill="#2E4057", width=3)
        c.create_oval(352, h - 252, 366, h - 238, fill="#E4572E", outline="")

        # Sign
        c.create_rectangle(w - 270, 60, w - 70, 150, fill="#FFF4D6", outline="#F3C969", width=4)
        c.create_text(
            w - 170,
            90,
            text="Naam\ntekenzone",
            font=("Arial Rounded MT Bold", 24, "bold"),
            fill="#2E4057",
            justify="center",
        )

        # Paper sheet preview
        c.create_rectangle(w - 320, 200, w - 40, 410, fill="white", outline="#D0D7DE", width=3)
        c.create_text(
            w - 180,
            230,
            text="Robot schrijft:",
            font=("Arial", 18, "bold"),
            fill="#5C677D",
        )
        self.paper_name = c.create_text(
            w - 180,
            315,
            text="JOUW NAAM",
            font=("Comic Sans MS", 30, "bold"),
            fill="#E4572E",
        )

        # Decorative paint splashes
        colors = ["#FFB703", "#FB8500", "#8AC926", "#2E86AB", "#E4572E"]
        for _ in range(12):
            x = random.randint(30, w - 30)
            y = random.randint(20, h - 200)
            r = random.randint(5, 12)
            c.create_oval(x - r, y - r, x + r, y + r, fill=random.choice(colors), outline="")

        # Gears
        self.gear_items = []
        self.gear_items.append(self._create_gear(120, 110, 34, "#2E86AB"))
        self.gear_items.append(self._create_gear(190, 150, 24, "#8AC926"))
        self.gear_items.append(self._create_gear(280, 95, 28, "#F4A261"))

        c.create_text(
            80,
            35,
            anchor="w",
            text="Klik, tik, teken!",
            font=("Arial Rounded MT Bold", 22, "bold"),
            fill="#E4572E",
        )

    def _create_gear(self, x, y, radius, color):
        items = []
        for i in range(8):
            angle = i * 45
            dx = int((radius + 10) * self._cos_deg(angle))
            dy = int((radius + 10) * self._sin_deg(angle))
            tooth = self.canvas.create_rectangle(
                x + dx - 6, y + dy - 6, x + dx + 6, y + dy + 6,
                fill=color, outline=""
            )
            items.append(tooth)
        outer = self.canvas.create_oval(
            x - radius, y - radius, x + radius, y + radius,
            fill=color, outline=""
        )
        inner = self.canvas.create_oval(
            x - 10, y - 10, x + 10, y + 10,
            fill="#FFFDF6", outline=""
        )
        items.extend([outer, inner])
        return {"x": x, "y": y, "radius": radius, "angle": 0, "items": items, "color": color}

    def _animate_gears(self):
        for idx, gear in enumerate(self.gear_items):
            gear["angle"] += 6 if idx % 2 == 0 else -6
            self._redraw_gear(gear)
        self.root.after(120, self._animate_gears)

    def _redraw_gear(self, gear):
        for item in gear["items"]:
            self.canvas.delete(item)
        x, y, radius, color = gear["x"], gear["y"], gear["radius"], gear["color"]
        items = []
        for i in range(8):
            angle = gear["angle"] + i * 45
            dx = int((radius + 10) * self._cos_deg(angle))
            dy = int((radius + 10) * self._sin_deg(angle))
            tooth = self.canvas.create_rectangle(
                x + dx - 6, y + dy - 6, x + dx + 6, y + dy + 6,
                fill=color, outline=""
            )
            items.append(tooth)
        outer = self.canvas.create_oval(
            x - radius, y - radius, x + radius, y + radius,
            fill=color, outline=""
        )
        inner = self.canvas.create_oval(
            x - 10, y - 10, x + 10, y + 10,
            fill="#FFFDF6", outline=""
        )
        items.extend([outer, inner])
        gear["items"] = items

    def _on_text_change(self, event=None):
        raw = self.name_var.get()
        filtered = "".join(ch for ch in raw if ch.isalnum())[:MAX_CHARS].upper()

        if raw != filtered:
            self.name_var.set(filtered)

        name = self.name_var.get().strip()
        self.char_count_var.set(f"{len(name)} / {MAX_CHARS}")

        if name:
            self.preview_label.config(text=name)
            self.canvas.itemconfig(self.paper_name, text=name)
            self.status_var.set("Ziet er goed uit! Druk op START om te tekenen.")
        else:
            self.preview_label.config(text="Jouw naam komt hier")
            self.canvas.itemconfig(self.paper_name, text="JOUW NAAM")
            self.status_var.set("Typ je naam en druk op START")

    def _clear_name(self):
        self.name_var.set("")
        self._on_text_change()
        self.entry.focus_set()

    def _submit_name(self, event=None):
        name = self.name_var.get().strip().upper()

        if not name:
            messagebox.showwarning("Nog geen naam", "Typ eerst je naam in.")
            return

        if len(name) > MAX_CHARS:
            messagebox.showwarning("Te lang", f"Gebruik maximaal {MAX_CHARS} tekens.")
            return

        self.status_var.set(f"Naam '{name}' klaar voor de robot!")
        self._send_to_robot_placeholder(name)

    def _send_to_robot_placeholder(self, name: str):
        """
        Hier kun jij straks je eigen robotkoppeling zetten.
        Bijvoorbeeld:
            send_name_to_robot(name)
        """
        messagebox.showinfo(
            "Robot klaar",
            f"De robot zou nu deze naam krijgen:\n\n{name}\n\n"
            "Vervang de placeholder in de code later door jouw robotverbinding."
        )

    @staticmethod
    def _sin_deg(deg):
        import math
        return math.sin(math.radians(deg))

    @staticmethod
    def _cos_deg(deg):
        import math
        return math.cos(math.radians(deg))


if __name__ == "__main__":
    root = tk.Tk()
    app = TekenFabriekApp(root)
    root.mainloop()
