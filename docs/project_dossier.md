# Technisch Verslag: Communicatiebrug PC naar ABB Robot

## 1. Doelstelling

Het doel van dit project is om een **interactieve robot-opstelling** te realiseren. Een gebruiker typt een naam of commando in op een externe computer (PC of Raspberry Pi), waarna de ABB-robot deze informatie ontvangt en fysiek uitvoert (bijvoorbeeld het schrijven van de naam).

## 2. Hardware Opstelling

Om de communicatie mogelijk te maken, is de volgende netwerkconfiguratie opgezet:

* **Robot:** ABB IRC5 Controller
* **Besturing:** Laptop (later Raspberry Pi)
* **Verbinding:** Fysieke Ethernetkabel (UTP) aangesloten op de WAN/Service-poort van de controller.

**Netwerkinstellingen (Statische IP-adressen):**
Omdat er geen router aanwezig is, zijn de IP-adressen handmatig ingesteld om beide apparaten in hetzelfde subnet te plaatsen:

* **IP-adres Robot:** `192.168.125.1`
* **IP-adres PC:** `192.168.125.247`
* **Subnetmasker:** `255.255.255.0`

## 3. Probleemanalyse

In eerste instantie werd geprobeerd om communicatie op te zetten via **TCP/IP Sockets** (het "live" bellen tussen apparaten).

* **Foutmelding:** Tijdens het testen gaf de robot de melding: *"Het echosysteembestand bevat niet de vereiste optie."*
* **Oorzaak:** De robot beschikt niet over de betaalde softwarelicentie *616-1 PC Interface*. Hierdoor is het commando `SocketCreate` geblokkeerd.

## 4. De Oplossing: FTP "Brievenbus" Methode

Om dit probleem te omzeilen zonder extra kosten, is er een alternatief communicatieprotocol ontwikkeld op basis van **bestandsdeling (FTP)**.

**Het Concept:**
In plaats van een live telefoonverbinding, gebruiken we de harde schijf van de robot als een "brievenbus".

1. **De PC (Zender):** Maakt verbinding via FTP en plaatst een tekstbestand (`naam.doc`) in de map `HOME` van de robot.
2. **De Robot (Ontvanger):** Controleert continu zijn eigen harde schijf. Zodra hij het bestand ziet, leest hij de inhoud.
3. **Verwerking:** Na het lezen verwijdert de robot het bestand direct, zodat hij klaar is voor een nieuw commando.

## 5. Software Implementatie

### A. Python Script (Op de PC)

Het script maakt gebruik van de `ftplib` bibliotheek.

* **Verbinden:** Login op `192.168.125.1` (User: abb, Pass: abb).
* **Uploaden:** De ingetypt naam wordt omgezet naar bytes en geüpload als `naam.doc`.

### B. RAPID Programma (Op de Robot)

De robot draait een **Polling Loop** (een oneindige lus die wacht op input).

**Pseudocode van de logica:**

```rapid
WHILE TRUE DO
    IF IsFile("HOME:/naam.doc") THEN
        ! 1. Bestand gevonden: Openen en lezen
        Open "HOME:/naam.doc", bestand \Read;
        ontvangen_naam := ReadStr(bestand);
        Close bestand;
        
        ! 2. Actie uitvoeren
        TPWrite "Opdracht ontvangen: " + ontvangen_naam;
        
        ! 3. Bestand verwijderen (Reset)
        RemoveFile "HOME:/naam.doc";
    ELSE
        ! Geen bestand? Wacht 0.5 seconde en kijk opnieuw
        WaitTime 0.5;
    ENDIF
ENDWHILE
```

## 6. Resultaat en Conclusie

De communicatie is succesvol getest.

1. De PC kan tekst versturen.
2. Het bestand verschijnt fysiek op de robotcontroller.
3. De robot leest de tekst uit en toont deze op de FlexPendant.
4. Het bestand wordt automatisch verwijderd om een lus te voorkomen.

Met deze methode is een robuuste dataverbinding gerealiseerd zonder dat hiervoor de dure *PC Interface* licentie nodig was. Dit maakt de weg vrij voor de volgende stap: het laten bewegen van de robot op basis van de input.