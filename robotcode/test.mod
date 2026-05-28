MODULE AlphabetWriterMod

    CONST num WA_PEN_PUSH := 5;
    CONST num WA_PEN_LIFT := 10;
    CONST num WA_LETTER_H := 80;
    CONST num WA_LETTER_W := 40;
    CONST num WA_LETTER_SPACING := 20;

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

    PROC WriteTestName()
        VAR robtarget p;
        VAR string naam;

        ConfL \Off;
        SingArea \Wrist;

        naam := "LARS";
        p := CRobT(\Tool:=toolPen);

        WriteText p, naam;

        TPWrite "Naam klaar";
    ENDPROC

PROC WriteNameFromFile()
    VAR robtarget p;
    VAR robtarget pStart;
    VAR iodev f;
    VAR string naam;

    ConfL \Off;
    SingArea \Wrist;

    p := CRobT(\Tool:=toolPen);
    pStart := p;

    Open "HOME:/naam.doc", f \Read;
    naam := ReadStr(f);
    Close f;

    WriteText p, naam;

    ! terug naar startpositie
    MoveL pStart, v100, fine, toolPen;

    RemoveFile "HOME:/naam.doc";

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