MODULE TestSponsVeiligTerug

    CONST num WA_AWAY_Z := 180;
    CONST num WA_ROT := 90;

    CONST num SPONGE_OFFSET_X := 11.0;
    CONST num SPONGE_OFFSET_Y := 167.2;
    CONST num SPONGE_OFFSET_Z := -56.5;

    CONST num PRE_BORD_Z := 20;
    CONST num CONTACT_EXTRA_Z := 27.5;

    CONST num CLEAN_LENGTH_X := 350;
    CONST num CLEAN_UP_Y := 30;

    VAR robtarget pStart;
    VAR robtarget pAway;
    VAR robtarget pRotated;

    VAR robtarget pTarget;
    VAR robtarget pZFar;
    VAR robtarget pCorrX;
    VAR robtarget pCorrY;
    VAR robtarget pPreBoard;
    VAR robtarget pTouch;

    VAR robtarget pRow1End;
    VAR robtarget pRow1Back;

    VAR robtarget pRow2Start;
    VAR robtarget pRow2End;
    VAR robtarget pRow2Back;

    VAR robtarget pRow3Start;
    VAR robtarget pRow3End;
    VAR robtarget pRow3Back;

    VAR robtarget pRetract;

    PROC TestSponsVeiligTerugStart()

        ! 1. Startplek onthouden
        pStart := CRobT(\Tool:=toolPen \WObj:=wobjPlexi);

        ! 2. Eerst weg van het bord
        pAway := pStart;
        pAway.trans.z := pStart.trans.z - WA_AWAY_Z;

        MoveL pAway, v100, z20, toolPen\WObj:=wobjPlexi;

        ! 3. Draaien naar spons-stand
        pRotated := RelTool(pAway, 0, 0, 0\Ry:=WA_ROT);

        MoveJ pRotated, v100, z20, toolPen\WObj:=wobjPlexi;

        ! 4. Doel berekenen: sponsmidden op oude penpunt
        pTarget := pStart;
        pTarget.rot := pRotated.rot;

        pTarget.trans.x := pStart.trans.x + SPONGE_OFFSET_X;
        pTarget.trans.y := pStart.trans.y + SPONGE_OFFSET_Y;
        pTarget.trans.z := pStart.trans.z + SPONGE_OFFSET_Z;

        ! 5. Ver van het bord blijven
        pZFar := pRotated;
        pZFar.trans.z := pTarget.trans.z - WA_AWAY_Z;

        MoveL pZFar, v100, z20, toolPen\WObj:=wobjPlexi;

        ! 6. X corrigeren
        pCorrX := pZFar;
        pCorrX.trans.x := pTarget.trans.x;

        MoveL pCorrX, v100, z20, toolPen\WObj:=wobjPlexi;

        ! 7. Y corrigeren
        pCorrY := pCorrX;
        pCorrY.trans.y := pTarget.trans.y;

        MoveL pCorrY, v100, z10, toolPen\WObj:=wobjPlexi;

        ! 8. Naar 2 cm voor het bord
        pPreBoard := pCorrY;
        pPreBoard.trans.z := pTarget.trans.z - PRE_BORD_Z;

        MoveL pPreBoard, v50, z5, toolPen\WObj:=wobjPlexi;

        ! 9. Tegen het bord komen
        pTouch := pPreBoard;
        pTouch.trans.z := pTarget.trans.z + CONTACT_EXTRA_Z;

        MoveL pTouch, v20, fine, toolPen\WObj:=wobjPlexi;

        ! =========================
        ! RIJ 1: HEEN EN TERUG
        ! =========================
        pRow1End := pTouch;
        pRow1End.trans.x := pTouch.trans.x + CLEAN_LENGTH_X;

        MoveL pRow1End, v80, z5, toolPen\WObj:=wobjPlexi;

        pRow1Back := pRow1End;
        pRow1Back.trans.x := pTouch.trans.x;

        MoveL pRow1Back, v80, z5, toolPen\WObj:=wobjPlexi;

        ! =========================
        ! RIJ 2: OMHOOG, HEEN EN TERUG
        ! =========================
        pRow2Start := pRow1Back;
        pRow2Start.trans.y := pRow1Back.trans.y + CLEAN_UP_Y;

        MoveL pRow2Start, v50, z5, toolPen\WObj:=wobjPlexi;

        pRow2End := pRow2Start;
        pRow2End.trans.x := pRow2Start.trans.x + CLEAN_LENGTH_X;

        MoveL pRow2End, v80, z5, toolPen\WObj:=wobjPlexi;

        pRow2Back := pRow2End;
        pRow2Back.trans.x := pRow2Start.trans.x;

        MoveL pRow2Back, v80, z5, toolPen\WObj:=wobjPlexi;

        ! =========================
        ! RIJ 3: OMHOOG, HEEN EN TERUG
        ! =========================
        pRow3Start := pRow2Back;
        pRow3Start.trans.y := pRow2Back.trans.y + CLEAN_UP_Y;

        MoveL pRow3Start, v50, z5, toolPen\WObj:=wobjPlexi;

        pRow3End := pRow3Start;
        pRow3End.trans.x := pRow3Start.trans.x + CLEAN_LENGTH_X;

        MoveL pRow3End, v80, z5, toolPen\WObj:=wobjPlexi;

        pRow3Back := pRow3End;
        pRow3Back.trans.x := pRow3Start.trans.x;

        MoveL pRow3Back, v80, z5, toolPen\WObj:=wobjPlexi;

        ! 10. Terug weg van het bord
        pRetract := pRow3Back;
        pRetract.trans.z := pRow3Back.trans.z - WA_AWAY_Z;

        MoveL pRetract, v100, z20, toolPen\WObj:=wobjPlexi;

        ! 11. Terug naar veilige positie met spons-stand
        MoveJ pRotated, v100, z20, toolPen\WObj:=wobjPlexi;

        ! 12. Terugdraaien naar pen-stand
        MoveJ pAway, v100, z20, toolPen\WObj:=wobjPlexi;

        ! 13. Terug naar originele beginpunt met pen
        MoveL pStart, v100, fine, toolPen\WObj:=wobjPlexi;

    ENDPROC

ENDMODULE