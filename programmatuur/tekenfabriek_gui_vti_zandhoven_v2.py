import tkinter as tk
from tkinter import messagebox

MAX_CHARS = 6


class TekenFabriekV2:
    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title("VTI Zandhoven - Tekenfabriek v2")
        self.root.geometry("1280x800")
        self.root.configure(bg="#F7F1E3")
        self.root.attributes("-fullscreen", True)
        self.root.bind("<Escape>", lambda e: self.root.destroy())

        self.name_var = tk.StringVar()
        self.status_var = tk.StringVar(value="Typ je naam in en druk op START")
        self.big_preview_var = tk.StringVar(value="_ _ _ _ _ _")
        self.is_busy = False
        self.anim_step = 0

        self.letter_labels = []
        self.progress_segments = []

        self._build_ui()
        self._update_name_display()

    def _build_ui(self):
        self.root.grid_columnconfigure(0, weight=3)
        self.root.grid_columnconfigure(1, weight=2)
        self.root.grid_rowconfigure(1, weight=1)

        header = tk.Frame(self.root, bg="#F7F1E3", height=120)
        header.grid(row=0, column=0, columnspan=2, sticky="nsew", padx=25, pady=(18, 5))
        header.grid_columnconfigure(0, weight=1)

        tk.Label(
            header,
            text="TEKENFABRIEK",
            font=("Arial Rounded MT Bold", 40, "bold"),
            fg="#E4572E",
            bg="#F7F1E3",
        ).pack()

        tk.Label(
            header,
            text="Laat de robot jouw naam tekenen!",
            font=("Arial", 21, "bold"),
            fg="#21406A",
            bg="#F7F1E3",
        ).pack(pady=(6, 0))

        content_left = tk.Frame(self.root, bg="#F7F1E3")
        content_left.grid(row=1, column=0, sticky="nsew", padx=(25, 12), pady=10)
        content_left.grid_rowconfigure(0, weight=1)
        content_left.grid_columnconfigure(0, weight=1)

        content_right = tk.Frame(self.root, bg="#F7F1E3")
        content_right.grid(row=1, column=1, sticky="nsew", padx=(12, 25), pady=10)
        content_right.grid_rowconfigure(0, weight=1)
        content_right.grid_columnconfigure(0, weight=1)

        self.canvas = tk.Canvas(
            content_left,
            bg="#FFFDF8",
            highlightthickness=5,
            highlightbackground="#E7C46A",
            relief="flat",
        )
        self.canvas.grid(row=0, column=0, sticky="nsew")

        self.right_panel = tk.Frame(
            content_right,
            bg="#FFFFFF",
            highlightthickness=5,
            highlightbackground="#5F6670",
        )
        self.right_panel.grid(row=0, column=0, sticky="nsew")
        self.right_panel.grid_columnconfigure(0, weight=1)

        self._build_right_panel()
        self.root.update_idletasks()
        self._draw_scene()
        self.canvas.bind("<Configure>", lambda e: self._draw_scene())

    def _build_right_panel(self):
        panel = self.right_panel

        tk.Label(
            panel,
            text="Naam invoeren",
            font=("Arial Rounded MT Bold", 28, "bold"),
            fg="#21406A",
            bg="#FFFFFF",
        ).grid(row=0, column=0, pady=(30, 8), padx=24)

        tk.Label(
            panel,
            text="Maximaal 6 letters of cijfers",
            font=("Arial", 15),
            fg="#6D7C93",
            bg="#FFFFFF",
        ).grid(row=1, column=0, pady=(0, 16))

        boxes = tk.Frame(panel, bg="#FFFFFF")
        boxes.grid(row=2, column=0, padx=28, sticky="ew")
        for i in range(MAX_CHARS):
            boxes.grid_columnconfigure(i, weight=1)

        for i in range(MAX_CHARS):
            lbl = tk.Label(
                boxes,
                text="",
                font=("Arial Rounded MT Bold", 30, "bold"),
                bg="#EFF2F6",
                fg="#21406A",
                width=2,
                height=2,
                relief="flat",
                bd=0,
            )
            lbl.grid(row=0, column=i, padx=6, pady=6, sticky="nsew")
            self.letter_labels.append(lbl)

        self.entry = tk.Entry(
            panel,
            textvariable=self.name_var,
            font=("Arial", 1),
            bg="#FFFFFF",
            fg="#FFFFFF",
            insertbackground="#FFFFFF",
            relief="flat",
            bd=0,
            width=1,
        )
        self.entry.grid(row=3, column=0)
        self.entry.focus_set()
        self.entry.bind("<KeyRelease>", self._on_text_change)
        self.entry.bind("<Return>", self._submit_name)

        tap_frame = tk.Frame(panel, bg="#FFFFFF")
        tap_frame.grid(row=4, column=0, pady=(8, 10))
        tk.Label(
            tap_frame,
            text="Klik hier en typ je naam",
            font=("Arial", 14, "bold"),
            fg="#E4572E",
            bg="#FFFFFF",
        ).pack()
        tk.Button(
            tap_frame,
            text="TYPEN",
            command=lambda: self.entry.focus_set(),
            font=("Arial Rounded MT Bold", 14, "bold"),
            bg="#2E86AB",
            fg="white",
            relief="flat",
            bd=0,
            padx=24,
            pady=10,
            cursor="hand2",
        ).pack(pady=(8, 0))

        tk.Label(
            panel,
            text="Preview",
            font=("Arial", 14, "bold"),
            fg="#6D7C93",
            bg="#FFFFFF",
        ).grid(row=5, column=0, pady=(8, 8))

        self.preview_box = tk.Label(
            panel,
            textvariable=self.big_preview_var,
            font=("Arial Rounded MT Bold", 28, "bold"),
            bg="#F5EBCB",
            fg="#21406A",
            relief="flat",
            bd=0,
            pady=22,
        )
        self.preview_box.grid(row=6, column=0, padx=28, sticky="ew")

        btns = tk.Frame(panel, bg="#FFFFFF")
        btns.grid(row=7, column=0, padx=28, pady=(22, 10), sticky="ew")
        btns.grid_columnconfigure(0, weight=1)

        self.start_btn = tk.Button(
            btns,
            text="START ROBOT",
            command=self._submit_name,
            font=("Arial Rounded MT Bold", 24, "bold"),
            bg="#E4572E",
            fg="white",
            activebackground="#CB451F",
            activeforeground="white",
            relief="flat",
            bd=0,
            pady=20,
            cursor="hand2",
        )
        self.start_btn.grid(row=0, column=0, sticky="ew")

        self.reset_btn = tk.Button(
            btns,
            text="VOLGENDE NAAM",
            command=self._reset_all,
            font=("Arial Rounded MT Bold", 18, "bold"),
            bg="#2E86AB",
            fg="white",
            activebackground="#236985",
            activeforeground="white",
            relief="flat",
            bd=0,
            pady=14,
            cursor="hand2",
        )
        self.reset_btn.grid(row=1, column=0, sticky="ew", pady=(14, 0))

        status_frame = tk.Frame(
            panel,
            bg="#F5F7FA",
            highlightthickness=2,
            highlightbackground="#D7DFEA",
        )
        status_frame.grid(row=8, column=0, padx=28, pady=(22, 12), sticky="ew")

        tk.Label(
            status_frame,
            text="Status",
            font=("Arial", 13, "bold"),
            fg="#21406A",
            bg="#F5F7FA",
        ).pack(anchor="w", padx=14, pady=(12, 2))

        self.status_label = tk.Label(
            status_frame,
            textvariable=self.status_var,
            font=("Arial", 14),
            fg="#44546A",
            bg="#F5F7FA",
            wraplength=380,
            justify="left",
        )
        self.status_label.pack(anchor="w", padx=14, pady=(0, 12))

        footer = tk.Label(
            panel,
            text="Open deurdag • VTI Zandhoven • ESC = afsluiten",
            font=("Arial", 11, "italic"),
            fg="#8A94A6",
            bg="#FFFFFF",
        )
        footer.grid(row=9, column=0, pady=(0, 18))

    def _draw_scene(self):
        c = self.canvas
        c.delete("all")

        w = max(c.winfo_width(), 700)
        h = max(c.winfo_height(), 500)

        c.create_rectangle(0, 0, w, h, fill="#FFFDF8", outline="")
        c.create_rectangle(0, h - 130, w, h, fill="#CFE2BD", outline="")
        c.create_rectangle(0, h - 75, w, h, fill="#AFCF9E", outline="")

        c.create_text(
            60, 55,
            text="1. Typ je naam",
            anchor="w",
            font=("Arial Rounded MT Bold", 28, "bold"),
            fill="#E4572E",
        )
        c.create_text(
            60, 95,
            text="2. Druk op START",
            anchor="w",
            font=("Arial Rounded MT Bold", 28, "bold"),
            fill="#2E86AB",
        )
        c.create_text(
            60, 135,
            text="3. De robot tekent jouw naam",
            anchor="w",
            font=("Arial Rounded MT Bold", 28, "bold"),
            fill="#8AC926",
        )

        base_x, base_y = 180, h - 160
        c.create_rectangle(base_x - 90, base_y + 20, base_x + 110, base_y + 80, fill="#495057", outline="")
        for i in range(5):
            x = base_x - 70 + i * 42
            c.create_rectangle(x, base_y + 30, x + 22, base_y + 68, fill="#ADB5BD", outline="")

        c.create_oval(base_x - 55, base_y - 110, base_x + 45, base_y - 10, fill="#2E86AB", outline="")
        c.create_rectangle(base_x - 5, base_y - 180, base_x + 15, base_y - 75, fill="#2E86AB", outline="")
        c.create_rectangle(base_x + 10, base_y - 195, base_x + 145, base_y - 165, fill="#8AC926", outline="")
        c.create_rectangle(base_x + 130, base_y - 210, base_x + 160, base_y - 100, fill="#8AC926", outline="")
        c.create_rectangle(base_x + 150, base_y - 222, base_x + 260, base_y - 195, fill="#F4A261", outline="")
        c.create_rectangle(base_x + 250, base_y - 240, base_x + 278, base_y - 145, fill="#F4A261", outline="")
        c.create_line(base_x + 265, base_y - 145, base_x + 300, base_y - 105, fill="#21406A", width=6)
        c.create_line(base_x + 300, base_y - 105, base_x + 320, base_y - 70, fill="#21406A", width=4)
        c.create_oval(base_x + 312, base_y - 74, base_x + 326, base_y - 60, fill="#E4572E", outline="")

        self._gear(c, 165, 145, 42, "#2E86AB")
        self._gear(c, 300, 195, 34, "#8AC926")
        self._gear(c, 430, 140, 36, "#F4A261")

        c.create_rectangle(w - 360, 75, w - 80, 185, fill="#F4E6BE", outline="#E7C46A", width=4)
        c.create_text(
            w - 220, 130,
            text="Naam\ntekenzone",
            font=("Arial Rounded MT Bold", 29, "bold"),
            fill="#21406A",
            justify="center",
        )

        paper_left = w - 470
        paper_top = 240
        paper_right = w - 80
        paper_bottom = h - 110

        c.create_rectangle(paper_left, paper_top, paper_right, paper_bottom, fill="white", outline="#D0D7DE", width=4)
        c.create_text(
            (paper_left + paper_right) / 2,
            paper_top + 42,
            text="Robot schrijft:",
            font=("Arial Rounded MT Bold", 24, "bold"),
            fill="#5C677D",
        )

        c.create_text(
            (paper_left + paper_right) / 2,
            paper_top + 135,
            text=self.big_preview_var.get().replace(" ", ""),
            font=("Comic Sans MS", 38, "bold"),
            fill="#E4572E",
        )

        c.create_text(
            (paper_left + paper_right) / 2,
            paper_bottom - 75,
            text="Tekenvoortgang",
            font=("Arial", 18, "bold"),
            fill="#6D7C93",
        )

        start_x = paper_left + 35
        y = paper_bottom - 35
        self.progress_segments = []
        for i in range(MAX_CHARS):
            seg = c.create_rectangle(
                start_x + i * 55, y, start_x + i * 55 + 40, y + 20,
                fill="#E8EDF3", outline=""
            )
            self.progress_segments.append(seg)

        dots = [
            (40, 250, "#FFB703"), (85, 205, "#FB8500"), (255, 205, "#2E86AB"),
            (390, 200, "#FFB703"), (485, 140, "#E4572E"), (w - 120, 260, "#E4572E")
        ]
        for x, y, color in dots:
            c.create_oval(x - 12, y - 12, x + 12, y + 12, fill=color, outline="")

    def _gear(self, c, x, y, radius, color):
        import math
        for i in range(8):
            dx = (radius + 12) * math.cos(math.radians(i * 45))
            dy = (radius + 12) * math.sin(math.radians(i * 45))
            c.create_rectangle(x + dx - 8, y + dy - 8, x + dx + 8, y + dy + 8, fill=color, outline="")
        c.create_oval(x - radius, y - radius, x + radius, y + radius, fill=color, outline="")
        c.create_oval(x - 12, y - 12, x + 12, y + 12, fill="#FFFDF8", outline="")

    def _on_text_change(self, event=None):
        raw = self.name_var.get()
        filtered = "".join(ch for ch in raw if ch.isalnum())[:MAX_CHARS].upper()
        if raw != filtered:
            self.name_var.set(filtered)
        self._update_name_display()

    def _update_name_display(self):
        name = self.name_var.get().strip().upper()

        chars = list(name) + [""] * (MAX_CHARS - len(name))
        for i, lbl in enumerate(self.letter_labels):
            lbl.config(text=chars[i] if chars[i] else "_")

        preview = list(name) + ["_"] * (MAX_CHARS - len(name))
        self.big_preview_var.set(" ".join(preview))

        if not self.is_busy:
            if name:
                self.status_var.set("Ziet er goed uit. Druk op START om te tekenen.")
            else:
                self.status_var.set("Typ je naam in en druk op START")

        self._draw_scene()

    def _submit_name(self, event=None):
        if self.is_busy:
            return

        name = self.name_var.get().strip().upper()
        if not name:
            messagebox.showwarning("Nog geen naam", "Typ eerst je naam in.")
            self.entry.focus_set()
            return

        self.is_busy = True
        self.start_btn.config(state="disabled", text="TEKENEN...")
        self.status_var.set(f"Robot is bezig met {name} te tekenen...")
        self.anim_step = 0
        self._animate_progress(name)

    def _animate_progress(self, name):
        if self.anim_step < len(name):
            self._draw_scene()
            self.status_var.set(f"Robot tekent... letter {self.anim_step + 1} van {len(name)}")
            self.canvas.itemconfig(self.progress_segments[self.anim_step], fill="#E4572E")
            self.anim_step += 1
            self.root.after(450, lambda: self._animate_progress(name))
            return

        self.status_var.set(f"Klaar! {name} is verzonden naar de robot.")
        self.start_btn.config(state="normal", text="START ROBOT")
        self.is_busy = False
        self._send_to_robot_placeholder(name)

    def _send_to_robot_placeholder(self, name: str):
        """
        Zet hier straks je eigen robotkoppeling.
        Bijvoorbeeld:
            send_name_to_robot(name)
        """
        messagebox.showinfo(
            "Naam klaar",
            f"De robot zou nu deze naam ontvangen:\n\n{name}\n\n"
            "Vervang deze placeholder later door jouw robotcode."
        )

    def _reset_all(self):
        if self.is_busy:
            return
        self.name_var.set("")
        self.big_preview_var.set("_ _ _ _ _ _")
        self.status_var.set("Typ je naam in en druk op START")
        self.entry.focus_set()
        self._update_name_display()


if __name__ == "__main__":
    root = tk.Tk()
    app = TekenFabriekV2(root)
    root.mainloop()
