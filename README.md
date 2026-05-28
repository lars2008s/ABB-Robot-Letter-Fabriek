# ABB Robot Letter Fabriek

Een interactief robotproject waarbij een gebruiker een naam invoert via een Python-interface. De naam wordt via FTP naar een ABB IRC5-controller gestuurd, waarna de robot de tekst kan verwerken en tekenen/schrijven op een whiteboard.

## Projectdoel

Het doel van dit project is om een ABB-robotarm te gebruiken als demonstratie-opstelling voor een opendeurdag of technische presentatie. Bezoekers kunnen hun naam invoeren en de robot schrijft deze naam op een whiteboard.

## Belangrijkste onderdelen

- Python GUI voor invoer van namen.
- FTP-communicatie naar de ABB-robotcontroller.
- RAPID-programma's voor robotbewegingen en verwerking.
- 3D-geprinte stifthouder voor een whiteboardmarker.
- Verslag en PowerPoint-presentatie voor documentatie.

## Repositorystructuur

```text
ABB-Robot-Letter-Fabriek/
├── docs/
│   ├── report/          # Eindverslag als PDF
│   ├── presentation/    # PowerPoint-presentatie
│   ├── brainstorm/      # Conceptkeuze en brainstorm
│   └── project_dossier.md
├── hardware/
│   ├── 3d_models/       # STL- en SolidWorks-bestanden
│   └── stifthouder_ontwerp.md
├── software/            # Python scripts en GUI
├── rapid/               # ABB RAPID robotprogramma's
└── examples/            # Voorbeeldbestanden zoals G-code/jobs
```

## Documentatie

- Eindverslag: `docs/report/ABB_Robot_Letter_Fabriek_verslag_final.pdf`
- Presentatie: `docs/presentation/ABB_Robot_Letter_Fabriek_presentatie.pptx`
- Technisch dossier: `docs/project_dossier.md`
- Conceptkeuze: `docs/brainstorm/concept_keuze.md`
- Stifthouder: `hardware/stifthouder_ontwerp.md`

## Benodigdheden

- ABB-robot met IRC5-controller.
- Laptop of Raspberry Pi met Python 3.
- Ethernetverbinding met de robotcontroller.
- FTP-toegang tot de robotcontroller.
- Whiteboardmarker en stifthouder.

## Netwerkinstellingen

De gebruikte testopstelling werkt met vaste IP-adressen:

- Robot: `192.168.125.1`
- PC/Raspberry Pi: `192.168.125.247`
- Subnetmasker: `255.255.255.0`

## Gebruik

1. Verbind de PC of Raspberry Pi met de ABB-controller via Ethernet.
2. Controleer de IP-instellingen.
3. Start de Python GUI:

```bash
python software/letter_fabriek_robot.py
```

4. Typ een naam in de interface.
5. De software uploadt `naam.doc` naar de robot via FTP.
6. Het RAPID-programma op de robot leest het bestand en voert de opdracht uit.

## Communicatieprincipe

Omdat de gebruikte ABB-controller geen PC Interface-licentie heeft, wordt er geen live socketverbinding gebruikt. In plaats daarvan werkt het systeem met een eenvoudige FTP-brievenbus:

1. De PC maakt een tekstbestand met de ingevoerde naam.
2. De PC uploadt dit bestand via FTP naar de robotcontroller.
3. De robot controleert of het bestand bestaat.
4. De robot leest de inhoud en verwijdert daarna het bestand.

## Status

Het project bevat werkende testbestanden, documentatie, robotprogramma's en software voor de demonstratie-opstelling. Voor gebruik op een echte robot moeten de TCP, werkobjecten, snelheden en veiligheidszones altijd opnieuw gecontroleerd worden.
