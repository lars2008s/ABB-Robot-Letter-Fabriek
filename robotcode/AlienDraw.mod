MODULE AlienDraw

    CONST num Z_UP := 10;
    CONST num Z_DOWN := 0;

    CONST speeddata V_TRAVEL := [200,500,5000,1000];
    CONST speeddata V_DRAW   := [50,200,2000,1000];

    ! Deze positie moet je op de robot nog goed zetten
    PERS robtarget pPlotStart := [[150,70,50],[1,0,0,0],[0,0,1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];

    PROC MoveToXY(num x, num y, bool draw)
        VAR robtarget p;

        p := CRobT(\Tool:=toolPen,\WObj:=wobjPlexi);
        p.trans.x := x;
        p.trans.y := y;

        IF draw THEN
            p.trans.z := p.trans.z + Z_DOWN;
            MoveL p, V_DRAW, fine, toolPen\WObj:=wobjPlexi;
        ELSE
            p.trans.z := p.trans.z + Z_UP;
            MoveL p, V_TRAVEL, z10, toolPen\WObj:=wobjPlexi;
        ENDIF
    ENDPROC

    PROC DrawAlien()
        ConfL \Off;
        SingArea \Wrist;

        MoveJ pPlotStart, V_TRAVEL, fine, toolPen\WObj:=wobjPlexi;

        MoveToXY 158.133, 70.081, FALSE;
        MoveToXY 158.318, 72.381, TRUE;
        MoveToXY 158.850, 74.547, TRUE;
        MoveToXY 159.701, 76.558, TRUE;
        MoveToXY 160.847, 78.399, TRUE;
        MoveToXY 162.251, 80.041, TRUE;
        MoveToXY 163.885, 81.445, TRUE;
        MoveToXY 165.726, 82.584, TRUE;
        MoveToXY 167.745, 83.434, TRUE;
        MoveToXY 169.904, 83.974, TRUE;
        MoveToXY 172.211, 84.159, TRUE;
        MoveToXY 186.229, 84.159, TRUE;
        MoveToXY 186.229, 74.318, TRUE;
        MoveToXY 158.133, 63.782, TRUE;
        MoveToXY 158.133, 70.081, TRUE;
        MoveToXY 141.867, 70.081, FALSE;
        MoveToXY 141.867, 63.782, TRUE;
        MoveToXY 113.771, 74.318, TRUE;
        MoveToXY 113.771, 84.159, TRUE;
        MoveToXY 127.789, 84.159, TRUE;
        MoveToXY 130.096, 83.974, TRUE;
        MoveToXY 132.255, 83.434, TRUE;
        MoveToXY 134.274, 82.584, TRUE;
        MoveToXY 136.115, 81.445, TRUE;
        MoveToXY 137.749, 80.041, TRUE;
        MoveToXY 139.153, 78.399, TRUE;
        MoveToXY 140.299, 76.558, TRUE;
        MoveToXY 141.150, 74.547, TRUE;
        MoveToXY 141.682, 72.381, TRUE;
        MoveToXY 141.867, 70.081, TRUE;
        MoveToXY 113.105, 40.573, FALSE;
        MoveToXY 109.956, 43.967, TRUE;
        MoveToXY 107.124, 47.597, TRUE;
        MoveToXY 104.647, 51.442, TRUE;
        MoveToXY 102.518, 55.494, TRUE;
        MoveToXY 100.736, 59.708, TRUE;
        MoveToXY 99.338, 64.070, TRUE;
        MoveToXY 98.325, 68.558, TRUE;
        MoveToXY 97.712, 73.142, TRUE;
        MoveToXY 97.505, 77.808, TRUE;
        MoveToXY 98.074, 85.505, TRUE;
        MoveToXY 99.738, 92.876, TRUE;
        MoveToXY 102.407, 99.804, TRUE;
        MoveToXY 106.000, 106.229, TRUE;
        MoveToXY 110.436, 112.048, TRUE;
        MoveToXY 115.619, 117.194, TRUE;
        MoveToXY 121.490, 121.593, TRUE;
        MoveToXY 127.945, 125.150, TRUE;
        MoveToXY 134.895, 127.789, TRUE;
        MoveToXY 142.281, 129.438, TRUE;
        MoveToXY 150.000, 130.000, TRUE;
        MoveToXY 157.719, 129.438, TRUE;
        MoveToXY 165.105, 127.789, TRUE;
        MoveToXY 172.055, 125.150, TRUE;
        MoveToXY 178.510, 121.593, TRUE;
        MoveToXY 184.381, 117.194, TRUE;
        MoveToXY 189.564, 112.048, TRUE;
        MoveToXY 194.000, 106.229, TRUE;
        MoveToXY 197.593, 99.804, TRUE;
        MoveToXY 200.262, 92.876, TRUE;
        MoveToXY 201.926, 85.505, TRUE;
        MoveToXY 202.495, 77.808, TRUE;
        MoveToXY 202.288, 73.142, TRUE;
        MoveToXY 201.675, 68.558, TRUE;
        MoveToXY 200.662, 64.070, TRUE;
        MoveToXY 199.264, 59.708, TRUE;
        MoveToXY 197.482, 55.494, TRUE;
        MoveToXY 195.353, 51.442, TRUE;
        MoveToXY 192.876, 47.597, TRUE;
        MoveToXY 190.044, 43.967, TRUE;
        MoveToXY 186.895, 40.573, TRUE;
        MoveToXY 183.442, 37.475, TRUE;
        MoveToXY 150.000, 10.000, TRUE;
        MoveToXY 116.558, 37.475, TRUE;
        MoveToXY 113.105, 40.573, TRUE;

        TPWrite "Alien klaar";
    ENDPROC

ENDMODULE
