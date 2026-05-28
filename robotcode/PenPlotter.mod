MODULE AlienDraw

CONST speeddata V_TRAVEL := [200,500,5000,1000];
CONST speeddata V_DRAW   := [50,200,2000,1000];

CONST num Z_UP := 10;
CONST num Z_DOWN := 0;

PROC MoveToXY(num x, num y, bool draw)

    VAR robtarget p;

    p := CRobT(\Tool:=toolPen,\WObj:=wobjPlexi);

    p.trans.x := x;
    p.trans.y := y;

    IF draw THEN
        p.trans.z := Z_DOWN;
        MoveL p, V_DRAW, fine, toolPen\WObj:=wobjPlexi;
    ELSE
        p.trans.z := Z_UP;
        MoveL p, V_TRAVEL, z10, toolPen\WObj:=wobjPlexi;
    ENDIF

ENDPROC


PROC DrawAlien()

    ConfL \Off;
    SingArea \Wrist;

    MoveToXY 158.13, 77.41, FALSE;
    MoveToXY 158.31, 77.41, TRUE;
    MoveToXY 158.89, 77.69, TRUE;
    MoveToXY 159.17, 78.27, TRUE;
    MoveToXY 159.17, 79.01, TRUE;
    MoveToXY 158.89, 79.59, TRUE;
    MoveToXY 158.31, 79.87, TRUE;
    MoveToXY 157.57, 79.87, TRUE;
    MoveToXY 156.99, 79.59, TRUE;
    MoveToXY 156.71, 79.01, TRUE;
    MoveToXY 156.71, 78.27, TRUE;
    MoveToXY 156.99, 77.69, TRUE;
    MoveToXY 157.57, 77.41, TRUE;
    MoveToXY 158.13, 77.41, TRUE;

ENDPROC

ENDMODULE