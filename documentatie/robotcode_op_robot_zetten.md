# RAPID-code op de ABB-robot zetten

Deze handleiding legt uit hoe de `.mod`-bestanden uit deze repository op de ABB IRC5-controller gezet worden.

## Belangrijk

Het Python-programma zet niet automatisch de robotlogica op de robot. Python uploadt alleen een klein tekstbestand met de ingevoerde naam. De robot moet vooraf al een RAPID-programma geladen hebben dat dit bestand controleert, leest en verwerkt.

## Benodigdheden

- ABB IRC5-controller.
- FlexPendant of RobotStudio.
- Laptop met Ethernetverbinding naar de controller.
- RAPID-module uit de map `robotcode/`.

## Methode 1: Via RobotStudio

1. Verbind de laptop met de robotcontroller via Ethernet.
2. Controleer dat de laptop in hetzelfde subnet zit als de robot.
3. Open RobotStudio.
4. Maak verbinding met de controller.
5. Open de RAPID-editor of de controllerbestanden.
6. Importeer of kopieer het gewenste `.mod`-bestand uit `robotcode/`.
7. Laad de module in de juiste task, meestal `T_ROB1`.
8. Controleer of de procedures zichtbaar zijn in de RAPID-editor.
9. Sla de wijzigingen op de controller op.

## Methode 2: Via FTP naar de controller

1. Verbind de laptop met de controller via Ethernet.
2. Open een FTP-client of gebruik Windows Verkenner met `ftp://192.168.125.1`.
3. Log in met de robotgebruiker, bijvoorbeeld `abb` / `abb` als dit zo ingesteld is op de controller.
4. Kopieer het gewenste `.mod`-bestand naar `HOME:` of een projectmap op de controller.
5. Ga op de FlexPendant naar de RAPID-programma's.
6. Laad de gekopieerde module in `T_ROB1`.

## Testen op de robot

1. Zet de robot in manual mode.
2. Zet de snelheid laag.
3. Controleer de noodstop en vrije robotruimte.
4. Controleer de TCP-instelling van de stift.
5. Controleer het workobject van het whiteboard.
6. Voer de bewegingen eerst stap voor stap uit.
7. Start pas daarna de polling loop die wacht op `HOME:/naam.doc`.

## Samenwerking met Python

Als de RAPID-module draait, kan de Python GUI gebruikt worden:

```bash
python programmatuur/letter_fabriek_robot.py
```

De GUI uploadt `naam.doc` naar de robot. Het RAPID-programma leest dit bestand, voert de actie uit en verwijdert het bestand daarna.

## Veiligheidscontrole

Controleer altijd opnieuw:

- TCP van de marker.
- Workobject van het whiteboard.
- Snelheden.
- Zones.
- Robotbereik.
- Botsingsgevaar met whiteboard, tafel, mensen of stifthouder.
