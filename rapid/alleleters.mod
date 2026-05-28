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

    ! linker schuine poot
    DrawDiagYZ p, WA_LETTER_W / 2, WA_LETTER_H;

    ! rechter schuine poot
    DrawDiagYZ p, WA_LETTER_W / 2, -WA_LETTER_H;

    ! middenstreep
    MoveFreeY p, -(3 * WA_LETTER_W / 4);
    MoveFreeZ p, WA_LETTER_H / 2;
    DrawY p, WA_LETTER_W / 2;

    p := pStart;
ENDPROC

PROC DrawB(VAR robtarget p)
    VAR robtarget pStart;

    pStart := p;

    ! linker verticale stam
    DrawZLine p, WA_LETTER_H;

    ! bovenste horizontale
    DrawY p, WA_LETTER_W;

    ! korte verticale rechts naar midden
    DrawZLine p, -(WA_LETTER_H / 2);

    ! midden horizontale terug links
    DrawY p, -WA_LETTER_W;

    ! midden horizontale terug rechts
    DrawY p, WA_LETTER_W;

    ! korte verticale rechts naar onder
    DrawZLine p, -(WA_LETTER_H / 2);

    ! onderste horizontale terug links
    DrawY p, -WA_LETTER_W;

    p := pStart;
ENDPROC

PROC DrawC(VAR robtarget p)
    VAR robtarget pStart;

    pStart := p;

    ! naar linksboven
    MoveFreeZ p, WA_LETTER_H;

    ! bovenste horizontale
    DrawY p, WA_LETTER_W;

    ! terug naar linksboven
    MoveFreeY p, -WA_LETTER_W;

    ! linker verticale naar onder
    DrawZLine p, -WA_LETTER_H;

    ! onderste horizontale
    DrawY p, WA_LETTER_W;

    p := pStart;
ENDPROC

PROC DrawD(VAR robtarget p)
    VAR robtarget pStart;

    pStart := p;

    ! linker stam
    DrawZLine p, WA_LETTER_H;

    ! bovenste lijn iets korter
    DrawY p, (3 * WA_LETTER_W) / 4;

    ! naar rechtsmidden
    MoveFreeZ p, -WA_LETTER_H;

    ! rechter verticale iets naar binnen
    MoveFreeY p, WA_LETTER_W / 4;
    DrawZLine p, WA_LETTER_H;

    ! terug naar rechtsonder
    MoveFreeZ p, -WA_LETTER_H;

    ! onderste lijn terug naar links
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

    ! buitenvorm zoals C
    MoveFreeZ p, WA_LETTER_H;
    DrawY p, WA_LETTER_W;
    MoveFreeY p, -WA_LETTER_W;
    DrawZLine p, -WA_LETTER_H;
    DrawY p, WA_LETTER_W;

    ! extra binnenstuk rechts voor G
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