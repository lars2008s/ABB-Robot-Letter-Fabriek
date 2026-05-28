MODULE AlphabetWriterMod

    CONST num WA_PEN_PUSH := 5;
    CONST num WA_PEN_LIFT := 10;
    CONST num WA_LETTER_H := 80;
    CONST num WA_LETTER_W := 40;
    CONST num WA_LETTER_SPACING := 20;

    CONST num WA_AWAY_Z := 180;
    CONST num WA_ROT := 90;

    CONST num SPONGE_OFFSET_X := 11.0;
    CONST num SPONGE_OFFSET_Y := 167.2;
    CONST num SPONGE_OFFSET_Z := -56.5;

    CONST num PRE_BORD_Z := 20;
    CONST num CONTACT_EXTRA_Z := 37.5;

    CONST num CLEAN_LENGTH_X := 350;
    CONST num CLEAN_UP_Y := 30;

    PROC PenDown(VAR robtarget p)
        p.trans.x := p.trans.x + WA_PEN_LIFT + WA_PEN_PUSH;
        MoveL p, v100, fine, toolPen;
    ENDPROC

    PROC PenUp(VAR robtarget p)
        p.trans.x := p.trans.x - WA_PEN_PUSH - WA_PEN_LIFT;
        MoveL p, v100, fine, toolPen;
    ENDPROC

    PROC MoveFreeY(VAR robtarget p, num dy)
        p.trans.y := p.trans.y + dy;
        MoveL p, v100, fine, toolPen;
    ENDPROC

    PROC MoveFreeZ(VAR robtarget p, num dz)
        p.trans.z := p.trans.z + dz;
        MoveL p, v100, fine, toolPen;
    ENDPROC

    PROC NextLetter(VAR robtarget p)
        p.trans.y := p.trans.y + WA_LETTER_W + WA_LETTER_SPACING;
        MoveL p, v100, fine, toolPen;
    ENDPROC

    PROC DrawY(VAR robtarget p, num dy)
        PenDown p;
        p.trans.y := p.trans.y + dy;
        MoveL p, v100, fine, toolPen;
        PenUp p;
    ENDPROC

    PROC DrawZLine(VAR robtarget p, num dz)
        PenDown p;
        p.trans.z := p.trans.z + dz;
        MoveL p, v100, fine, toolPen;
        PenUp p;
    ENDPROC

    PROC DrawDiagYZ(VAR robtarget p, num dy, num dz)
        PenDown p;
        p.trans.y := p.trans.y + dy;
        p.trans.z := p.trans.z + dz;
        MoveL p, v100, fine, toolPen;
        PenUp p;
    ENDPROC

    PROC DrawA(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        DrawDiagYZ p, WA_LETTER_W / 2, WA_LETTER_H;
        DrawDiagYZ p, WA_LETTER_W / 2, -WA_LETTER_H;
        MoveFreeY p, -(3 * WA_LETTER_W / 4);
        MoveFreeZ p, WA_LETTER_H / 2;
        DrawY p, WA_LETTER_W / 2;
        p := pStart;
    ENDPROC

    PROC DrawB(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        DrawZLine p, WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        DrawZLine p, -(WA_LETTER_H / 2);
        DrawY p, -WA_LETTER_W;
        DrawY p, WA_LETTER_W;
        DrawZLine p, -(WA_LETTER_H / 2);
        DrawY p, -WA_LETTER_W;
        p := pStart;
    ENDPROC

    PROC DrawC(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        MoveFreeZ p, WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        MoveFreeY p, -WA_LETTER_W;
        DrawZLine p, -WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        p := pStart;
    ENDPROC

    PROC DrawD(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        DrawZLine p, WA_LETTER_H;
        DrawY p, (3 * WA_LETTER_W) / 4;
        MoveFreeZ p, -WA_LETTER_H;
        MoveFreeY p, WA_LETTER_W / 4;
        DrawZLine p, WA_LETTER_H;
        MoveFreeZ p, -WA_LETTER_H;
        DrawY p, -WA_LETTER_W;
        p := pStart;
    ENDPROC

    PROC DrawE(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        DrawZLine p, WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        MoveFreeY p, -WA_LETTER_W;
        MoveFreeZ p, -(WA_LETTER_H / 2);
        DrawY p, WA_LETTER_W;
        MoveFreeY p, -WA_LETTER_W;
        MoveFreeZ p, -(WA_LETTER_H / 2);
        DrawY p, WA_LETTER_W;
        p := pStart;
    ENDPROC

    PROC DrawF(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        DrawZLine p, WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        MoveFreeY p, -WA_LETTER_W;
        MoveFreeZ p, -(WA_LETTER_H / 2);
        DrawY p, WA_LETTER_W;
        p := pStart;
    ENDPROC

    PROC DrawG(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        MoveFreeZ p, WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        MoveFreeY p, -WA_LETTER_W;
        DrawZLine p, -WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        MoveFreeY p, -WA_LETTER_W / 2;
        MoveFreeZ p, WA_LETTER_H / 2;
        DrawY p, WA_LETTER_W / 2;
        DrawZLine p, -WA_LETTER_H / 2;
        p := pStart;
    ENDPROC

    PROC DrawH(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        DrawZLine p, WA_LETTER_H;
        MoveFreeY p, WA_LETTER_W;
        DrawZLine p, -WA_LETTER_H;
        MoveFreeZ p, WA_LETTER_H / 2;
        DrawY p, -WA_LETTER_W;
        p := pStart;
    ENDPROC

    PROC DrawI(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        MoveFreeY p, WA_LETTER_W / 2;
        DrawZLine p, WA_LETTER_H;
        p := pStart;
    ENDPROC

    PROC DrawJ(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        MoveFreeY p, WA_LETTER_W / 2;
        MoveFreeZ p, WA_LETTER_H;
        DrawZLine p, -WA_LETTER_H;
        DrawY p, -(WA_LETTER_W / 2);
        p := pStart;
    ENDPROC

    PROC DrawK(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        DrawZLine p, WA_LETTER_H;
        MoveFreeZ p, -(WA_LETTER_H / 2);
        DrawDiagYZ p, WA_LETTER_W, WA_LETTER_H / 2;
        MoveFreeY p, -WA_LETTER_W;
        MoveFreeZ p, -(WA_LETTER_H / 2);
        DrawDiagYZ p, WA_LETTER_W, -(WA_LETTER_H / 2);
        p := pStart;
    ENDPROC

    PROC DrawL(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        DrawZLine p, WA_LETTER_H;
        MoveFreeZ p, -WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        MoveFreeY p, -WA_LETTER_W;
        p := pStart;
    ENDPROC

    PROC DrawM(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        DrawZLine p, WA_LETTER_H;
        DrawDiagYZ p, WA_LETTER_W / 2, -WA_LETTER_H / 2;
        DrawDiagYZ p, WA_LETTER_W / 2, WA_LETTER_H / 2;
        DrawZLine p, -WA_LETTER_H;
        p := pStart;
    ENDPROC

    PROC DrawN(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        DrawZLine p, WA_LETTER_H;
        DrawDiagYZ p, WA_LETTER_W, -WA_LETTER_H;
        DrawZLine p, WA_LETTER_H;
        p := pStart;
    ENDPROC

    PROC DrawO(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        DrawZLine p, WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        DrawZLine p, -WA_LETTER_H;
        DrawY p, -WA_LETTER_W;
        p := pStart;
    ENDPROC

    PROC DrawP(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        DrawZLine p, WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        DrawZLine p, -(WA_LETTER_H / 2);
        DrawY p, -WA_LETTER_W;
        p := pStart;
    ENDPROC

    PROC DrawQ(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        DrawZLine p, WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        DrawZLine p, -WA_LETTER_H;
        DrawY p, -WA_LETTER_W;
        MoveFreeY p, WA_LETTER_W / 2;
        MoveFreeZ p, WA_LETTER_H / 2;
        DrawDiagYZ p, WA_LETTER_W / 2, -(WA_LETTER_H / 2);
        p := pStart;
    ENDPROC

    PROC DrawR(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        DrawZLine p, WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        DrawZLine p, -(WA_LETTER_H / 2);
        DrawY p, -WA_LETTER_W;
        DrawDiagYZ p, WA_LETTER_W, -(WA_LETTER_H / 2);
        p := pStart;
    ENDPROC

    PROC DrawT(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        MoveFreeY p, WA_LETTER_W / 2;
        DrawZLine p, WA_LETTER_H;
        MoveFreeY p, -(WA_LETTER_W / 2);
        DrawY p, WA_LETTER_W;
        p := pStart;
    ENDPROC

    PROC DrawU(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        MoveFreeZ p, WA_LETTER_H;
        DrawZLine p, -WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        DrawZLine p, WA_LETTER_H;
        p := pStart;
    ENDPROC

    PROC DrawS(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        MoveFreeZ p, WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        MoveFreeY p, -WA_LETTER_W;
        DrawZLine p, -(WA_LETTER_H / 2);
        DrawY p, WA_LETTER_W;
        DrawZLine p, -(WA_LETTER_H / 2);
        DrawY p, -WA_LETTER_W;
        p := pStart;
    ENDPROC

    PROC DrawV(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        MoveFreeZ p, WA_LETTER_H;
        DrawDiagYZ p, WA_LETTER_W / 2, -WA_LETTER_H;
        DrawDiagYZ p, WA_LETTER_W / 2, WA_LETTER_H;
        p := pStart;
    ENDPROC

    PROC DrawW(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        MoveFreeZ p, WA_LETTER_H;
        DrawDiagYZ p, WA_LETTER_W / 4, -WA_LETTER_H;
        DrawDiagYZ p, WA_LETTER_W / 4, WA_LETTER_H / 2;
        DrawDiagYZ p, WA_LETTER_W / 4, -(WA_LETTER_H / 2);
        DrawDiagYZ p, WA_LETTER_W / 4, WA_LETTER_H;
        p := pStart;
    ENDPROC

    PROC DrawX(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        MoveFreeZ p, WA_LETTER_H;
        DrawDiagYZ p, WA_LETTER_W, -WA_LETTER_H;
        MoveFreeY p, -WA_LETTER_W;
        DrawDiagYZ p, WA_LETTER_W, WA_LETTER_H;
        p := pStart;
    ENDPROC

    PROC DrawLetterY(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        MoveFreeZ p, WA_LETTER_H;
        DrawDiagYZ p, WA_LETTER_W / 2, -(WA_LETTER_H / 2);
        DrawDiagYZ p, WA_LETTER_W / 2, WA_LETTER_H / 2;
        MoveFreeY p, -(WA_LETTER_W / 2);
        MoveFreeZ p, -(WA_LETTER_H / 2);
        DrawZLine p, -(WA_LETTER_H / 2);
        p := pStart;
    ENDPROC

    PROC DrawZ(VAR robtarget p)
        VAR robtarget pStart;
        pStart := p;
        MoveFreeZ p, WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        DrawDiagYZ p, -WA_LETTER_W, -WA_LETTER_H;
        DrawY p, WA_LETTER_W;
        p := pStart;
    ENDPROC

    PROC DrawChar(VAR robtarget p, string ch)
        IF ch = "A" THEN
            DrawA p;
        ELSEIF ch = "B" THEN
            DrawB p;
        ELSEIF ch = "C" THEN
            DrawC p;
        ELSEIF ch = "D" THEN
            DrawD p;
        ELSEIF ch = "E" THEN
            DrawE p;
        ELSEIF ch = "F" THEN
            DrawF p;
        ELSEIF ch = "G" THEN
            DrawG p;
        ELSEIF ch = "H" THEN
            DrawH p;
        ELSEIF ch = "I" THEN
            DrawI p;
        ELSEIF ch = "J" THEN
            DrawJ p;
        ELSEIF ch = "K" THEN
            DrawK p;
        ELSEIF ch = "L" THEN
            DrawL p;
        ELSEIF ch = "M" THEN
            DrawM p;
        ELSEIF ch = "N" THEN
            DrawN p;
        ELSEIF ch = "O" THEN
            DrawO p;
        ELSEIF ch = "P" THEN
            DrawP p;
        ELSEIF ch = "Q" THEN
            DrawQ p;
        ELSEIF ch = "R" THEN
            DrawR p;
        ELSEIF ch = "S" THEN
            DrawS p;
        ELSEIF ch = "T" THEN
            DrawT p;
        ELSEIF ch = "U" THEN
            DrawU p;
        ELSEIF ch = "V" THEN
            DrawV p;
        ELSEIF ch = "W" THEN
            DrawW p;
        ELSEIF ch = "X" THEN
            DrawX p;
        ELSEIF ch = "Y" THEN
            DrawLetterY p;
        ELSEIF ch = "Z" THEN
            DrawZ p;
        ELSEIF ch = " " THEN
            NextLetter p;
        ENDIF
    ENDPROC

    PROC WriteText(VAR robtarget p, string txt)
        VAR num i;
        VAR num n;
        VAR string ch;

        n := StrLen(txt);

        FOR i FROM 1 TO n DO
            ch := StrPart(txt, i, 1);
            DrawChar p, ch;

            IF i < n THEN
                IF ch <> " " THEN
                    NextLetter p;
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    PROC TestSponsVeiligTerugStart()
        VAR robtarget spStart;
        VAR robtarget spAway;
        VAR robtarget spRotated;

        VAR robtarget spTarget;
        VAR robtarget spXFar;
        VAR robtarget spCorrY;
        VAR robtarget spCorrZ;
        VAR robtarget spPreBoard;
        VAR robtarget spTouch;

        VAR robtarget spRow1End;
        VAR robtarget spRow1Back;

        VAR robtarget spRow2Start;
        VAR robtarget spRow2End;
        VAR robtarget spRow2Back;

        VAR robtarget spRow3Start;
        VAR robtarget spRow3End;
        VAR robtarget spRow3Back;

        VAR robtarget spRetract;

        ! 1. Startplek onthouden
        spStart := CRobT(\Tool:=toolPen);

        ! 2. Eerst weg van het bord
        ! Zonder workobject is X de richting naar/van het bord
        spAway := spStart;
        spAway.trans.x := spStart.trans.x - WA_AWAY_Z;

        MoveL spAway, v100, z20, toolPen;

        ! 3. Draaien naar spons-stand
        spRotated := RelTool(spAway, 0, 0, 0\Ry:=WA_ROT);

        MoveJ spRotated, v100, z20, toolPen;

        ! 4. Doel berekenen: oude wobj-offsets omzetten naar gewone robotassen
        ! Oude wobj X = horizontaal  -> nieuwe Y
        ! Oude wobj Y = omhoog       -> nieuwe Z
        ! Oude wobj Z = borddiepte   -> nieuwe X
        spTarget := spStart;
        spTarget.rot := spRotated.rot;

        spTarget.trans.x := spStart.trans.x + SPONGE_OFFSET_Z;
        spTarget.trans.y := spStart.trans.y + SPONGE_OFFSET_X;
        spTarget.trans.z := spStart.trans.z + SPONGE_OFFSET_Y;

        ! 5. Ver van het bord blijven
        spXFar := spRotated;
        spXFar.trans.x := spTarget.trans.x - WA_AWAY_Z;

        MoveL spXFar, v100, z20, toolPen;

        ! 6. Horizontaal corrigeren
        spCorrY := spXFar;
        spCorrY.trans.y := spTarget.trans.y;

        MoveL spCorrY, v100, z20, toolPen;

        ! 7. Hoogte corrigeren
        spCorrZ := spCorrY;
        spCorrZ.trans.z := spTarget.trans.z;

        MoveL spCorrZ, v100, z10, toolPen;

        ! 8. Naar 2 cm voor het bord
        spPreBoard := spCorrZ;
        spPreBoard.trans.x := spTarget.trans.x - PRE_BORD_Z;

        MoveL spPreBoard, v50, z5, toolPen;

        ! 9. Tegen het bord komen
        spTouch := spPreBoard;
        spTouch.trans.x := spTarget.trans.x + CONTACT_EXTRA_Z;

        MoveL spTouch, v20, fine, toolPen;

        ! =========================
        ! RIJ 1: HEEN EN TERUG
        ! =========================
        ! Zonder workobject is Y horizontaal
        spRow1End := spTouch;
        spRow1End.trans.y := spTouch.trans.y + CLEAN_LENGTH_X;

        MoveL spRow1End, v80, z5, toolPen;

        spRow1Back := spRow1End;
        spRow1Back.trans.y := spTouch.trans.y;

        MoveL spRow1Back, v80, z5, toolPen;

        ! =========================
        ! RIJ 2: OMHOOG, HEEN EN TERUG
        ! =========================
        ! Zonder workobject is Z omhoog
        spRow2Start := spRow1Back;
        spRow2Start.trans.z := spRow1Back.trans.z + CLEAN_UP_Y;

        MoveL spRow2Start, v50, z5, toolPen;

        spRow2End := spRow2Start;
        spRow2End.trans.y := spRow2Start.trans.y + CLEAN_LENGTH_X;

        MoveL spRow2End, v80, z5, toolPen;

        spRow2Back := spRow2End;
        spRow2Back.trans.y := spRow2Start.trans.y;

        MoveL spRow2Back, v80, z5, toolPen;

        ! =========================
        ! RIJ 3: OMHOOG, HEEN EN TERUG
        ! =========================
        spRow3Start := spRow2Back;
        spRow3Start.trans.z := spRow2Back.trans.z + CLEAN_UP_Y;

        MoveL spRow3Start, v50, z5, toolPen;

        spRow3End := spRow3Start;
        spRow3End.trans.y := spRow3Start.trans.y + CLEAN_LENGTH_X;

        MoveL spRow3End, v80, z5, toolPen;

        spRow3Back := spRow3End;
        spRow3Back.trans.y := spRow3Start.trans.y;

        MoveL spRow3Back, v80, z5, toolPen;

        ! 10. Terug weg van het bord
        spRetract := spRow3Back;
        spRetract.trans.x := spRow3Back.trans.x - WA_AWAY_Z;

        MoveL spRetract, v100, z20, toolPen;

        ! 11. Terug naar veilige positie met spons-stand
        MoveJ spRotated, v100, z20, toolPen;

        ! 12. Terugdraaien naar pen-stand
        MoveJ spAway, v100, z20, toolPen;

        ! 13. Terug naar originele beginpunt met pen
        MoveL spStart, v100, fine, toolPen;

    ENDPROC

    PROC WriteTestName()
        VAR robtarget p;
        VAR robtarget pBegin;
        VAR string naam;

        ConfL \Off;
        SingArea \Wrist;

        naam := "LARS";
        p := CRobT(\Tool:=toolPen);
        pBegin := p;

        WriteText p, naam;

        ! terug naar startpositie
        MoveL pBegin, v100, fine, toolPen;

        ! 10 seconden wachten
        WaitTime 10;

        ! afkuisen
        TestSponsVeiligTerugStart;

        TPWrite "Naam klaar";
    ENDPROC

    PROC WriteNameFromFile()
        VAR robtarget p;
        VAR robtarget pBegin;
        VAR iodev f;
        VAR string naam;

        ConfL \Off;
        SingArea \Wrist;

        p := CRobT(\Tool:=toolPen);
        pBegin := p;

        Open "HOME:/naam.doc", f \Read;
        naam := ReadStr(f);
        Close f;

        ! Bestand meteen verwijderen nadat het gelezen is
        RemoveFile "HOME:/naam.doc";

        WriteText p, naam;

        ! terug naar startpositie
        MoveL pBegin, v100, fine, toolPen;

        ! 10 seconden wachten
        WaitTime 10;

        ! afkuisen
        TestSponsVeiligTerugStart;

        TPWrite "Naam geschreven: " + naam;
    ENDPROC

    PROC MainLoop()
        WHILE TRUE DO
            IF IsFile("HOME:/naam.doc") THEN
                WriteNameFromFile;
            ELSE
                WaitTime 0.5;
            ENDIF
        ENDWHILE
    ENDPROC

ENDMODULE