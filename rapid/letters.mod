PROC DrawL()

        VAR robtarget p0;
        VAR robtarget p1;
        VAR robtarget p2;
        VAR robtarget p3;
        VAR robtarget p4;
        VAR robtarget p5;
        VAR robtarget p6;
        VAR robtarget p7;

        ConfL \Off;
        SingArea \Wrist;

        p0 := CRobT(\Tool:=toolPen);

        ! Pen naar het bord
        p1 := p0;
        p1.trans.x := p1.trans.x + 5;
        MoveL p1, v10, fine, toolPen;

        ! 8 cm verticale lijn omhoog
        p2 := p1;
        p2.trans.z := p2.trans.z + 80;
        MoveL p2, v10, fine, toolPen;

        ! Pen van het bord
        p3 := p2;
        p3.trans.x := p3.trans.x - 5;
        MoveL p3, v10, fine, toolPen;

        ! Terug naar beneden zonder tekenen
        p4 := p3;
        p4.trans.z := p4.trans.z - 80;
        MoveL p4, v10, fine, toolPen;

        ! Pen terug naar het bord
        p5 := p4;
        p5.trans.x := p5.trans.x + 5;
        MoveL p5, v10, fine, toolPen;

        ! 4 cm horizontale voet tekenen
        p6 := p5;
        p6.trans.y := p6.trans.y + 40;
        MoveL p6, v10, fine, toolPen;

        ! Pen weg van het bord
        p7 := p6;
        p7.trans.x := p7.trans.x - 5;
        MoveL p7, v10, fine, toolPen;

        TPWrite "Letter L klaar";

    ENDPROC

    PROC DrawI()

        VAR robtarget p0;
        VAR robtarget p1;
        VAR robtarget p2;
        VAR robtarget p3;

        ConfL \Off;
        SingArea \Wrist;

        p0 := CRobT(\Tool:=toolPen);

        ! Pen naar het bord
        p1 := p0;
        p1.trans.x := p1.trans.x + 5;
        MoveL p1, v10, fine, toolPen;

        ! 8 cm verticale lijn
        p2 := p1;
        p2.trans.z := p2.trans.z + 80;
        MoveL p2, v10, fine, toolPen;

        ! Pen weg van het bord
        p3 := p2;
        p3.trans.x := p3.trans.x - 5;
        MoveL p3, v10, fine, toolPen;

        TPWrite "Letter I klaar";

    ENDPROC