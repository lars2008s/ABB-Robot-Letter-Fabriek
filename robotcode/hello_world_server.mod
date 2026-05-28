MODULE HelloWorldServer
    VAR iodev bestand;
    VAR string ontvangen_naam;

    PROC main()
        TPWrite "Robot wacht op brievenbus (FTP)...";
        
        WHILE TRUE DO
            ! Controleer of het bestand "naam.doc" bestaat in de HOME map
            IF IsFile("HOME:/naam.doc") THEN
                ! 1. Bestand gevonden: Openen en lezen
                Open "HOME:/naam.doc", bestand \Read;
                ontvangen_naam := ReadStr(bestand);
                Close bestand;
                
                ! 2. Actie uitvoeren op de FlexPendant
                TPWrite "Opdracht ontvangen: " + ontvangen_naam;
                
                ! 3. Bestand verwijderen om de robot klaar te zetten voor de volgende keer
                RemoveFile "HOME:/naam.doc";
                
                TPWrite "Bestand verwerkt en verwijderd.";
            ELSE
                ! Geen bestand? Wacht 0.5 seconde en kijk opnieuw (bespaart CPU)
                WaitTime 0.5;
            ENDIF
        ENDWHILE
    ERROR
        TPWrite "Er is een fout opgetreden.";
        RETRY;
    ENDPROC
ENDMODULE