# RAPID

Deze map bevat ABB RAPID-programma's en testmodules voor de robot.

## Op de robot zetten

De `.mod`-bestanden moeten via RobotStudio, FlexPendant of FTP naar de ABB-controller gekopieerd worden. Daarna moet de module geladen worden in de juiste robot-task, meestal `T_ROB1`.

Zie `../docs/robot_upload.md` voor de volledige werkwijze.

Controleer voor uitvoering op een echte robot altijd:

- TCP-instelling van de stift.
- Werkobject en kalibratie van het whiteboard.
- Snelheden en zones.
- Veiligheidsgrenzen van de robotcel.
