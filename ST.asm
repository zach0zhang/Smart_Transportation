line struc     ;the line struct
  X DW ?
  Y DW ?
  R_L DW ?
  C_L DW ?
line ends
;
light struc    ;light struct
  X1 DW ?
  Y1 DW ?
  COLOR DB ?
  Reserved DB 0
light ends
;
car struc	;the car struct
  start_X DW ?
  start_Y DW ?
  end_X DW ?
  end_Y DW ?
  live  DW 0
car ends
Left struc       ;the strcut of turn-left area
  Asize DB 10     ;all size
  Count DB 0     ;now size
  First DB 0     ; first index
  Last  DB 0     ; last index
  Array dw 10 dup(0)    ; the number of car which in the turn-left area
Left ends
Place struc	;the struct of the eight place
  X_start DW ?
  Y_start DW ?
  X_end   DW ?
  Y_end   DW ?
Place ends
;make the car go to the line from turn-left area
CAR_TURNL MACRO FROM_NAME,LEFT_NAME,LINE_NAME
LOCAL TURN_L0, TURN_L0_00, TURN_L0_20, TURN_L1, TURN_L1_10, TURN_L1_30, TURN_L2, TURN_L2_11, TURN_L2_31, TURN_L3, TURN_L3_01, TURN_L3_21
LOCAL TURN_L_OUT,TURN_L0_OUT, TURN_L1_OUT,TURN_L2_OUT,TURN_L3_OUT
	PUSH SI
 	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH DI
	CMP FROM_NAME,0
	JA TURN_L1
TURN_L0:
	CMP LEFT_NAME.Count,0
	JE TURN_L0_OUT			;If turn-left area is null,then out.
	MOV DH,0
	MOV DL,LEFT_NAME.First
	MOV SI,DX
	MOV DI,LEFT_NAME.Array[SI]	;Get the car number of first turn-left array 
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX
	MOV AX,car_array[DI].start_Y 
	CMP AX,22			;Choose the line0_0 or line2_0
	JB TURN_L0_00	
	JA TURN_L0_20
TURN_L0_00:		
	MOV SI,24              ;12*2
	CMP LINE_NAME[SI],0
	JA TURN_L0_OUT			;If the next area of line is full,then out
	MOV LINE_NAME[SI],BX		;get in line
	DEC LEFT_NAME.Count
	ADD LEFT_NAME.First,2
	CMP LEFT_NAME.First,18	;If first index >18(9*2), make the first index 0
	JNA TURN_L0_OUT
	MOV LEFT_NAME.First,0
TURN_L0_20:
	MOV SI,68              ;(12+22)*2
	CMP LINE_NAME[SI],0
	JA TURN_L0_OUT			;If the next area of line is full,then out
	MOV LINE_NAME[SI],BX		;get in line
	DEC LEFT_NAME.Count
	ADD LEFT_NAME.First,2
	CMP LEFT_NAME.First,18	;If first index >18(9*2), make the first index 0
	JNA TURN_L0_OUT
	MOV LEFT_NAME.First,0	
TURN_L0_OUT:
	JMP FAR PTR TURN_L_OUT

TURN_L1:
	CMP FROM_NAME,1
	JA TURN_L2

	CMP LEFT_NAME.Count,0
	JE TURN_L1_OUT			;If turn-left area is null,then out.
	MOV DH,0
	MOV DL,LEFT_NAME.First
	MOV SI,DX
	MOV DI,LEFT_NAME.Array[SI]	;Get the car number of first turn-left array 
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX
	MOV AX,car_array[DI].start_Y 
	CMP AX,22			;Choose the line1_0 or cross line3_0
	JB TURN_L1_10	
	JA TURN_L1_30
TURN_L1_10:		
	MOV SI,18              ;9*2
	CMP LINE_NAME[SI],0
	JA TURN_L1_OUT			;If the next area of line is full,then out
	MOV LINE_NAME[SI],BX		;get in line
	DEC LEFT_NAME.Count
	ADD LEFT_NAME.First,2
	CMP LEFT_NAME.First,18	;If first index >18(9*2), make the first index 0
	JNA TURN_L1_OUT
	MOV LEFT_NAME.First,0
TURN_L1_30:
	MOV SI,62              ;(9+22)*2
	CMP LINE_NAME[SI],0
	JA TURN_L1_OUT			;If the next area of line is full,then out
	MOV LINE_NAME[SI],BX		;get in line
	DEC LEFT_NAME.Count
	ADD LEFT_NAME.First,2
	CMP LEFT_NAME.First,18	;If first index >18(9*2), make the first index 0
	JNA TURN_L1_OUT
	MOV LEFT_NAME.First,0	
TURN_L1_OUT:
	JMP FAR PTR TURN_L_OUT


TURN_L2:
	CMP FROM_NAME,2
	JA TURN_L3

	CMP LEFT_NAME.Count,0
	JE TURN_L2_OUT			;If turn-left area is null,then out.
	MOV DH,0
	MOV DL,LEFT_NAME.First
	MOV SI,DX
	MOV DI,LEFT_NAME.Array[SI]	;Get the car number of first turn-left array 
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX
	MOV AX,car_array[DI].start_X 
	CMP AX,22			;Choose the line1_1 or cross line3_1
	JB TURN_L2_11	
	JA TURN_L2_31
TURN_L2_11:		
	MOV SI,18              ;9*2
	CMP LINE_NAME[SI],0
	JA TURN_L2_OUT			;If the next area of line is full,then out
	MOV LINE_NAME[SI],BX		;get in line
	DEC LEFT_NAME.Count
	ADD LEFT_NAME.First,2
	CMP LEFT_NAME.First,18	;If first index >18(9*2), make the first index 0
	JNA TURN_L2_OUT
	MOV LEFT_NAME.First,0
TURN_L2_31:
	MOV SI,62              ;(9+22)*2
	CMP LINE_NAME[SI],0
	JA TURN_L2_OUT			;If the next area of line is full,then out
	MOV LINE_NAME[SI],BX		;get in line
	DEC LEFT_NAME.Count
	ADD LEFT_NAME.First,2
	CMP LEFT_NAME.First,18	;If first index >18(9*2), make the first index 0
	JNA TURN_L2_OUT
	MOV LEFT_NAME.First,0	
TURN_L2_OUT:
	JMP FAR PTR TURN_L_OUT

TURN_L3:
	CMP LEFT_NAME.Count,0
	JE TURN_L3_OUT			;If turn-left area is null,then out.
	MOV DH,0
	MOV DL,LEFT_NAME.First
	MOV SI,DX
	MOV DI,LEFT_NAME.Array[SI]	;Get the car number of first turn-left array 
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX
	MOV AX,car_array[DI].start_X 
	CMP AX,22			;Choose the line0_1 or cross line2_1
	JB TURN_L3_01	
	JA TURN_L3_21
TURN_L3_01:		
	MOV SI,24              ;12*2
	CMP LINE_NAME[SI],0
	JA TURN_L3_OUT			;If the next area of line is full,then out
	MOV LINE_NAME[SI],BX		;get in line
	DEC LEFT_NAME.Count
	ADD LEFT_NAME.First,2
	CMP LEFT_NAME.First,18	;If first index >18(9*2), make the first index 0
	JNA TURN_L3_OUT
	MOV LEFT_NAME.First,0
TURN_L3_21:
	MOV SI,68              ;(12+22)*2
	CMP LINE_NAME[SI],0
	JA TURN_L3_OUT			;If the next area of line is full,then out
	MOV LINE_NAME[SI],BX		;get in line
	DEC LEFT_NAME.Count
	ADD LEFT_NAME.First,2
	CMP LEFT_NAME.First,18	;If first index >18(9*2), make the first index 0
	JNA TURN_L3_OUT
	MOV LEFT_NAME.First,0	
TURN_L3_OUT:
	JMP FAR PTR TURN_L_OUT
TURN_L_OUT:
	POP DI
	POP DX
	POP CX
	POP BX
	POP AX
	POP SI
	ENDM
;the algorithm of car turn 
CAR_TURNX MACRO LINE_NAME,FROM_NAME,LINE_NAMER0,CRO_NAMER0,LINE_NAMER1,CRO_NAMER1,LEFT_NAME0,LEFT_NAME1
LOCAL TO_CAR_RUN_G1,CAR_RUN_G0,CRO00_R,CRO00_R0_R,CRO10_R0_R,CAR_RUN_G0_C0,CAR_RUN_G0_C00,CAR_RUN_G0_R,CAR_RUN_G0_R0,CAR_RUN_G0_S 
LOCAL CAR_RUN_G0_L,OUT_G0_C0,CAR_RUN_G0_C1,CAR_RUN_G0_L0,CAR_RUN_G0_RE0,CAR_RUN_G0_TMOV0,CAR_RUN_G0_MOV0,CAR_RUN_G0_C2,CRO01_R,CRO01_R0_R,CRO11_R0_R,CAR_RUN_G0_C3,CAR_RUN_G0_C30,CAR_RUN_G0_1R,CAR_RUN_G0_1R0,CAR_RUN_G0_1S
LOCAL CAR_RUN_G0_1L,OUT_G0_C3,CAR_RUN_G0_C4,CAR_RUN_G0_L00,CAR_RUN_G0_RE00
LOCAL CAR_RUN_G0_TMOV00,CAR_RUN_G0_MOV00,CAR_RUN_G1,CRO10_R,CRO01_R1_R,CRO11_R1_R,CAR_RUN_G1_C0,CAR_RUN_G1_C00,CAR_RUN_G1_R,CAR_RUN_G1_R0
LOCAL CAR_RUN_G1_S,CAR_RUN_G1_L,OUT_G1_C0,CAR_RUN_G1_C1,CAR_RUN_G1_L0,CAR_RUN_G1_RE0,CAR_RUN_G1_TMOV0,CAR_RUN_G1_MOV0,CAR_RUN_G1_C2,CRO11_R,CRO00_R1_R,CRO10_R1_R,CAR_RUN_G1_C3
LOCAL CAR_RUN_G1_C30,CAR_RUN_G1_1R,CAR_RUN_G1_1R0,CAR_RUN_G1_1S,CAR_RUN_G1_1L
LOCAL OUT_G1_C3,CAR_RUN_G1_C4,CAR_RUN_G1_L00,CAR_RUN_G1_RE00,CAR_RUN_G1_TMOV00,CAR_RUN_G1_MOV00
LOCAL CAR_OUT_T, CAR_RUN_G0_L, CAR_RUN_G0_LL, CAR_RUN_G0_1L, CAR_RUN_G0_1LL,CAR_RUN_G1_L, CAR_RUN_G1_LL, CAR_RUN_G1_1L, CAR_RUN_G1_1LL
	PUSH SI
 	PUSH AX
	PUSH BX
	PUSH CX
        PUSH DX
	PUSH DI

	CMP FROM_NAME,0
	JA  TO_CAR_RUN_G1
	JMP CAR_RUN_G0
TO_CAR_RUN_G1:
	JMP FAR PTR CAR_RUN_G1

CAR_RUN_G0:
	MOV DI,CRO_NAMER0
	CMP DI,0
	JA CRO00_R		;If the cross which is going to turn right is not null
	JMP CAR_RUN_G0_C0
CRO00_R:
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX	
	MOV AX,car_array[DI].start_Y 
	CMP AX,22		;Choose the cross00 or cross 20
	JB CRO00_R0_R		
	JA CRO10_R0_R		
CRO00_R0_R:			;Turn right from cross00’s turn-right area
	MOV SI,18
	MOV AX,LINE_NAMER0[SI]
	CMP AX,0    		 ;When the line1_1[18] has car,can’t move(impossible)
	JA  CAR_RUN_G0_C0
	MOV LINE_NAMER0[SI],BX
	MOV CRO_NAMER0,0
	JMP CAR_RUN_G0_C0
CRO10_R0_R:			;Turn right from cross10’s turn-right area
	MOV SI,62
	MOV AX,LINE_NAMER0[SI]
	CMP AX,0     		;When the line1_1[62] has car,can’t move
	JA  CAR_RUN_G0_C0
	MOV LINE_NAMER0[SI],BX
	MOV CRO_NAMER0,0
	JMP CAR_RUN_G0_C0

CAR_RUN_G0_C0:			;the first cross move
	MOV SI,24
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G0_C00
	JMP OUT_G0_C0
CAR_RUN_G0_C00:				;Move the car before the first cross one step
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX
	MOV AX,car_array[DI].start_X
	SUB AX,2
	CMP car_array[DI].end_X,AX
	JB CAR_RUN_G0_S
	MOV AX,car_array[DI].start_Y    ;decide turn right or turn left or go stright
	CMP car_array[DI].end_Y,AX
	Jb CAR_RUN_G0_R                  ;turn right
	JE CAR_RUN_G0_S		  ;go stright
	JA CAR_RUN_G0_L		  ;turn left

CAR_RUN_G0_R:			  ;The car which is going to get in cross will turn right
	CMP CRO_NAMER0,0
	JE CAR_RUN_G0_R0
	JMP OUT_G0_C0
CAR_RUN_G0_R0:			 ;If the turn-right area are null,move the car to it.
	DEC car_array[DI].start_X
	DEC car_array[DI].start_Y
	MOV CRO_NAMER0,BX	;Move the car to turn-right area
	MOV LINE_NAME[SI],0
	JMP OUT_G0_C0
	
CAR_RUN_G0_S:			;go stright , move the car to the next step
	DEC car_array[DI].start_X
	MOV LINE_NAME[SI-2],BX
	MOV LINE_NAME[SI],0
	JMP OUT_G0_C0
	
CAR_RUN_G0_L:			;turn left, move the car to the turn-left array
	MOV AL,LEFT_NAME0.COUNT
	CMP AL,LEFT_NAME0.ASIZE
	JNA CAR_RUN_G0_LL
	JMP OUT_G0_C0
CAR_RUN_G0_LL:
	SUB car_array[DI].start_X,2   
	ADD car_array[DI].start_Y,2
	MOV LINE_NAME[SI],0
	MOV DH,0
	MOV DL,LEFT_NAME0.Last
	MOV SI,DX
	MOV LEFT_NAME0.Array[SI],BX ; Put the car number to the turn-Left array
	INC LEFT_NAME0.COUNT	;the now array number add 1
	ADD LEFT_NAME0.Last,2
	CMP LEFT_NAME0.Last,18	;If last index >18(9*2), make the last index 0
	JNA OUT_G0_C0
	MOV LEFT_NAME0.Last,0
	
		 
	
OUT_G0_C0:
	JMP CAR_RUN_G0_C1

CAR_RUN_G0_C1:			; Move the car to next step on middle step
	MOV CX,21
	MOV SI,26
CAR_RUN_G0_L0:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G0_TMOV0
CAR_RUN_G0_RE0:
	ADD SI,2
	LOOP CAR_RUN_G0_L0
	JMP CAR_RUN_G0_C2
CAR_RUN_G0_TMOV0:
	CMP LINE_NAME[SI-2],0
	JE CAR_RUN_G0_MOV0
	ADD SI,2
	LOOP CAR_RUN_G0_L0
	JMP CAR_RUN_G0_C2
CAR_RUN_G0_MOV0:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	DEC car_array[DI].start_X
	MOV LINE_NAME[SI-2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_G0_RE0

CAR_RUN_G0_C2:	
	MOV DI,CRO_NAMER1
	CMP DI,0
	JA CRO01_R		;If the cross which is going to turn right is not null
	JMP CAR_RUN_G0_C3
CRO01_R:
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX	
	MOV AX,car_array[DI].start_Y 
	CMP AX,22		;Choose the cross00 or cross 20
	JB CRO01_R0_R		
	JA CRO11_R0_R		
CRO01_R0_R:			;Turn right from cross00’s turn-right area
	MOV SI,18
	MOV AX,LINE_NAMER1[SI]
	CMP AX,0    		 ;When the line3_1[18] has car,can’t move(impossible)
	JA  CAR_RUN_G0_C3
	MOV LINE_NAMER1[SI],BX
	MOV CRO_NAMER1,0
	JMP CAR_RUN_G0_C3
CRO11_R0_R:			;Turn right from cross10’s turn-right area
	MOV SI,62
	MOV AX,LINE_NAMER1[SI]
	CMP AX,0     		;When the line3_1[62] has car,can’t move
	JA  CAR_RUN_G0_C3
	MOV LINE_NAMER1[SI],BX
	MOV CRO_NAMER1,0
	JMP CAR_RUN_G0_C3

CAR_RUN_G0_C3:			;the second cross move
	MOV SI,68
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G0_C30
	JMP OUT_G0_C3
CAR_RUN_G0_C30:				;Move the car before the second cross one step
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX
	MOV AX,car_array[DI].start_X
	SUB AX,2
	CMP car_array[DI].end_X,AX
	JB CAR_RUN_G0_1S
	MOV AX,car_array[DI].start_Y    ;decide turn right or turn left or go stright
	CMP car_array[DI].end_Y,AX
	Jb CAR_RUN_G0_1R                  ;turn right
	JE CAR_RUN_G0_1S		  ;go stright
	JA CAR_RUN_G0_1L		  ;turn left

CAR_RUN_G0_1R:			  ;The car which is going to get in cross will turn right
	CMP CRO_NAMER1,0
	JE CAR_RUN_G0_1R0
	JMP OUT_G0_C3
CAR_RUN_G0_1R0:			 ;If the turn-right area are null,move the car to it.
	DEC car_array[DI].start_X
	DEC car_array[DI].start_Y
	MOV CRO_NAMER1,BX	;Move the car to turn-right area
	MOV LINE_NAME[SI],0
	JMP OUT_G0_C3
	
CAR_RUN_G0_1S:			;go stright , move the car to the next step
	DEC car_array[DI].start_X
	MOV LINE_NAME[SI-2],BX
	MOV LINE_NAME[SI],0
	JMP OUT_G0_C3
	
CAR_RUN_G0_1L:	            ;turn left, move the car to the turn-left array
	MOV AL,LEFT_NAME1.COUNT
	CMP AL,LEFT_NAME1.ASIZE
	JNA CAR_RUN_G0_1LL
	JMP OUT_G0_C3
CAR_RUN_G0_1LL:
	SUB car_array[DI].start_X,2   
	ADD car_array[DI].start_Y.2
	MOV LINE_NAME[SI],0
	MOV DH,0
	MOV DL,LEFT_NAME1.Last
	MOV SI,DX
	MOV LEFT_NAME1.Array[SI],BX ; Put the car number to the turn-Left array
	INC LEFT_NAME1.COUNT	;the now array number add 1
	ADD LEFT_NAME1.Last,2
	CMP LEFT_NAME1.Last,18	;If last index >18(9*2), make the last index 0
	JNA OUT_G0_C3
	MOV LEFT_NAME1.Last,0
	
OUT_G0_C3:
	JMP CAR_RUN_G0_C4

CAR_RUN_G0_C4:			;move the car to the next step on last road
	MOV CX,9
	MOV SI,70
CAR_RUN_G0_L00:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G0_TMOV00
CAR_RUN_G0_RE00:
	ADD SI,2
	LOOP CAR_RUN_G0_L00
	JMP far ptr CAR_OUT_T
CAR_RUN_G0_TMOV00:
	CMP LINE_NAME[SI-2],0
	JE CAR_RUN_G0_MOV00
	ADD SI,2
	LOOP CAR_RUN_G0_L00
	JMP far ptr CAR_OUT_T	
CAR_RUN_G0_MOV00:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	DEC car_array[DI].start_X
	MOV LINE_NAME[SI-2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_G0_RE00

CAR_RUN_G1:
	MOV DI,CRO_NAMER1
	CMP DI,0
	JA CRO10_R		;If the cross which is going to turn right is not null
	JMP CAR_RUN_G1_C0
CRO10_R:
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX	
	MOV AX,car_array[DI].start_Y 
	CMP AX,22		;Choose the cross10 or cross 30
	JB CRO01_R1_R		
	JA CRO11_R1_R		
CRO01_R1_R:			;Turn right from cross00’s turn-right area
	MOV SI,24
	MOV AX,LINE_NAMER1[SI]
	CMP AX,0    		 ;When the line2_1[24] has car,can’t move
	JA  CAR_RUN_G1_C0
	MOV LINE_NAMER1[SI],BX
	MOV CRO_NAMER1,0
	JMP CAR_RUN_G1_C0
CRO11_R1_R:			;Turn right from cross20’s turn-right area
	MOV SI,68
	MOV AX,LINE_NAMER1[SI]
	CMP AX,0     		;When the line2_1[68] has car,can’t move(impossible)
	JA  CAR_RUN_G1_C0
	MOV LINE_NAMER1[SI],BX
	MOV CRO_NAMER1,0
	JMP CAR_RUN_G1_C0

CAR_RUN_G1_C0:			;the first cross move
	MOV SI,62		;31*2
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G1_C00
	JMP OUT_G1_C0
CAR_RUN_G1_C00:				;Move the car before the first cross one step
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX
	MOV AX,car_array[DI].start_X
	ADD AX,2
	CMP car_array[DI].end_X,AX
	JA CAR_RUN_G1_S
	MOV AX,car_array[DI].start_Y    ;decide turn right or turn left or go stright
	CMP car_array[DI].end_Y,AX
	JA CAR_RUN_G1_R                  ;turn right
	JE CAR_RUN_G1_S		  ;go stright
	JB CAR_RUN_G1_L		  ;turn left

CAR_RUN_G1_R:			  ;The car which is going to get in cross will turn right
	CMP CRO_NAMER1,0
	JE CAR_RUN_G1_R0
	JMP OUT_G1_C0
CAR_RUN_G1_R0:			 ;If the turn-right area are null,move the car to it.
	INC car_array[DI].start_X
	INC car_array[DI].start_Y
	MOV CRO_NAMER1,BX	;Move the car to turn-right area
	MOV LINE_NAME[SI],0
	JMP OUT_G1_C0
	
CAR_RUN_G1_S:			;go stright , move the car to the next step
	INC car_array[DI].start_X
	MOV LINE_NAME[SI+2],BX
	MOV LINE_NAME[SI],0
	JMP OUT_G1_C0
		
CAR_RUN_G1_L:			;turn left, move the car to the turn-left array
	MOV AL,LEFT_NAME1.COUNT
	CMP AL,LEFT_NAME1.ASIZE
	JNA CAR_RUN_G1_LL
	JMP OUT_G1_C0
CAR_RUN_G1_LL:
	ADD car_array[DI].start_X,2   
	SUB car_array[DI].start_Y,2
	MOV LINE_NAME[SI],0
	MOV DH,0
	MOV DL,LEFT_NAME1.Last
	MOV SI,DX
	MOV LEFT_NAME1.Array[SI],BX ; Put the car number to the turn-Left array
	INC LEFT_NAME1.COUNT	;the now array number add 1
	ADD LEFT_NAME1.Last,2
	CMP LEFT_NAME1.Last,18	;If last index >18(9*2), make the last index 0
	JNA OUT_G1_C0
	MOV LEFT_NAME0.Last,0
	
OUT_G1_C0:
	JMP CAR_RUN_G1_C1

CAR_RUN_G1_C1:			; Move the car to next step on middle step
	MOV CX,21
	MOV SI,60
CAR_RUN_G1_L0:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G1_TMOV0
CAR_RUN_G1_RE0:
	SUB SI,2
	LOOP CAR_RUN_G1_L0
	JMP CAR_RUN_G1_C2
CAR_RUN_G1_TMOV0:
	CMP LINE_NAME[SI+2],0
	JE CAR_RUN_G1_MOV0
	SUB SI,2
	LOOP CAR_RUN_G1_L0
	JMP CAR_RUN_G1_C2
CAR_RUN_G1_MOV0:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	INC car_array[DI].start_X
	MOV LINE_NAME[SI+2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_G1_RE0

CAR_RUN_G1_C2:	
	MOV DI,CRO_NAMER0
	CMP DI,0
	JA CRO11_R		;If the cross which is going to turn right is not null
	JMP CAR_RUN_G1_C3
CRO11_R:
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX	
	MOV AX,car_array[DI].start_Y 
	CMP AX,22		;Choose the cross10 or cross 30
	JB CRO00_R1_R		
	JA CRO10_R1_R		
CRO00_R1_R:			;Turn right from cross10’s turn-right area
	MOV SI,24
	MOV AX,LINE_NAMER0[SI]
	CMP AX,0    		 ;When the line0_1[24] has car,can’t move
	JA  CAR_RUN_G1_C3
	MOV LINE_NAMER0[SI],BX
	MOV CRO_NAMER0,0
	JMP CAR_RUN_G1_C3
CRO10_R1_R:			;Turn right from cross30’s turn-right area
	MOV SI,68
	MOV AX,LINE_NAMER0[SI]
	CMP AX,0     		;When the line0_1[62] has car,can’t move(impossible)
	JA  CAR_RUN_G1_C3
	MOV LINE_NAMER0[SI],BX
	MOV CRO_NAMER0,0
	JMP CAR_RUN_G1_C3

CAR_RUN_G1_C3:			;the second cross move
	MOV SI,18
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G1_C30
	JMP OUT_G1_C3
CAR_RUN_G1_C30:				;Move the car before the second cross one step
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX
	MOV AX,car_array[DI].start_X
	ADD AX,2
	CMP car_array[DI].end_X,AX
	JA CAR_RUN_G1_1S
	MOV AX,car_array[DI].start_Y    ;decide turn right or turn left or go stright
	CMP car_array[DI].end_Y,AX
	JA CAR_RUN_G1_1R                  ;turn right
	JE CAR_RUN_G1_1S		  ;go stright
	JB CAR_RUN_G1_1L		  ;turn left

CAR_RUN_G1_1R:			  ;The car which is going to get in cross will turn right
	CMP CRO_NAMER0,0
	JE CAR_RUN_G1_1R0
	JMP OUT_G1_C3
CAR_RUN_G1_1R0:			 ;If the turn-right area are null,move the car to it.
	INC car_array[DI].start_X
	INC car_array[DI].start_Y
	MOV CRO_NAMER0,BX	;Move the car to turn-right area
	MOV LINE_NAME[SI],0
	JMP OUT_G1_C3
	
CAR_RUN_G1_1S:			;go stright , move the car to the next step
	INC car_array[DI].start_X
	MOV LINE_NAME[SI+2],BX
	MOV LINE_NAME[SI],0
	JMP OUT_G1_C3
	
CAR_RUN_G1_1L:	            ;turn left, move the car to the turn-left array
	MOV AL,LEFT_NAME0.COUNT
	CMP AL,LEFT_NAME0.ASIZE
	JNA CAR_RUN_G1_1LL
	JMP OUT_G1_C3
CAR_RUN_G1_1LL:
	ADD car_array[DI].start_X,2   
	SUB car_array[DI].start_Y,2
	MOV LINE_NAME[SI],0
	MOV DH,0
	MOV DL,LEFT_NAME0.Last
	MOV SI,DX
	MOV LEFT_NAME0.Array[SI],BX ; Put the car number to the turn-Left array
	INC LEFT_NAME0.COUNT	;the now array number add 1
	ADD LEFT_NAME0.Last,2
	CMP LEFT_NAME0.Last,18	;If last index >18(9*2), make the last index 0
	JNA OUT_G1_C3
	MOV LEFT_NAME0.Last,0

	
OUT_G1_C3:
	JMP CAR_RUN_G1_C4

CAR_RUN_G1_C4:			;move the car to the next step on last road
	MOV CX,9
	MOV SI,16
CAR_RUN_G1_L00:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G1_TMOV00
CAR_RUN_G1_RE00:
	SUB SI,2
	LOOP CAR_RUN_G1_L00
	JMP far ptr CAR_OUT_T
CAR_RUN_G1_TMOV00:
	CMP LINE_NAME[SI+2],0
	JE CAR_RUN_G1_MOV00
	SUB SI,2
	LOOP CAR_RUN_G1_L00
	JMP far ptr CAR_OUT_T	
CAR_RUN_G1_MOV00:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	INC car_array[DI].start_X
	MOV LINE_NAME[SI+2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_G1_RE00
CAR_OUT_T:
	POP DI
	POP DX
	POP CX
	POP BX
	POP AX
	POP SI
	ENDM

;










;the algorithm of car turn , line0_1,line1_1,line2_1,line3_1
CAR_TURNY MACRO LINE_NAME,FROM_NAME,LINE_NAMER0,CRO_NAMER0,LINE_NAMER1,CRO_NAMER1,LEFT_NAME0,LEFT_NAME1
LOCAL TO_CAR_RUN_G1,CAR_RUN_G0,CRO00_R,CRO00_R0_R,CRO01_R0_R,CAR_RUN_G0_C0,CAR_RUN_G0_C00,CAR_RUN_G0_R,CAR_RUN_G0_R0,CAR_RUN_G0_S 
LOCAL CAR_RUN_G0_L,OUT_G0_C0,CAR_RUN_G0_C1,CAR_RUN_G0_L0,CAR_RUN_G0_RE0,CAR_RUN_G0_TMOV0,CAR_RUN_G0_MOV0,CAR_RUN_G0_C2,CRO01_R,CRO10_R0_R,CRO11_R0_R,CAR_RUN_G0_C3,CAR_RUN_G0_C30,CAR_RUN_G0_1R,CAR_RUN_G0_1R0,CAR_RUN_G0_1S
LOCAL CAR_RUN_G0_1L,OUT_G0_C3,CAR_RUN_G0_C4,CAR_RUN_G0_L00,CAR_RUN_G0_RE00
LOCAL CAR_RUN_G0_TMOV00,CAR_RUN_G0_MOV00,CAR_RUN_G1,CRO10_R,CRO10_R1_R,CRO11_R1_R,CAR_RUN_G1_C0,CAR_RUN_G1_C00,CAR_RUN_G1_R,CAR_RUN_G1_R0
LOCAL CAR_RUN_G1_S,CAR_RUN_G1_L,OUT_G1_C0,CAR_RUN_G1_C1,CAR_RUN_G1_L0,CAR_RUN_G1_RE0,CAR_RUN_G1_TMOV0,CAR_RUN_G1_MOV0,CAR_RUN_G1_C2,CRO11_R,CRO00_R1_R,CRO01_R1_R,CAR_RUN_G1_C3
LOCAL CAR_RUN_G1_C30,CAR_RUN_G1_1R,CAR_RUN_G1_1R0,CAR_RUN_G1_1S,CAR_RUN_G1_1L
LOCAL OUT_G1_C3,CAR_RUN_G1_C4,CAR_RUN_G1_L00,CAR_RUN_G1_RE00,CAR_RUN_G1_TMOV00,CAR_RUN_G1_MOV00
LOCAL CAR_OUT_T, CAR_RUN_G0_L, CAR_RUN_G0_LL, CAR_RUN_G0_1L, CAR_RUN_G0_1LL,CAR_RUN_G1_L, CAR_RUN_G1_LL, CAR_RUN_G1_1L, CAR_RUN_G1_1LL	
	PUSH SI
 	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH DI

	CMP FROM_NAME,2
	JA  TO_CAR_RUN_G1
	JMP CAR_RUN_G0
TO_CAR_RUN_G1:
	JMP FAR PTR CAR_RUN_G1

CAR_RUN_G0:			;line1_1 and line3_1
	MOV DI,CRO_NAMER0
	CMP DI,0
	JA CRO00_R		;If the cross which is going to turn right is not null
	JMP CAR_RUN_G0_C0
CRO00_R:
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX	
	MOV AX,car_array[DI].start_X 
	CMP AX,22		;Choose the cross00 or cross 01
	JB CRO00_R0_R		
	JA CRO01_R0_R		
CRO00_R0_R:			;Turn right from cross00’s turn-right area
	MOV SI,24
	MOV AX,LINE_NAMER0[SI]
	CMP AX,0    		 ;When the line1_1[24] has car,can’t move
	JA  CAR_RUN_G0_C0
	MOV LINE_NAMER0[SI],BX
	MOV CRO_NAMER0,0
	JMP CAR_RUN_G0_C0
CRO01_R0_R:			;Turn right from cross01’s turn-right area
	MOV SI,68
	MOV AX,LINE_NAMER0[SI]
	CMP AX,0     		;When the line1_1[68] has car,can’t move(impossible)
	JA  CAR_RUN_G0_C0
	MOV LINE_NAMER0[SI],BX
	MOV CRO_NAMER0,0
	JMP CAR_RUN_G0_C0

CAR_RUN_G0_C0:			;the first cross move
	MOV SI,24
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G0_C00
	JMP OUT_G0_C0
CAR_RUN_G0_C00:				;Move the car before the first cross one step
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX
	MOV AX,car_array[DI].start_Y
	SUB AX,2
	CMP car_array[DI].end_Y,AX
	JB CAR_RUN_G0_S
	MOV AX,car_array[DI].start_X    ;decide turn right or turn left or go stright
	CMP car_array[DI].end_X,AX
	JA CAR_RUN_G0_R                  ;turn right
	JE CAR_RUN_G0_S		  ;go stright
	JB CAR_RUN_G0_L		  ;turn left

CAR_RUN_G0_R:			  ;The car which is going to get in cross will turn right
	CMP CRO_NAMER0,0
	JE CAR_RUN_G0_R0
	JMP OUT_G0_C0
CAR_RUN_G0_R0:			 ;If the turn-right area are null,move the car to it.
	INC car_array[DI].start_X
	DEC car_array[DI].start_Y
	MOV CRO_NAMER0,BX	;Move the car to turn-right area
	MOV LINE_NAME[SI],0
	JMP OUT_G0_C0
	
CAR_RUN_G0_S:			;go stright , move the car to the next step
	DEC car_array[DI].start_Y
	MOV LINE_NAME[SI-2],BX
	MOV LINE_NAME[SI],0
	JMP OUT_G0_C0
	
CAR_RUN_G0_L:			;turn left, move the car to the turn-left array
	MOV AL,LEFT_NAME0.COUNT
	CMP AL,LEFT_NAME0.ASIZE
	JNA CAR_RUN_G0_LL
	JMP OUT_G0_C0
CAR_RUN_G0_LL:
	SUB car_array[DI].start_X,2   
	SUB car_array[DI].start_Y,2
	MOV LINE_NAME[SI],0
	MOV DH,0
	MOV DL,LEFT_NAME0.Last
	MOV SI,DX
	MOV LEFT_NAME0.Array[SI],BX ; Put the car number to the turn-Left array
	INC LEFT_NAME0.COUNT	;the now array number add 1
	ADD LEFT_NAME0.Last,2
	CMP LEFT_NAME0.Last,18	;If last index >18(9*2), make the last index 0
	JNA OUT_G0_C0
	MOV LEFT_NAME0.Last,0
OUT_G0_C0:
	JMP CAR_RUN_G0_C1

CAR_RUN_G0_C1:			; Move the car to next step on middle step
	MOV CX,21
	MOV SI,26
CAR_RUN_G0_L0:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G0_TMOV0
CAR_RUN_G0_RE0:
	ADD SI,2
	LOOP CAR_RUN_G0_L0
	JMP CAR_RUN_G0_C2
CAR_RUN_G0_TMOV0:
	CMP LINE_NAME[SI-2],0
	JE CAR_RUN_G0_MOV0
	ADD SI,2
	LOOP CAR_RUN_G0_L0
	JMP CAR_RUN_G0_C2
CAR_RUN_G0_MOV0:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	DEC car_array[DI].start_Y
	MOV LINE_NAME[SI-2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_G0_RE0

CAR_RUN_G0_C2:	
	MOV DI,CRO_NAMER1
	CMP DI,0
	JA CRO01_R		;If the cross which is going to turn right is not null
	JMP CAR_RUN_G0_C3
CRO01_R:
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX	
	MOV AX,car_array[DI].start_X 
	CMP AX,22		;Choose the cross10 or cross 11
	JB CRO10_R0_R		
	JA CRO11_R0_R		
CRO10_R0_R:			;Turn right from cross10’s turn-right area
	MOV SI,24
	MOV AX,LINE_NAMER1[SI]
	CMP AX,0    		 ;When the line3_0[24] has car,can’t move
	JA  CAR_RUN_G0_C3
	MOV LINE_NAMER1[SI],BX
	MOV CRO_NAMER1,0
	JMP CAR_RUN_G0_C3
CRO11_R0_R:			;Turn right from cross11’s turn-right area
	MOV SI,68
	MOV AX,LINE_NAMER1[SI]
	CMP AX,0     		;When the line3_0[68] has car,can’t move(impossible)
	JA  CAR_RUN_G0_C3
	MOV LINE_NAMER1[SI],BX
	MOV CRO_NAMER1,0
	JMP CAR_RUN_G0_C3

CAR_RUN_G0_C3:			;the second cross move
	MOV SI,68
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G0_C30
	JMP OUT_G0_C3
CAR_RUN_G0_C30:				;Move the car before the second cross one step
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX
	MOV AX,car_array[DI].start_Y
	SUB AX,2
	CMP car_array[DI].end_Y,AX
	JB CAR_RUN_G0_1S
	MOV AX,car_array[DI].start_X    ;decide turn right or turn left or go stright
	CMP car_array[DI].end_X,AX
	JA CAR_RUN_G0_1R                  ;turn right
	JE CAR_RUN_G0_1S		  ;go stright
	JB CAR_RUN_G0_1L		  ;turn left

CAR_RUN_G0_1R:			  ;The car which is going to get in cross will turn right
	CMP CRO_NAMER1,0
	JE CAR_RUN_G0_1R0
	JMP OUT_G0_C3
CAR_RUN_G0_1R0:			 ;If the turn-right area are null,move the car to it.
	INC car_array[DI].start_X
	DEC car_array[DI].start_Y
	MOV CRO_NAMER1,BX	;Move the car to turn-right area
	MOV LINE_NAME[SI],0
	JMP OUT_G0_C3
	
CAR_RUN_G0_1S:			;go stright , move the car to the next step
	DEC car_array[DI].start_Y
	MOV LINE_NAME[SI-2],BX
	MOV LINE_NAME[SI],0
	JMP OUT_G0_C3
	
CAR_RUN_G0_1L:	            ;turn left, move the car to the turn-left array
	MOV AL,LEFT_NAME1.COUNT
	CMP AL,LEFT_NAME1.ASIZE
	JNA CAR_RUN_G0_1LL
	JMP OUT_G0_C3
CAR_RUN_G0_1LL:
	SUB car_array[DI].start_X,2   
	SUB car_array[DI].start_Y.2
	MOV LINE_NAME[SI],0
	MOV DH,0
	MOV DL,LEFT_NAME1.Last
	MOV SI,DX
	MOV LEFT_NAME1.Array[SI],BX ; Put the car number to the turn-Left array
	INC LEFT_NAME1.COUNT	;the now array number add 1
	ADD LEFT_NAME1.Last,2
	CMP LEFT_NAME1.Last,18	;If last index >18(9*2), make the last index 0
	JNA OUT_G0_C3
	MOV LEFT_NAME1.Last,0
	
OUT_G0_C3:
	JMP CAR_RUN_G0_C4

CAR_RUN_G0_C4:			;move the car to the next step on last road
	MOV CX,9
	MOV SI,70
CAR_RUN_G0_L00:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G0_TMOV00
CAR_RUN_G0_RE00:
	ADD SI,2
	LOOP CAR_RUN_G0_L00
	JMP far ptr CAR_OUT_T
CAR_RUN_G0_TMOV00:
	CMP LINE_NAME[SI-2],0
	JE CAR_RUN_G0_MOV00
	ADD SI,2
	LOOP CAR_RUN_G0_L00
	JMP far ptr CAR_OUT_T	
CAR_RUN_G0_MOV00:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	DEC car_array[DI].start_Y
	MOV LINE_NAME[SI-2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_G0_RE00

CAR_RUN_G1:				;line0_1 and line2_1(from_y_end)
	MOV DI,CRO_NAMER1
	CMP DI,0
	JA CRO10_R		;If the cross which is going to turn right is not null
	JMP CAR_RUN_G1_C0
CRO10_R:
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX	
	MOV AX,car_array[DI].start_x
	CMP AX,22		;Choose the cross10 or cross 11
	JB CRO10_R1_R		
	JA CRO11_R1_R		
CRO10_R1_R:			;Turn right from cross10’s turn-right area
	MOV SI,18
	MOV AX,LINE_NAMER1[SI]
	CMP AX,0    		 ;When the line2_0[18] has car,can’t move(impossible)
	JA  CAR_RUN_G1_C0
	MOV LINE_NAMER1[SI],BX
	MOV CRO_NAMER1,0
	JMP CAR_RUN_G1_C0
CRO11_R1_R:			;Turn right from cross11’s turn-right area
	MOV SI,62
	MOV AX,LINE_NAMER1[SI]
	CMP AX,0     		;When the line2_0[62] has car,can’t move
	JA  CAR_RUN_G1_C0
	MOV LINE_NAMER1[SI],BX
	MOV CRO_NAMER1,0
	JMP CAR_RUN_G1_C0

CAR_RUN_G1_C0:			;the first cross move
	MOV SI,62		;31*2
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G1_C00
	JMP OUT_G1_C0
CAR_RUN_G1_C00:				;Move the car before the first cross one step
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX
	MOV AX,car_array[DI].start_Y
	ADD AX,2
	CMP car_array[DI].end_Y,AX
	JA CAR_RUN_G1_S
	MOV AX,car_array[DI].start_X    ;decide turn right or turn left or go stright
	CMP car_array[DI].end_X,AX
	JB CAR_RUN_G1_R                  ;turn right
	JE CAR_RUN_G1_S		  ;go stright
	JA CAR_RUN_G1_L		  ;turn left

CAR_RUN_G1_R:			  ;The car which is going to get in cross will turn right
	CMP CRO_NAMER1,0
	JE CAR_RUN_G1_R0
	JMP OUT_G1_C0
CAR_RUN_G1_R0:			 ;If the turn-right area are null,move the car to it.
	DEC car_array[DI].start_X
	INC car_array[DI].start_Y
	MOV CRO_NAMER1,BX	;Move the car to turn-right area
	MOV LINE_NAME[SI],0
	JMP OUT_G1_C0
	
CAR_RUN_G1_S:			;go stright , move the car to the next step
	INC car_array[DI].start_Y
	MOV LINE_NAME[SI+2],BX
	MOV LINE_NAME[SI],0
	JMP OUT_G1_C0
		
CAR_RUN_G1_L:			;turn left, move the car to the turn-left array
	MOV AL,LEFT_NAME1.COUNT
	CMP AL,LEFT_NAME1.ASIZE
	JNA CAR_RUN_G1_LL
	JMP OUT_G1_C0
CAR_RUN_G1_LL:
	ADD car_array[DI].start_X,2   
	ADD car_array[DI].start_Y,2
	MOV LINE_NAME[SI],0
	MOV DH,0
	MOV DL,LEFT_NAME1.Last
	MOV SI,DX
	MOV LEFT_NAME1.Array[SI],BX ; Put the car number to the turn-Left array
	INC LEFT_NAME1.COUNT	;the now array number add 1
	ADD LEFT_NAME1.Last,2
	CMP LEFT_NAME1.Last,18	;If last index >18(9*2), make the last index 0
	JNA OUT_G1_C0
	MOV LEFT_NAME1.Last,0
	
OUT_G1_C0:
	JMP CAR_RUN_G1_C1

CAR_RUN_G1_C1:			; Move the car to next step on middle step
	MOV CX,21
	MOV SI,60
CAR_RUN_G1_L0:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G1_TMOV0
CAR_RUN_G1_RE0:
	SUB SI,2
	LOOP CAR_RUN_G1_L0
	JMP CAR_RUN_G1_C2
CAR_RUN_G1_TMOV0:
	CMP LINE_NAME[SI+2],0
	JE CAR_RUN_G1_MOV0
	SUB SI,2
	LOOP CAR_RUN_G1_L0
	JMP CAR_RUN_G1_C2
CAR_RUN_G1_MOV0:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	INC car_array[DI].start_Y
	MOV LINE_NAME[SI+2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_G1_RE0

CAR_RUN_G1_C2:	
	MOV DI,CRO_NAMER0
	CMP DI,0
	JA CRO11_R		;If the cross which is going to turn right is not null
	JMP CAR_RUN_G1_C3
CRO11_R:
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX	
	MOV AX,car_array[DI].start_X 
	CMP AX,22		;Choose the cross00 or cross 01
	JB CRO00_R1_R		
	JA CRO01_R1_R		
CRO00_R1_R:			;Turn right from cross00’s turn-right area
	MOV SI,18
	MOV AX,LINE_NAMER0[SI]
	CMP AX,0    		 ;When the line0_0[18] has car,can’t move(impossible)
	JA  CAR_RUN_G1_C3
	MOV LINE_NAMER0[SI],BX
	MOV CRO_NAMER0,0
	JMP CAR_RUN_G1_C3
CRO01_R1_R:			;Turn right from cross01’s turn-right area
	MOV SI,62
	MOV AX,LINE_NAMER0[SI]
	CMP AX,0     		;When the line0_1[62] has car,can’t move
	JA  CAR_RUN_G1_C3
	MOV LINE_NAMER0[SI],BX
	MOV CRO_NAMER0,0
	JMP CAR_RUN_G1_C3

CAR_RUN_G1_C3:			;the second cross move
	MOV SI,18
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G1_C30
	JMP OUT_G1_C3
CAR_RUN_G1_C30:				;Move the car before the second cross one step
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI				
	MOV DI,AX
	MOV AX,car_array[DI].start_Y
	ADD AX,2
	CMP car_array[DI].end_Y,AX
	JA CAR_RUN_G1_1S
	MOV AX,car_array[DI].start_X    ;decide turn right or turn left or go stright
	CMP car_array[DI].end_X,AX
	JB CAR_RUN_G1_1R                  ;turn right
	JE CAR_RUN_G1_1S		  ;go stright
	JA CAR_RUN_G1_1L		  ;turn left

CAR_RUN_G1_1R:			  ;The car which is going to get in cross will turn right
	CMP CRO_NAMER0,0
	JE CAR_RUN_G1_1R0
	JMP OUT_G1_C3
CAR_RUN_G1_1R0:			 ;If the turn-right area are null,move the car to it.
	DEC car_array[DI].start_X
	INC car_array[DI].start_Y
	MOV CRO_NAMER0,BX	;Move the car to turn-right area
	MOV LINE_NAME[SI],0
	JMP OUT_G1_C3
	
CAR_RUN_G1_1S:			;go stright , move the car to the next step
	INC car_array[DI].start_Y
	MOV LINE_NAME[SI+2],BX
	MOV LINE_NAME[SI],0
	JMP OUT_G1_C3
	
CAR_RUN_G1_1L:	            ;turn left, move the car to the turn-left array
	MOV AL,LEFT_NAME0.COUNT
	CMP AL,LEFT_NAME0.ASIZE
	JNA CAR_RUN_G1_1LL
	JMP OUT_G1_C3
CAR_RUN_G1_1LL:
	ADD car_array[DI].start_X,2   
	ADD car_array[DI].start_Y,2
	MOV LINE_NAME[SI],0
	MOV DH,0
	MOV DL,LEFT_NAME0.Last
	MOV SI,DX
	MOV LEFT_NAME0.Array[SI],BX ; Put the car number to the turn-Left array
	INC LEFT_NAME0.COUNT	;the now array number add 1
	ADD LEFT_NAME0.Last,2
	CMP LEFT_NAME0.Last,18	;If last index >18(9*2), make the last index 0
	JNA OUT_G1_C3
	MOV LEFT_NAME0.Last,0

	
OUT_G1_C3:
	JMP CAR_RUN_G1_C4

CAR_RUN_G1_C4:			;move the car to the next step on last road
	MOV CX,9
	MOV SI,16
CAR_RUN_G1_L00:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_G1_TMOV00
CAR_RUN_G1_RE00:
	SUB SI,2
	LOOP CAR_RUN_G1_L00
	JMP far ptr CAR_OUT_T
CAR_RUN_G1_TMOV00:
	CMP LINE_NAME[SI+2],0
	JE CAR_RUN_G1_MOV00
	SUB SI,2
	LOOP CAR_RUN_G1_L00
	JMP far ptr CAR_OUT_T	
CAR_RUN_G1_MOV00:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	INC car_array[DI].start_Y
	MOV LINE_NAME[SI+2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_G1_RE00
CAR_OUT_T:
	POP DI
	POP DX
	POP CX
	POP BX
	POP AX
	POP SI

	ENDM
;The define of writing a pixel
WRITE_PIXEL MACRO PAGE,ROW,COLUMN,COLOR
        PUSH AX
        PUSH BX
	PUSH CX
	PUSH DX
	MOV AH,0CH
        MOV AL,COLOR
        MOV BH,PAGE
        MOV DX,ROW
        MOV CX,COLUMN
        INT 10H
	POP DX
	POP CX
	POP BX
        POP AX
        ENDM 
;The define of writing a line
WRITE_LINE MACRO PAGE,ROW,R_L,COLUMN,C_L,COLOR
        LOCAL LINE1,LINE2
	PUSH BX
	PUSH CX
	PUSH ROW
	PUSH COLUMN
        MOV CX,R_L
        MOV BX,COLUMN
  LINE1:PUSH CX
        MOV CX,C_L
        MOV COLUMN,BX
  LINE2:WRITE_PIXEL PAGE,ROW,COLUMN,COLOR
        INC COLUMN
        LOOP LINE2
        INC ROW
        POP CX
        LOOP LINE1
	POP COLUMN
	POP ROW
	POP CX
	POP BX
        ENDM
;Write a turn-left area
WRITE_LEFT MACRO PAGE,ROW,R_L,COLUMN,C_L,COLOR,FROM_NAME
	LOCAL LEFT1,LEFT2,LEFT3,LEFT4,LEFT_OUT
	PUSH ROW
	PUSH COLUMN
	PUSH AX
	PUSH BX
	PUSH CX
	MOV CX,R_L
	CMP FROM_NAME,1
	JA LEFT3
LEFT1:	PUSH CX					;LINEX_0’s turn-left area
	MOV BX,COLUMN
	MOV AX,ROW
	MOV CX,C_L
LEFT2:	WRITE_PIXEL PAGE,ROW,COLUMN,COLOR
	INC ROW
	INC COLUMN
	LOOP LEFT2
	MOV ROW,AX
	MOV COLUMN,BX
	INC COLUMN
	DEC ROW
	POP CX
	LOOP LEFT1
	JMP LEFT_OUT
LEFT3:	PUSH CX					;LINEX_1’s turn-left area
	MOV BX,COLUMN
	MOV AX,ROW
	MOV CX,C_L
LEFT4:	WRITE_PIXEL PAGE,ROW,COLUMN,COLOR
	DEC ROW
	INC COLUMN
	LOOP LEFT4
	MOV ROW,AX
	MOV COLUMN,BX
	INC COLUMN
	INC ROW
	POP CX
	LOOP LEFT3
LEFT_OUT:
	POP CX
	POP BX
	POP AX
	POP COLUMN
	POP ROW
	ENDM


;Write a number 
WRITE_NUM MACRO NUM_X,NUM_Y,NUM,COLOR
	LOCAL WRITE_SHI,WRITE_GE
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	MOV BH,0
	MOV DH,NUM_Y
	MOV DL,NUM_X
	MOV AH,2
	INT 10H	
	MOV CX,1
	MOV AH,0
	MOV AL,NUM
	MOV DH,10
	DIV DH
	MOV DH,AH
WRITE_SHI:
	MOV BL,COLOR
        ADD AL,'0'
	MOV AH,0EH
	INT 10H
WRITE_GE:
	MOV BL,COLOR
	MOV AH,09H
	MOV AL,DH
        ADD AL,'0'
	INT 10H
	POP DX
	POP CX
	POP BX
	POP AX
	ENDM



CAR_RUN MACRO LINE_NAME,LIGHT_NAME,FROM_NAME
	LOCAL CAR_GREEN, CAR_YELLOW, CAR_RED, CAR_RUN_START, CAR_RUN_0, CAR_RUN_LOOP0, CAR_RUN_LOOP0_RE, CAR_RUN_0_MOV, CAR_RUN_DELET0, CAR_RUN_1,CAR_RUN_LOOP1,CAR_RUN_LOOP1_RE, CAR_RUN_1_MOV, CAR_RUN_DELET1
        LOCAL CAR_RUN_2, CAR_RUN_LOOP2, CAR_RUN_LOOP2_RE, CAR_RUN_2_MOV, CAR_RUN_DELET2, CAR_RUN_3, CAR_RUN_LOOP3, CAR_RUN_LOOP3_RE, CAR_RUN_3_MOV, CAR_RUN_DELET3, CAR_OUT
	LOCAL TO_CAR_RUN_1,TO_CAR_RUN_2,TO_CAR_RUN_3
        LOCAL CAR_RUN_RY0,CAR_RUN_RY_L0,CAR_RUN_RY_MOV0,CAR_RUN_RY_TMOV0,CAR_RUN_RY_RE0,CAR_RUN_RY1,CAR_RUN_RY_L1,CAR_RUN_RY_MOV1,CAR_RUN_RY_TMOV1,CAR_RUN_RY_RE1,CAR_RUN_RY2,CAR_RUN_RY_L2,CAR_RUN_RY_MOV2,CAR_RUN_RY_TMOV2,CAR_RUN_RY_RE2
	LOCAL CAR_RUN_RY3,CAR_RUN_RY_L3,CAR_RUN_RY_MOV3,CAR_RUN_RY_TMOV3,CAR_RUN_RY_RE3
	LOCAL CAR_RUN_RY00,CAR_RUN_RY_L00,CAR_RUN_RY_MOV00,CAR_RUN_RY_TMOV00,CAR_RUN_RY_RE00,CAR_RUN_RY10,CAR_RUN_RY_L10,CAR_RUN_RY_MOV10,CAR_RUN_RY_TMOV10,CAR_RUN_RY_RE10
	LOCAL CAR_RUN_RY20,CAR_RUN_RY_L20,CAR_RUN_RY_MOV20,CAR_RUN_RY_TMOV20,CAR_RUN_RY_RE20,CAR_RUN_RY30,CAR_RUN_RY_L30,CAR_RUN_RY_MOV30,CAR_RUN_RY_TMOV30,CAR_RUN_RY_RE30
	PUSH SI
 	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH DI
	CMP LIGHT_NAME,0
	JA CAR_YELLOW
	JMP CAR_GREEN
CAR_GREEN:
	MOV CX,12
	JMP CAR_RUN_START
CAR_YELLOW:
	CMP LIGHT_NAME,1
	JA CAR_RED
	MOV CX,12
	JMP CAR_RUN_START
CAR_RED:
	MOV CX,10
	JMP CAR_RUN_START
CAR_RUN_START:
	CMP FROM_NAME,0
	JA  TO_CAR_RUN_1
	JMP CAR_RUN_0
TO_CAR_RUN_1:
	JMP FAR PTR CAR_RUN_1
CAR_RUN_0:
	MOV SI,0
CAR_RUN_LOOP0:
        CMP LINE_NAME[SI],0
	JA CAR_RUN_0_MOV
CAR_RUN_LOOP0_RE:
	ADD SI,2
	LOOP CAR_RUN_LOOP0
	
	CMP LIGHT_NAME,0
	JA  CAR_RUN_RY0
	JMP far ptr CAR_OUT

CAR_RUN_0_MOV:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
        MOV AX,car_array[DI].end_X
	CMP car_array[DI].start_X,AX
	JE CAR_RUN_DELET0
	DEC car_array[DI].start_X
	MOV LINE_NAME[SI-2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_LOOP0_RE
CAR_RUN_DELET0:
	MOV LINE_NAME[SI],0
	MOV car_array[DI].live,0
	JMP CAR_RUN_LOOP0_RE

CAR_RUN_RY0:
	MOV CX,21
	MOV SI,26
CAR_RUN_RY_L0:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_RY_TMOV0
CAR_RUN_RY_RE0:
	ADD SI,2
	LOOP CAR_RUN_RY_L0
	JMP CAR_RUN_RY00
CAR_RUN_RY_TMOV0:
	CMP LINE_NAME[SI-2],0
	JE CAR_RUN_RY_MOV0
	ADD SI,2
	LOOP CAR_RUN_RY_L0
	JMP CAR_RUN_RY00	
CAR_RUN_RY_MOV0:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	DEC car_array[DI].start_X
	MOV LINE_NAME[SI-2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_RY_RE0

CAR_RUN_RY00:
	MOV CX,9
	MOV SI,70
CAR_RUN_RY_L00:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_RY_TMOV00
CAR_RUN_RY_RE00:
	ADD SI,2
	LOOP CAR_RUN_RY_L00
	JMP far ptr CAR_OUT
CAR_RUN_RY_TMOV00:
	CMP LINE_NAME[SI-2],0
	JE CAR_RUN_RY_MOV00
	ADD SI,2
	LOOP CAR_RUN_RY_L00
	JMP far ptr CAR_OUT	
CAR_RUN_RY_MOV00:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	DEC car_array[DI].start_X
	MOV LINE_NAME[SI-2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_RY_RE00
	

CAR_RUN_1:
	MOV SI,86            ;43*2
	CMP FROM_NAME,1
	JA TO_CAR_RUN_2
	JMP CAR_RUN_LOOP1
TO_CAR_RUN_2:
	JMP FAR PTR CAR_RUN_2
CAR_RUN_LOOP1:	
	CMP LINE_NAME[SI],0
	JA CAR_RUN_1_MOV
CAR_RUN_LOOP1_RE:
	SUB SI,2
	LOOP CAR_RUN_LOOP1

	CMP LIGHT_NAME,0
	JA  CAR_RUN_RY1
	JMP far ptr CAR_OUT

CAR_RUN_1_MOV:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
        MOV AX,car_array[DI].end_X
	CMP car_array[DI].start_X,AX
	JE CAR_RUN_DELET1
	INC car_array[DI].start_X
	MOV LINE_NAME[SI+2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_LOOP1_RE
CAR_RUN_DELET1:
	MOV LINE_NAME[SI],0
	MOV car_array[DI].live,0
	JMP CAR_RUN_LOOP1_RE


CAR_RUN_RY1:
	MOV CX,21
	MOV SI,60
CAR_RUN_RY_L1:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_RY_TMOV1
CAR_RUN_RY_RE1:
	SUB SI,2
	LOOP CAR_RUN_RY_L1
	JMP CAR_RUN_RY10
CAR_RUN_RY_TMOV1:
	CMP LINE_NAME[SI+2],0
	JE CAR_RUN_RY_MOV1
	SUB SI,2
	LOOP CAR_RUN_RY_L1	
	JMP CAR_RUN_RY10
CAR_RUN_RY_MOV1:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	INC car_array[DI].start_X
	MOV LINE_NAME[SI+2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_RY_RE1

CAR_RUN_RY10:
	MOV CX,9
	MOV SI,16
CAR_RUN_RY_L10:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_RY_TMOV10
CAR_RUN_RY_RE10:
	SUB SI,2
	LOOP CAR_RUN_RY_L10
	JMP far ptr CAR_OUT
CAR_RUN_RY_TMOV10:
	CMP LINE_NAME[SI+2],0
	JE CAR_RUN_RY_MOV10
	SUB SI,2
	LOOP CAR_RUN_RY_L10	
	JMP far ptr CAR_OUT
CAR_RUN_RY_MOV10:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	INC car_array[DI].start_X
	MOV LINE_NAME[SI+2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_RY_RE10



CAR_RUN_2:
	MOV SI,0
	CMP FROM_NAME,2
	JA TO_CAR_RUN_3
	JMP CAR_RUN_LOOP2
TO_CAR_RUN_3:
	JMP FAR PTR CAR_RUN_3
CAR_RUN_LOOP2:
        CMP LINE_NAME[SI],0
	JA CAR_RUN_2_MOV
CAR_RUN_LOOP2_RE:
	ADD SI,2
	LOOP CAR_RUN_LOOP2

	CMP LIGHT_NAME,0
	JA  CAR_RUN_RY2
	JMP far ptr CAR_OUT


CAR_RUN_2_MOV:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
        MOV AX,car_array[DI].end_Y
	CMP car_array[DI].start_Y,AX
	JE CAR_RUN_DELET2
	DEC car_array[DI].start_Y
	MOV LINE_NAME[SI-2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_LOOP2_RE
CAR_RUN_DELET2:
	MOV LINE_NAME[SI],0
	MOV car_array[DI].live,0
	JMP CAR_RUN_LOOP2_RE


CAR_RUN_RY2:
	MOV CX,21
	MOV SI,26
CAR_RUN_RY_L2:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_RY_TMOV2
CAR_RUN_RY_RE2:
	ADD SI,2
	LOOP CAR_RUN_RY_L2
	JMP far ptr CAR_RUN_RY20
CAR_RUN_RY_TMOV2:
	CMP LINE_NAME[SI-2],0
	JE CAR_RUN_RY_MOV2
	ADD SI,2
	LOOP CAR_RUN_RY_L2
	JMP far ptr CAR_RUN_RY20	
CAR_RUN_RY_MOV2:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	DEC car_array[DI].start_Y
	MOV LINE_NAME[SI-2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_RY_RE2

CAR_RUN_RY20:
	MOV CX,9
	MOV SI,70
CAR_RUN_RY_L20:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_RY_TMOV20
CAR_RUN_RY_RE20:
	ADD SI,2
	LOOP CAR_RUN_RY_L20
	JMP far ptr CAR_OUT
CAR_RUN_RY_TMOV20:
	CMP LINE_NAME[SI-2],0
	JE CAR_RUN_RY_MOV20
	ADD SI,2
	LOOP CAR_RUN_RY_L20
	JMP far ptr CAR_OUT	
CAR_RUN_RY_MOV20:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	DEC car_array[DI].start_Y
	MOV LINE_NAME[SI-2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_RY_RE20



CAR_RUN_3:
	MOV SI,86            ;43*2
CAR_RUN_LOOP3:	
	CMP LINE_NAME[SI],0
	JA CAR_RUN_3_MOV
CAR_RUN_LOOP3_RE:
	SUB SI,2
	LOOP CAR_RUN_LOOP3

	CMP LIGHT_NAME,0
	JA  CAR_RUN_RY3
	JMP far ptr CAR_OUT

CAR_RUN_3_MOV:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	MOV AX,car_array[DI].end_Y
	CMP car_array[DI].start_Y,AX
	JE CAR_RUN_DELET3
	INC car_array[DI].start_Y
	MOV LINE_NAME[SI+2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_LOOP3_RE
CAR_RUN_DELET3:
	MOV LINE_NAME[SI],0
	MOV car_array[DI].live,0
	JMP CAR_RUN_LOOP3_RE


CAR_RUN_RY3:
	MOV CX,21
	MOV SI,60
CAR_RUN_RY_L3:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_RY_TMOV3
CAR_RUN_RY_RE3:
	SUB SI,2
	LOOP CAR_RUN_RY_L3
	JMP CAR_RUN_RY30
CAR_RUN_RY_TMOV3:
	CMP LINE_NAME[SI+2],0
	JE CAR_RUN_RY_MOV3
	SUB SI,2
	LOOP CAR_RUN_RY_L3
	JMP CAR_RUN_RY30	
CAR_RUN_RY_MOV3:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	INC car_array[DI].start_Y
	MOV LINE_NAME[SI+2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_RY_RE3

CAR_RUN_RY30:
	MOV CX,9
	MOV SI,16
CAR_RUN_RY_L30:
	CMP LINE_NAME[SI],0
	JA CAR_RUN_RY_TMOV30
CAR_RUN_RY_RE30:
	SUB SI,2
	LOOP CAR_RUN_RY_L30
	JMP far ptr CAR_OUT
CAR_RUN_RY_TMOV30:
	CMP LINE_NAME[SI+2],0
	JE CAR_RUN_RY_MOV30
	SUB SI,2
	LOOP CAR_RUN_RY_L30
	JMP far ptr CAR_OUT	
CAR_RUN_RY_MOV30:
	MOV DI,LINE_NAME[SI]
	MOV BX,DI
	MOV AX,10
	MUL DI
	MOV DI,AX
	INC car_array[DI].start_Y
	MOV LINE_NAME[SI+2],BX
	MOV LINE_NAME[SI],0
	JMP CAR_RUN_RY_RE30


CAR_OUT:
	POP DI
	POP DX
	POP CX
	POP BX
	POP AX
	POP SI
	ENDM

DATAS SEGMENT

;Main display datas
 MESS1 DB 0DH,0AH,"Welcom to my program,I'm No.36 team $"
 MESS2 DB 0DH,0AH,"Please input a number(1-2) to chose a program:$"
 MESS3 DB 0DH,0AH,"Press 1 to run the traffic simulation $"
 MESS4 DB 0DH,0AH,"Press 2 to run the smart traffic simulation$"
 MESS5 DB 0DH,0AH,"Your choice: $"
 MESS6 DB 0DH,0AH,"1-9 add the car$"
 MESS7 DB 0DH,0AH,"0 to quit $"
 MESS8 DB 0DH,0AH,"Press q to quit  $"
 
;the map data
line_array line <10,95,3,130>,<10,145,3,130>,<10,335,3,130>,<10,385,3,130>
line <190,95,3,130>,<190,145,3,130>,<190,335,3,130>,<190,385,3,130>
line <320,95,3,130>,<320,145,3,130>,<320,335,3,130>,<320,385,3,130>
line <500,95,3,130>,<500,145,3,130>,<500,335,3,130>,<500,385,3,130>
line <140,0,98,3>,<140,145,193,3>,<140,385,95,3>,<190,0,98,3>
line <190,145,193,3>,<190,385,95,3>,<450,0,98,3>,<450,145,193,3>
line <450,385,95,3>,<500,0,98,3>,<500,145,193,3>,<500,385,95,3>
;light data
light_array light <130,118,0,0>,<190,118,0,0>,<160,85,0,0>,<160,145,0,0>
light <130,358,0,0>,<190,358,0,0>,<160,325,0,0>,<160,385,0,0>
light <440,118,0,0>,<500,118,0,0>,<470,85,0,0>,<470,145,0,0>
light <440,358,0,0>,<500,358,0,0>,<470,325,0,0>,<470,385,0,0>
;
;the line data
line0_0 dw 44 dup(0)
line1_0 dw 44 dup(0)
line2_0 dw 44 dup(0)
line3_0 dw 44 dup(0)
line0_1 dw 44 dup(0)
line1_1 dw 44 dup(0)
line2_1 dw 44 dup(0)
line3_1 dw 44 dup(0)
; the car data
car_array car  377 dup(<>)

; define COLOR
 COLOR_B DB 00H
 COLOR_S DB 0FH
 COLOR_R DB 0CH
 COLOR_G DB 02H
 COLOR_Y DB 0EH
 ;The parameters of turn-left area  
 LEFT_X DW ?
 LEFT_Y DW ?
 LEFT_LX DW ?
 LEFT_LY DW ?
 LEFT_COLOR DB ?
 
;The X_Y of light number
 T_X DB 40
 T_Y DB 12
;The X_Y of car
 CAR_X DW ?
 CAR_Y DW ?
 CAR_COLOR DB ?
;The data of light number
 counter db 0
 flag_num db 59
;the flag of smart traffic
flag_smart db 0
num_smart  db 59
;states flag
 FLAG_L DB 0

;light name
light_g db 0
light_y db 1
light_r db 2

;from name
from_x_start db 0
from_x_end   db 1
from_y_start db 2
from_y_end   db 3 
;
add_line0_0 db 0
add_line1_0 db 0
add_line2_0 db 0
add_line3_0 db 0
add_line0_1 db 0
add_line1_1 db 0
add_line2_1 db 0
add_line3_1 db 0
;rand number
rand_num db 0
;turn-right area
num_cro00_r0 dw 0    ;the car number in cross will turn right
num_cro00_r1 dw 0
num_cro01_r0 dw 0
num_cro01_r1 dw 0
num_cro10_r0 dw 0
num_cro10_r1 dw 0
num_cro11_r0 dw 0
num_cro11_r1 dw 0

num_cro00_r2 dw 0   ;line1_1’s turn-right area
num_cro00_r3 dw 0
num_cro01_r2 dw 0
num_cro01_r3 dw 0
num_cro10_r2 dw 0
num_cro10_r3 dw 0
num_cro11_r2 dw 0
num_cro11_r3 dw 0

;turn-left area
cro00_l0_array Left <>
cro01_l0_array Left <>
cro00_l1_array Left <>
cro01_l1_array Left <>
cro10_l0_array Left <>
cro11_l0_array Left <>
cro10_l1_array Left <>
cro11_l1_array Left <>

cro00_l2_array Left <> ;line1_1’s turn-left
cro01_l2_array Left <>
cro00_l3_array Left <>
cro01_l3_array Left <>
cro10_l2_array Left <>
cro11_l2_array Left <>
cro10_l3_array Left <>
cro11_l3_array Left <>
;the X_Y of place start and end
place1 place <0,11,0,10>
place2 place <10,0,11,0>
Place3 place <32,0,33,0>
place4 place <43,10,43,11>
place5 place <0,33,0,32>
place6 place <11,43,10,43>
Place7 place <33,43,32,43>
place8 place <43,32,43,33>




DATAS ENDS

STACKS SEGMENT
  DW 100 DUP(0)
STACKS ENDS

CODES SEGMENT

 ASSUME CS:CODES,DS:DATAS
 START:
       MOV     AX,DATAS
       MOV     DS,AX
       LEA     DX,MESS1
       MOV     AH,9
       INT     21H
DISPLAY:  
        LEA     DX,MESS2
        MOV     AH,9
        INT     21H
        LEA     DX,MESS3
        MOV     AH,9
        INT     21H
        LEA     DX,MESS4
        MOV     AH,9
        INT     21H
        LEA     DX,MESS8
        MOV     AH,9
        INT     21H
        LEA     DX,MESS5
        MOV     AH,9
        INT     21H
INPUT:  MOV AH,7
        INT 21H
        CMP AL,'1'
        JE  SIM		;run the traffic simulation
        CMP AL,'2'
		JE SMA		;run the smart traffic simulation
		CMP AL,'q'
		JE ALL_OUT
        JMP DISPLAY
ALL_OUT:
		MOV AX,4C00H
		INT 21H
SMA:
		MOV flag_smart,1

SIM:   	MOV AX,0
       	CALL INIT_INT
	
		MOV AH,0
        MOV AL,12H ;640*480*16
        INT 10H
		MOV BH,0
		MOV DH,15
		MOV DL,40
		MOV AH,2
		INT 10H	
		LEA     DX,MESS6
        MOV     AH,9
        INT     21H
        LEA     DX,MESS7
        MOV     AH,9
        INT     21H
        CALL MAP
INPUT_NUM:
        Mov ah,0bh
        Int 21h
        Inc al
        jnz INPUT_NUM
        CALL ADD_RAND 	; If input something,add a rand number
        MOV AH,08H
        INT 21H
        CMP AL,'0'
	JA INC_LINE0_0
        Je goout
	JMP INPUT_NUM
INC_LINE0_0:	
        CMP AL,'1'
	JA INC_LINE1_0
	INC add_line0_0
	JMP INPUT_NUM
INC_LINE1_0:
        CMP AL,'2'
	JA INC_LINE2_0
	INC add_line1_0
	JMP INPUT_NUM
INC_LINE2_0:
        CMP AL,'3'
	JA INC_LINE3_0
	INC add_line2_0
	JMP INPUT_NUM
INC_LINE3_0:
        CMP AL,'4'
	JA INC_LINE0_1
	INC add_line3_0
	JMP INPUT_NUM
INC_LINE0_1:
        CMP AL,'5'
	JA INC_LINE1_1
	INC add_line0_1
	JMP INPUT_NUM
INC_LINE1_1:
        CMP AL,'6'
	JA INC_LINE2_1
	INC add_line1_1
	JMP INPUT_NUM
INC_LINE2_1:
        CMP AL,'7'
	JA INC_LINE3_1
	INC add_line2_1
	JMP INPUT_NUM
INC_LINE3_1:
        CMP AL,'8'
	JA INC_ALL
	INC add_line3_1
	JMP INPUT_NUM
INC_ALL:
        CMP AL,'9'
	JA INPUT_NUM
	INC add_line0_0
	INC add_line1_0
	INC add_line2_0
	INC add_line3_0
	INC add_line0_1
	INC add_line1_1
	INC add_line2_1
	INC add_line3_1
	JMP INPUT_NUM
goout:
        Mov ax,4c00h
        int 21h
;create a rand number 0-4 , and put in the rand_array
ADD_RAND PROC		
	PUSH AX
	PUSH DX
	MOV ah,0
	MOV AL,counter
	MOV DH,5
	DIV DH
	MOV Rand_num,AH
	POP DX
	POP AX
        RET
ADD_RAND ENDP

;draw the map
MAP PROC
       PUSH DS
	PUSH DI
	PUSH AX
	PUSH CX
       MOV AX,DATAS
       MOV DS,AX
       MOV CX,28
       mov di,0
    M: 
       WRITE_LINE 0,line_array[di].Y,line_array[di].R_L,line_array[di].X,line_array[di].C_L,COLOR_S

       ADD DI,8
       LOOP M 
	POP CX
	POP AX
	POP DI
       POP DS
       RET
MAP ENDP

;draw the light
show_LIGHT PROC
	PUSH DS
       PUSH DI
       PUSH AX 
       PUSH CX
       MOV AX,DATAS
       MOV DS,AX
       MOV CX,16
       mov di,0
    L: 
       WRITE_LINE 0,light_array[di].Y1,10,light_array[di].X1,10,light_array[di].COLOR
       ADD DI,6
       LOOP L 
       POP CX
	POP AX
	POP DI
	POP DS
       RET
      
show_LIGHT ENDP

;show the light number
Show_num PROC
	PUSH DS
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	MOV AX,DATAS
	MOV DS,AX 
	WRITE_NUM T_X,T_Y,flag_num,COLOR_S
	WRITE_NUM 35,16,add_line0_0,COLOR_S
	WRITE_NUM 35,17,add_line1_0,COLOR_S
	WRITE_NUM 35,18,add_line2_0,COLOR_S
	WRITE_NUM 35,19,add_line3_0,COLOR_S
	WRITE_NUM 38,14,add_line0_1,COLOR_S
	WRITE_NUM 41,14,add_line1_1,COLOR_S
	WRITE_NUM 44,14,add_line2_1,COLOR_S
	WRITE_NUM 47,14,add_line3_1,COLOR_S
	
	WRITE_NUM 45,16,num_smart,COLOR_S
		
	POP DX
	POP CX
	POP BX
	POP AX
	POP DS
	ret
show_num ENDP

;
Show_car PROC
       PUSH DS
       PUSH AX
       PUSH BX
       PUSH CX
       PUSH DX
       PUSH SI
       PUSH DI
       MOV AX,DATAS
       MOV DS,AX
Show_car0_0:
       MOV SI,0
       MOV DI,0
       MOV CX,10
       MOV BX,line_array[DI].X
       MOV DX,line_array[DI].Y
       MOV CAR_X,BX
       MOV CAR_Y,DX
       ADD CAR_Y,10
       CALL SHOW_CAR_LOOP00
       ADD CAR_X,50
       ADD SI,4
       MOV CX,20
       CALL SHOW_CAR_LOOP00
       ADD CAR_X,50
       ADD SI,4
       MOV CX,10
       CALL SHOW_CAR_LOOP00
Show_car1_0:
       MOV SI,0
       MOV DI,8
       MOV CX,10
       MOV BX,line_array[DI].X
       MOV DX,line_array[DI].Y
       MOV CAR_X,BX
       MOV CAR_Y,DX
       SUB CAR_Y,10
       CALL SHOW_CAR_LOOP10
       ADD CAR_X,50
       ADD SI,4
       MOV CX,20
       CALL SHOW_CAR_LOOP10
       ADD CAR_X,50
       ADD SI,4
       MOV CX,10
       CALL SHOW_CAR_LOOP10
Show_car2_0:
       MOV SI,0
       MOV DI,16
       MOV CX,10
       MOV BX,line_array[DI].X
       MOV DX,line_array[DI].Y
       MOV CAR_X,BX
       MOV CAR_Y,DX
       ADD CAR_Y,10
       CALL SHOW_CAR_LOOP20
       ADD CAR_X,50
       ADD SI,4
       MOV CX,20
       CALL SHOW_CAR_LOOP20
       ADD CAR_X,50
       ADD SI,4
       MOV CX,10
       CALL SHOW_CAR_LOOP20
Show_car3_0:
       MOV SI,0
       MOV DI,24
       MOV CX,10
       MOV BX,line_array[DI].X
       MOV DX,line_array[DI].Y
       MOV CAR_X,BX
       MOV CAR_Y,DX
       SUB CAR_Y,10
       CALL SHOW_CAR_LOOP30
       ADD CAR_X,50
       ADD SI,4
       MOV CX,20
       CALL SHOW_CAR_LOOP30
       ADD CAR_X,50
       ADD SI,4
       MOV CX,10
       CALL SHOW_CAR_LOOP30
Show_car0_1:
       MOV SI,0
       MOV DI,128
       MOV CX,10
       MOV BX,line_array[DI].X
       MOV DX,line_array[DI].Y
       MOV CAR_X,BX
       MOV CAR_Y,DX
       ADD CAR_X,10
       CALL SHOW_CAR_LOOP01
       ADD CAR_Y,45
       ADD SI,4
       MOV CX,20
       CALL SHOW_CAR_LOOP01
       ADD CAR_Y,45
       ADD SI,4
       MOV CX,10
       CALL SHOW_CAR_LOOP01
Show_car1_1:
       MOV SI,0
       MOV DI,152
       MOV CX,10
       MOV BX,line_array[DI].X
       MOV DX,line_array[DI].Y
       MOV CAR_X,BX
       MOV CAR_Y,DX
       SUB CAR_X,10
       CALL SHOW_CAR_LOOP11
       ADD CAR_Y,45
       ADD SI,4
       MOV CX,20
       CALL SHOW_CAR_LOOP11
       ADD CAR_Y,45
       ADD SI,4
       MOV CX,10
       CALL SHOW_CAR_LOOP11
Show_car2_1:
       MOV SI,0
       MOV DI,176
       MOV CX,10
       MOV BX,line_array[DI].X
       MOV DX,line_array[DI].Y
       MOV CAR_X,BX
       MOV CAR_Y,DX
       ADD CAR_X,10
       CALL SHOW_CAR_LOOP21
       ADD CAR_Y,45
       ADD SI,4
       MOV CX,20
       CALL SHOW_CAR_LOOP21
       ADD CAR_Y,45
       ADD SI,4
       MOV CX,10
       CALL SHOW_CAR_LOOP21
Show_car3_1:
       MOV SI,0
       MOV DI,200
       MOV CX,10
       MOV BX,line_array[DI].X
       MOV DX,line_array[DI].Y
       MOV CAR_X,BX
       MOV CAR_Y,DX
       SUB CAR_X,10
       CALL SHOW_CAR_LOOP31
       ADD CAR_Y,45
       ADD SI,4
       MOV CX,20
       CALL SHOW_CAR_LOOP31
       ADD CAR_Y,45
       ADD SI,4
       MOV CX,10
       CALL SHOW_CAR_LOOP31


Show_cross00:
	MOV SI,20
	MOV AX,LINE0_0[SI]
	CMP AX,0
	JA WHITEC00
        MOV AX,LINE0_1[SI]
	CMP AX,0
	JA WHITEC00
	JMP BLACKC00
WHITEC00: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C00
BLACKC00: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C00:
	MOV CAR_X,150
	MOV CAR_Y,108
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
	
	MOV SI,20
	MOV AX,LINE1_0[SI]
	CMP AX,0
	JA WHITEC10
	ADD SI,2
        MOV AX,LINE0_1[SI]
	CMP AX,0
	JA WHITEC10
	JMP BLACKC10
WHITEC10: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C10
BLACKC10: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C10:
	MOV CAR_X,150
	MOV CAR_Y,135
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
	

	MOV SI,20
	MOV AX,LINE1_1[SI]
	CMP AX,0
	JA WHITEC01
	ADD SI,2
        MOV AX,LINE0_0[SI]
	CMP AX,0
	JA WHITEC01
	JMP BLACKC01
WHITEC01: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C01
BLACKC01: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C01:
	MOV CAR_X,180
	MOV CAR_Y,108
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR


	MOV SI,22
	MOV AX,LINE1_1[SI]
	CMP AX,0
	JA WHITEC11
        MOV AX,LINE1_0[SI]
	CMP AX,0
	JA WHITEC11
	JMP BLACKC11
WHITEC11: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C11
BLACKC11: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C11:
	MOV CAR_X,180
	MOV CAR_Y,135
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

Show_cross10:
	MOV SI,20
	MOV AX,LINE2_0[SI]
	CMP AX,0
	JA WHITEC20
	ADD SI,44
        MOV AX,LINE0_1[SI]
	CMP AX,0
	JA WHITEC20
	JMP BLACKC20
WHITEC20: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C20
BLACKC20: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C20:
	MOV CAR_X,150
	MOV CAR_Y,345
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
	
	MOV SI,20
	MOV AX,LINE3_0[SI]
	CMP AX,0
	JA WHITEC30
	ADD SI,46
        MOV AX,LINE0_1[SI]
	CMP AX,0
	JA WHITEC30
	JMP BLACKC30
WHITEC30: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C30
BLACKC30: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C30:
	MOV CAR_X,150
	MOV CAR_Y,375
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
	

	MOV SI,22
	MOV AX,LINE2_0[SI]
	CMP AX,0
	JA WHITEC21
	ADD SI,42
        MOV AX,LINE1_1[SI]
	CMP AX,0
	JA WHITEC21
	JMP BLACKC21
WHITEC21: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C21
BLACKC21: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C21:
	MOV CAR_X,180
	MOV CAR_Y,345
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR


	MOV SI,22
	MOV AX,LINE3_0[SI]
	CMP AX,0
	JA WHITEC31
	ADD SI,44
        MOV AX,LINE1_1[SI]
	CMP AX,0
	JA WHITEC31
	JMP BLACKC31
WHITEC31: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C31
BLACKC31: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C31:
	MOV CAR_X,180
	MOV CAR_Y,375
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

Show_cross01:
	MOV SI,20
	MOV AX,LINE2_1[SI]
	CMP AX,0
	JA WHITEC02
	ADD SI,44
        MOV AX,LINE0_0[SI]
	CMP AX,0
	JA WHITEC02
	JMP BLACKC02
WHITEC02: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C02
BLACKC02: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C02:
	MOV CAR_X,460
	MOV CAR_Y,108
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
	
	MOV SI,22
	MOV AX,LINE2_1[SI]
	CMP AX,0
	JA WHITEC12
	ADD SI,42
        MOV AX,LINE1_0[SI]
	CMP AX,0
	JA WHITEC12
	JMP BLACKC12
WHITEC12: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C12
BLACKC12: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C12:
	MOV CAR_X,460
	MOV CAR_Y,135
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
	

	MOV SI,20
	MOV AX,LINE3_1[SI]
	CMP AX,0
	JA WHITEC03
	ADD SI,46
        MOV AX,LINE0_0[SI]
	CMP AX,0
	JA WHITEC03
	JMP BLACKC03
WHITEC03: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C03
BLACKC03: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C03:
	MOV CAR_X,490
	MOV CAR_Y,108
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR


	MOV SI,22
	MOV AX,LINE3_1[SI]
	CMP AX,0
	JA WHITEC13
	ADD SI,44
        MOV AX,LINE1_0[SI]
	CMP AX,0
	JA WHITEC13
	JMP BLACKC13
WHITEC13: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C13
BLACKC13: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C13:
	MOV CAR_X,490
	MOV CAR_Y,135
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

Show_cross11:
	MOV SI,64
	MOV AX,LINE2_0[SI]
	CMP AX,0
	JA WHITEC22
        MOV AX,LINE2_1[SI]
	CMP AX,0
	JA WHITEC22
	JMP BLACKC22
WHITEC22: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C22
BLACKC22: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C22:
	MOV CAR_X,460
	MOV CAR_Y,345
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
	
	MOV SI,64
	MOV AX,LINE3_0[SI]
	CMP AX,0
	JA WHITEC32
	ADD SI,2
        MOV AX,LINE2_1[SI]
	CMP AX,0
	JA WHITEC32
	JMP BLACKC32
WHITEC32: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C32
BLACKC32: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C32:
	MOV CAR_X,460
	MOV CAR_Y,375
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
	

	MOV SI,64
	MOV AX,LINE3_1[SI]
	CMP AX,0
	JA WHITEC23
	ADD SI,2
        MOV AX,LINE2_0[SI]
	CMP AX,0
	JA WHITEC23
	JMP BLACKC23
WHITEC23: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C23
BLACKC23: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C23:
	MOV CAR_X,490
	MOV CAR_Y,345
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR


	MOV SI,66
	MOV AX,LINE3_1[SI]
	CMP AX,0
	JA WHITEC33
        MOV AX,LINE3_0[SI]
	CMP AX,0
	JA WHITEC33
	JMP BLACKC33
WHITEC33: 
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_C33
BLACKC33: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_C33:
	MOV CAR_X,490
	MOV CAR_Y,375
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

;show the cross00’s turn-right area
	CMP num_cro00_r0,0	;show the cross00’s r0
	JA WHITER01
	JMP BLACKR01
WHITER01:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R01
BLACKR01: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R01:
	MOV CAR_X,185
	MOV CAR_Y,95
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

	CMP num_cro00_r1,0	;show the cross00’s r1
	JA WHITER10
	JMP BLACKR10
WHITER10:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R10
BLACKR10: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R10:
	MOV CAR_X,145
	MOV CAR_Y,140
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

	CMP num_cro00_r2,0	;show the cross00’s r2
	JA WHITER11
	JMP BLACKR11
WHITER11:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R11
BLACKR11: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R11:
	MOV CAR_X,185
	MOV CAR_Y,140
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

	CMP num_cro00_r3,0	;show the cross00’s r3
	JA WHITER00
	JMP BLACKR00
WHITER00:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R00
BLACKR00: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R00:
	MOV CAR_X,145
	MOV CAR_Y,95
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

;Show the cross01’s turn-right area
	CMP num_cro01_r0,0	; show the cross01’s r0
	JA WHITER03
	JMP BLACKR03
WHITER03:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R03
BLACKR03: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R03:
	MOV CAR_X,495
	MOV CAR_Y,95
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

	CMP num_cro01_r1,0	;show the cross01’s r1
	JA WHITER12
	JMP BLACKR12
WHITER12:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R12
BLACKR12: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R12:
	MOV CAR_X,455
	MOV CAR_Y,140
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

	CMP num_cro01_r2,0	;show the cross01’s r2
	JA WHITER13
	JMP BLACKR13
WHITER13:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R13
BLACKR13: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R13:
	MOV CAR_X,495
	MOV CAR_Y,140
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

	CMP num_cro01_r3,0	;show the cross01’s r3
	JA WHITER02
	JMP BLACKR02
WHITER02:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R02
BLACKR02: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R02:
	MOV CAR_X,455
	MOV CAR_Y,95
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

;show the cross10’s turn-right area
	CMP num_cro10_r0,0	;show the cross10’s r0
	JA WHITER21
	JMP BLACKR21
WHITER21:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R21
BLACKR21: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R21:
	MOV CAR_X,185
	MOV CAR_Y,335
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

	CMP num_cro10_r1,0	;show the cross10’s r1
	JA WHITER30
	JMP BLACKR30
WHITER30:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R30
BLACKR30: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R30:
	MOV CAR_X,145
	MOV CAR_Y,380
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

CMP num_cro10_r2,0	;show the cross10’s r2
	JA WHITER31
	JMP BLACKR31
WHITER31:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R31
BLACKR31: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R31:
	MOV CAR_X,185
	MOV CAR_Y,380
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

CMP num_cro10_r3,0	;show the cross10’s r3
	JA WHITER20
	JMP BLACKR20
WHITER20:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R20
BLACKR20: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R20:
	MOV CAR_X,145
	MOV CAR_Y,335
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

;Show the cross11’s turn-right area
	CMP num_cro11_r0,0	; show the cross11’s r0
	JA WHITER23
	JMP BLACKR23
WHITER23:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R23
BLACKR23: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R23:
	MOV CAR_X,495
	MOV CAR_Y,335
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

	CMP num_cro11_r1,0	;show the cross11’s r1
	JA WHITER32
	JMP BLACKR32
WHITER32:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R32
BLACKR32: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R32:
	MOV CAR_X,455
	MOV CAR_Y,380
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

	CMP num_cro11_r2,0	;show the cross11’s r2
	JA WHITER33
	JMP BLACKR33
WHITER33:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R33
BLACKR33: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R33:
	MOV CAR_X,495
	MOV CAR_Y,380
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

	CMP num_cro11_r3,0	;show the cross11’s r3
	JA WHITER22
	JMP BLACKR22
WHITER22:
	MOV AL,COLOR_S
        MOV CAR_COLOR,AL
        JMP WRITE_CAR_R22
BLACKR22: 
	MOV AL,COLOR_B
        MOV CAR_COLOR,AL
WRITE_CAR_R22:
	MOV CAR_X,455
	MOV CAR_Y,335
	WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR

;show the cross00’s turn-left area
	CMP cro00_l0_array.count,0      ;show the cross00’s l0
	JA WHITEL01
	JMP BLACKL01
WHITEL01:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro00_l0_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L01
BLACKL01: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L01:
	MOV LEFT_X,175
	MOV LEFT_Y,125
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_X_START

	CMP cro00_l1_array.count,0	;show the cross00’s l1
	JA WHITEL10
	JMP BLACKL10
WHITEL10:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro00_l1_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L10
BLACKL10: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L10:
	MOV LEFT_X,145
	MOV LEFT_Y,125
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_X_END

	CMP cro00_l2_array.count,0	;show the cross00’s l2
	JA WHITEL11
	JMP BLACKL11
WHITEL11:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro00_l2_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L11
BLACKL11: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L11:
	MOV LEFT_X,165
	MOV LEFT_Y,125
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_Y_START

	CMP cro00_l3_array.count,0	;show the cross00’s l3
	JA WHITEL00
	JMP BLACKL00
WHITEL00:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro00_l3_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L00
BLACKL00: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L00:
	MOV LEFT_X,155
	MOV LEFT_Y,105
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_Y_END

;show the cross01’s turn-left area
	CMP cro01_l0_array.count,0       ;show the cross01’s l0
	JA WHITEL03
	JMP BLACKL03
WHITEL03:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro01_l0_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L03
BLACKL03: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L03:
	MOV LEFT_X,485
	MOV LEFT_Y,125
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_X_START

	CMP cro01_l1_array.count,0    ;show the cross01’s l1
	JA WHITEL12
	JMP BLACKL12
WHITEL12:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro01_l1_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L12
BLACKL12: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L12:
	MOV LEFT_X,455
	MOV LEFT_Y,125
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_X_END

	CMP cro01_l2_array.count,0    ;show the cross01’s l2
	JA WHITEL13
	JMP BLACKL13
WHITEL13:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro01_l2_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L13
BLACKL13: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L13:
	MOV LEFT_X,475
	MOV LEFT_Y,125
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_Y_START

	CMP cro01_l3_array.count,0    ;show the cross01’s l3
	JA WHITEL02
	JMP BLACKL02
WHITEL02:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro01_l3_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L02
BLACKL02: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L02:
	MOV LEFT_X,465
	MOV LEFT_Y,105
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_Y_END

;show the cross10’s turn-left area
	CMP cro10_l0_array.count,0	;show the cross10’s l0
	JA WHITEL21
	JMP BLACKL21
WHITEL21:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro10_l0_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L21
BLACKL21: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L21:
	MOV LEFT_X,175
	MOV LEFT_Y,365
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_X_START

	CMP cro10_l1_array.count,0	;show the cross10’s l1
	JA WHITEL30
	JMP BLACKL30
WHITEL30:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro10_l1_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L30
BLACKL30: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L30:
	MOV LEFT_X,145
	MOV LEFT_Y,365
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_X_END	

	CMP cro10_l2_array.count,0	;show the cross10’s l2
	JA WHITEL31
	JMP BLACKL31
WHITEL31:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro10_l1_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L31
BLACKL31: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L31:
	MOV LEFT_X,165
	MOV LEFT_Y,365
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_Y_START

	CMP cro10_l3_array.count,0	;show the cross10’s l3
	JA WHITEL20
	JMP BLACKL20
WHITEL20:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro10_l1_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L20
BLACKL20: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L20:
	MOV LEFT_X,155
	MOV LEFT_Y,345
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_Y_END

;show the cross11’s turn-left area
	CMP cro11_l0_array.count,0	;show the cross11’s l0
	JA WHITEL23
	JMP BLACKL23
WHITEL23:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro11_l0_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L23
BLACKL23: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L23:
	MOV LEFT_X,485
	MOV LEFT_Y,365
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_X_START

	CMP cro11_l1_array.count,0	;show the cross11’s l1
	JA WHITEL32
	JMP BLACKL32
WHITEL32:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro11_l1_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L12
BLACKL32: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L32:
	MOV LEFT_X,455
	MOV LEFT_Y,365
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_X_END
	
	CMP cro11_l2_array.count,0	;show the cross11’s l2
	JA WHITEL33
	JMP BLACKL33
WHITEL33:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro11_l2_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L33
BLACKL33: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L33:
	MOV LEFT_X,475
	MOV LEFT_Y,365
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_Y_START

	CMP cro11_l3_array.count,0	;show the cross11’s l3
	JA WHITEL22
	JMP BLACKL22
WHITEL22:
	MOV AL,COLOR_S
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV AL,cro11_l3_array.count
	ADD AL,4
	MOV AH,0
	MOV LEFT_LY,AX
        JMP WRITE_CAR_L22
BLACKL22: 
	MOV AL,COLOR_B
        MOV LEFT_COLOR,AL
	MOV LEFT_LX,4
	MOV LEFT_LY,14
WRITE_CAR_L22:
	MOV LEFT_X,465
	MOV LEFT_Y,345
	WRITE_LEFT 0,LEFT_Y,LEFT_LY,LEFT_X,LEFT_LX,LEFT_COLOR,FROM_Y_END
	


       Jmp showout

Show_car_LOOP00:
       Mov AX,LINE0_0[SI]
       Cmp AX,0
       JA WHITE00
       JMP BLACK00
WHITE00: MOV AL,COLOR_S
       MOV CAR_COLOR,AL
       JMP WRITE_CAR0_0
BLACK00: MOV AL,COLOR_B
       MOV CAR_COLOR,AL
WRITE_CAR0_0:
       WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
       ADD CAR_X,13
       ADD SI,2
       LOOP SHOW_CAR_LOOP00
       RET      

Show_car_LOOP10:
       Mov AX,LINE1_0[SI]
       Cmp AX,0
       JA WHITE10
       JMP BLACK10
WHITE10: MOV AL,COLOR_S
       MOV CAR_COLOR,AL
       JMP WRITE_CAR1_0
BLACK10: MOV AL,COLOR_B
       MOV CAR_COLOR,AL
WRITE_CAR1_0:
       WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
       ADD CAR_X,13
       ADD SI,2
       LOOP SHOW_CAR_LOOP10
       RET 

Show_car_LOOP20:
       Mov AX,LINE2_0[SI]
       Cmp AX,0
       JA WHITE20
       JMP BLACK20
WHITE20: MOV AL,COLOR_S
       MOV CAR_COLOR,AL
       JMP WRITE_CAR2_0
BLACK20: MOV AL,COLOR_B
       MOV CAR_COLOR,AL
WRITE_CAR2_0:
       WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
       ADD CAR_X,13
       ADD SI,2
       LOOP SHOW_CAR_LOOP20
       RET 

Show_car_LOOP30:
       Mov AX,LINE3_0[SI]
       Cmp AX,0
       JA WHITE30
       JMP BLACK30
WHITE30: MOV AL,COLOR_S
       MOV CAR_COLOR,AL
       JMP WRITE_CAR3_0
BLACK30: MOV AL,COLOR_B
       MOV CAR_COLOR,AL
WRITE_CAR3_0:
       WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
       ADD CAR_X,13
       ADD SI,2
       LOOP SHOW_CAR_LOOP30
       RET
    
Show_car_LOOP01:
       Mov AX,LINE0_1[SI]
       Cmp AX,0
       JA WHITE01
       JMP BLACK01
WHITE01: MOV AL,COLOR_S
       MOV CAR_COLOR,AL
       JMP WRITE_CAR0_1
BLACK01: MOV AL,COLOR_B
       MOV CAR_COLOR,AL
WRITE_CAR0_1:
       WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
       ADD CAR_Y,10
       ADD SI,2
       LOOP SHOW_CAR_LOOP01
       RET  

Show_car_LOOP11:
       Mov AX,LINE1_1[SI]
       Cmp AX,0
       JA WHITE11
       JMP BLACK11
WHITE11: MOV AL,COLOR_S
       MOV CAR_COLOR,AL
       JMP WRITE_CAR1_1
BLACK11: MOV AL,COLOR_B
       MOV CAR_COLOR,AL
WRITE_CAR1_1:
       WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
       ADD CAR_Y,10
       ADD SI,2
       LOOP SHOW_CAR_LOOP11
       RET

Show_car_LOOP21:
       Mov AX,LINE2_1[SI]
       Cmp AX,0
       JA WHITE21
       JMP BLACK21
WHITE21: MOV AL,COLOR_S
       MOV CAR_COLOR,AL
       JMP WRITE_CAR2_1
BLACK21: MOV AL,COLOR_B
       MOV CAR_COLOR,AL
WRITE_CAR2_1:
       WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
       ADD CAR_Y,10
       ADD SI,2
       LOOP SHOW_CAR_LOOP21
       RET

Show_car_LOOP31:
       Mov AX,LINE3_1[SI]
       Cmp AX,0
       JA WHITE31
       JMP BLACK31
WHITE31: MOV AL,COLOR_S
       MOV CAR_COLOR,AL
       JMP WRITE_CAR3_1
BLACK31: MOV AL,COLOR_B
       MOV CAR_COLOR,AL
WRITE_CAR3_1:
       WRITE_LINE 0,CAR_Y,5,CAR_X,5,CAR_COLOR
       ADD CAR_Y,10
       ADD SI,2
       LOOP SHOW_CAR_LOOP31
       RET

    
SHOWOUT:	 
       POP DI
       POP SI
       POP DX
       POP CX
       POP BX
       POP AX
       POP DS
       RET
Show_car ENDP
;change the address of int08 
INIT_INT PROC
        PUSH AX
        PUSH DX
        cli
        mov al,08h
        mov ah,35h
        int 21h
        push ds
        mov ax,seg int08h
        mov ds,ax
        mov dx,offset int08h
        mov al,08h
        mov ah,25h
        int 21h
        pop ds
        sti
        POP DX
        POP AX
        ret
INIT_INT ENDP

;the int08 code
int08h proc
	Push ax
 	Push ds
 	inc counter
 	Cmp counter,18
 	je i
 	Jmp b
i:
 	Mov counter,0
 	CALL show_LIGHT
 	CALL SHOW_num
 	CALL SHOW_CAR
 	call one_num
 	Call one_light
 	call one_run
 	call one_add

b:
 	mov al,20h
 	out 20h,al 
 	Pop ds
 	Pop ax
 	iret
int08h endp

;the algorithm of smart traffic simulation
SMART PROC
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	CMP flag_smart,1 	;choose use the smart or not 
	JE SMART_ADD		
	JMP FAR PTR SMART_OUT	;if don’t use the smart,then out
SMART_ADD:			;accumulation the car number of N_R and W_E lines
	MOV BX,0
	MOV DX,0
SMART_ADD00:			;ADD the line0_0	
	MOV SI,0
	MOV CX,44
SMART_ADD00_L:
	CMP line0_0[SI],0
	JA SMART_ADD00_0
	ADD SI,2
	LOOP SMART_ADD00_L
	JMP SMART_ADD10
SMART_ADD00_0:
	INC BX			;If line has a car,make the BX add 1
	ADD SI,2
	LOOP SMART_ADD00_L
	JMP SMART_ADD10
SMART_ADD10:			;ADD the line1_0	
	MOV SI,0
	MOV CX,44
SMART_ADD10_L:
	CMP line1_0[SI],0
	JA SMART_ADD10_0
	ADD SI,2
	LOOP SMART_ADD10_L
	JMP SMART_ADD20
SMART_ADD10_0:
	INC BX			;If line has a car,make the BX add 1
	ADD SI,2
	LOOP SMART_ADD10_L
	JMP SMART_ADD20
SMART_ADD20:			;ADD the line2_0	
	MOV SI,0
	MOV CX,44
SMART_ADD20_L:
	CMP line1_0[SI],0
	JA SMART_ADD20_0
	ADD SI,2
	LOOP SMART_ADD20_L
	JMP SMART_ADD30
SMART_ADD20_0:
	INC BX			;If line has a car,make the BX add 1
	ADD SI,2
	LOOP SMART_ADD20_L
	JMP SMART_ADD30
SMART_ADD30:			;ADD the line3_0	
	MOV SI,0
	MOV CX,44
SMART_ADD30_L:
	CMP line1_0[SI],0
	JA SMART_ADD30_0
	ADD SI,2
	LOOP SMART_ADD30_L
	JMP SMART_ADD01
SMART_ADD30_0:
	INC BX			;If line has a car,make the DX add 1
	ADD SI,2
	LOOP SMART_ADD30_L
	JMP SMART_ADD01
SMART_ADD01:			;ADD the line0_1
	MOV SI,0
	MOV CX,44
SMART_ADD01_L:
	CMP line0_1[SI],0
	JA SMART_ADD01_0
	ADD SI,2
	LOOP SMART_ADD01_L
	JMP SMART_ADD11
SMART_ADD01_0:
	INC DX			;If line has a car,make the DX add 1
	ADD SI,2
	LOOP SMART_ADD01_L
	JMP SMART_ADD11
SMART_ADD11:			;ADD the line1_1
	MOV SI,0
	MOV CX,44
SMART_ADD11_L:
	CMP line1_1[SI],0
	JA SMART_ADD11_0
	ADD SI,2
	LOOP SMART_ADD11_L
	JMP SMART_ADD21
SMART_ADD11_0:
	INC DX			;If line has a car,make the DX add 1
	ADD SI,2
	LOOP SMART_ADD11_L
	JMP SMART_ADD21
SMART_ADD21:			;ADD the line2_1
	MOV SI,0
	MOV CX,44
SMART_ADD21_L:
	CMP line2_1[SI],0
	JA SMART_ADD21_0
	ADD SI,2
	LOOP SMART_ADD21_L
	JMP SMART_ADD31
SMART_ADD21_0:
	INC DX			;If line has a car,make the DX add 1
	ADD SI,2
	LOOP SMART_ADD21_L
	JMP SMART_ADD31
SMART_ADD31:			;ADD the line3_1
	MOV SI,0
	MOV CX,44
SMART_ADD31_L:
	CMP line3_1[SI],0
	JA SMART_ADD31_0
	ADD SI,2
	LOOP SMART_ADD31_L
	JMP SMART_NOW
SMART_ADD31_0:
	INC DX			;If line has a car,make the DX add 1
	ADD SI,2
	LOOP SMART_ADD31_L
	JMP SMART_NOW


SMART_NOW:
	MOV num_smart,59
	CMP AX,1	
	JE SMART_1		
	CMP AX,3
	JE SMART_3
	JMP SMART_OUT
SMART_1:			;the next state is flag2(Sorth and North is green)
	CMP BX,DX
	JA SMART_1_DEC		;decrease the light number
	JMP SMART_1_NO		;don’t move
	
SMART_1_DEC:
	SUB BX,DX
	SUB num_smart,BL
	CMP num_smart,30
	JA  SMART_1_NO
	MOV num_smart,30
SMART_1_NO:
	JMP SMART_OUT
SMART_3:			;the next state is flag0(East and West is green)
	CMP BX,DX
	JB SMART_3_DEC		;decrease the light number
	JMP SMART_3_NO		;don’t move
	
SMART_3_DEC:
	SUB DX,BX
	SUB num_smart,DL
	CMP num_smart,30
	JA  SMART_3_NO
	MOV num_smart,30
SMART_3_NO:
	JMP SMART_OUT

SMART_OUT:
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
SMART ENDP

;the light change 
one_light PROC
 	PUSH CX
 	PUSH AX
 	PUSH di
 	Mov di,0
 	MOV CX,4
 	Cmp FLAG_L,0    ;West and East green light , South and North red light
 	JA OL1
OL0:
 	MOV AL,COLOR_G
 	MOV AH,COLOR_R
 	JMP OLIN
OL1:
 	CMP FLAG_L,1
 	JA OL2
 	MOV AL,COLOR_Y
 	MOV AH,COLOR_R
 	JMP OLIN
OL2:
 	CMP FLAG_L,2
 	JA OL3
 	MOV AL,COLOR_R
 	MOV AH,COLOR_G
 	JMP OLIN
OL3:
 	MOV AL,COLOR_R
 	MOV AH,COLOR_Y
 	JMP OLIN 
OLIN:
 	MOV light_array[di].COLOR,AL
 	ADD di,6
 	MOV light_array[di].COLOR,AL
 	ADD di,6
 	MOV light_array[di].COLOR,AH
 	ADD di,6
 	MOV light_array[di].COLOR,AH
 	ADD di,6
 	LOOP OLIN
 	Pop di
 	POP AX
 	POP CX
	RET
one_light endp
;the state change
one_num PROC
	PUSH AX
	PUSH BX
O0:			;the state0:West and East is green light,North and South is Red
 	cmp FLAG_L,0
 	JA O1
	MOV bl,num_smart
 	Dec flag_num 
 	Cmp flag_num,BL
 	ja O0_1
 	Jmp OOUT
O0_1:			;the state0 to state1
 	mov FLAG_L,1
 	MOV flag_num,3
 	jmp oout
O1:			;the state1:West and East is yellow light,North and South is Red
 	cmp FLAG_L,1
 	JA O2
 	DEC flag_num
 	Cmp flag_num,3
 	ja O1_2
 	JMP OOUT
O1_2:			;the state1 to state2
	MOV AX,1
	CALL SMART
 	MOV FLAG_L,2
	MOV BL,num_smart
 	MOV flag_num,BL
 	JMP OOUT
O2:			;the state2:West and East is red light,North and South is green
 	Cmp FLAG_L,2
 	JA O3
	MOV bl,num_smart
 	Dec flag_num 
 	Cmp flag_num,BL
 	ja O2_3
 	JMP OOUT
O2_3: 			;the state2 to state3
 	MOV FLAG_L,3
 	MOV flag_num,3
 	JMP OOUT
O3:			;the state3:West and East is red light,North and South is yellow
 	DEC flag_num
 	CMP flag_num,3
 	Ja O3_0
 	JMP OOUT
O3_0:			;the state3 to state0
	MOV AX,3
	CALL SMART
	MOV BL,num_smart
 	MOV flag_num,BL
	MOV FLAG_L,0
	JMP OOUT
OOUT:
	POP BX
	POP AX
 	RET
one_num endp

one_run PROC

	JMP FAR PTR start_run
	
ONE_RUN_OUT1:
 RET
one_run endp
;get the rand number
GET_RAND PROC
	MOV AL,Rand_num
	MOV AH,0
	INC Rand_num
	CMP Rand_num,5
	JB GET_RAND_OUT
	MOV Rand_num,0
GET_RAND_OUT:	
	RET
GET_RAND ENDP
one_add proc
	PUSH AX
	PUSH CX
	PUSH DX
	PUSH DI
ADD_LINE00:
	CMP LINE0_0[86],0
	JE ADD_LINE00_CAR
	JMP ADD_LINE10
ADD_LINE00_CAR:
	CMP add_line0_0,0
	JA ADD_LINE00_CAR0
	JMP ADD_LINE10
ADD_LINE00_CAR0:
	MOV DI,10
	MOV CX,337
ADD_LINE00_CAR1:
	CMP CAR_ARRAY[DI].live,0
	JE ADD_LINE00_CAR2
	ADD DI,10
	LOOP ADD_LINE00_CAR1
	JMP ADD_OUT
ADD_LINE00_CAR2:
	MOV AX,place4.X_start
	MOV CAR_ARRAY[DI].start_X,AX
	MOV AX,place4.Y_start
	MOV CAR_ARRAY[DI].start_Y,AX

	CALL GET_RAND

	CMP AX,0
	JA ADD_LINE00_P2			
ADD_LINE00_P1:					;to the place 1
	MOV AX,place1.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place1.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE00_OUT
ADD_LINE00_P2:					;to the place 2
	CMP AX,1
	JA ADD_LINE00_P3	
	MOV AX,place2.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place2.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE00_OUT
ADD_LINE00_P3:					;to the place 3
	CMP AX,2
	JA ADD_LINE00_P6	
	MOV AX,place3.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place3.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE00_OUT
ADD_LINE00_P6:					;to the place 6
	CMP AX,3
	JA ADD_LINE00_P7	
	MOV AX,place6.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place6.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE00_OUT
ADD_LINE00_P7:					;to the place 7
	MOV AX,place7.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place7.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE00_OUT
ADD_LINE00_OUT:
	MOV CAR_ARRAY[DI].live,1
	MOV DH,10
	MOV AX,DI
	DIV DH
	MOV LINE0_0[86],AX
	DEC add_line0_0


ADD_LINE10:
	CMP LINE1_0[0],0
	JE ADD_LINE10_CAR
	JMP ADD_LINE20
ADD_LINE10_CAR:
	CMP add_line1_0,0
	JA ADD_LINE10_CAR0
	JMP ADD_LINE20
ADD_LINE10_CAR0:
	MOV DI,10
	MOV CX,337
ADD_LINE10_CAR1:
	CMP CAR_ARRAY[DI].live,0
	JE ADD_LINE10_CAR2
	ADD DI,10
	LOOP ADD_LINE10_CAR1
	JMP ADD_OUT
ADD_LINE10_CAR2:
	MOV AX,place1.X_start
	MOV CAR_ARRAY[DI].start_X,AX
	MOV AX,place1.Y_start
	MOV CAR_ARRAY[DI].start_Y,AX
	
	CALL GET_RAND
	CMP AX,0
	JA ADD_LINE10_P3			
ADD_LINE10_P2:					;to the place 2
	MOV AX,place2.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place2.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE10_OUT
ADD_LINE10_P3:					;to the place 3
	CMP AX,1
	JA ADD_LINE10_P4	
	MOV AX,place3.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place3.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE10_OUT
ADD_LINE10_P4:					;to the place 4
	CMP AX,2
	JA ADD_LINE10_P6	
	MOV AX,place4.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place4.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE10_OUT
ADD_LINE10_P6:					;to the place 6
	CMP AX,3
	JA ADD_LINE10_P7	
	MOV AX,place6.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place6.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE10_OUT
ADD_LINE10_P7:					;to the place 7
	MOV AX,place7.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place7.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE10_OUT
ADD_LINE10_OUT:
	MOV CAR_ARRAY[DI].live,1
	MOV DH,10
	MOV AX,DI
	DIV DH
	MOV LINE1_0[0],AX
	DEC add_line1_0


ADD_LINE20:
	CMP LINE2_0[86],0
	JE ADD_LINE20_CAR
	JMP ADD_LINE30
ADD_LINE20_CAR:
	CMP add_line2_0,0
	JA ADD_LINE20_CAR0
	JMP ADD_LINE30
ADD_LINE20_CAR0:
	MOV DI,10
	MOV CX,337
ADD_LINE20_CAR1:
	CMP CAR_ARRAY[DI].live,0
	JE ADD_LINE20_CAR2
	ADD DI,10
	LOOP ADD_LINE20_CAR1
	JMP ADD_OUT
ADD_LINE20_CAR2:
	MOV AX,place8.X_start
	MOV CAR_ARRAY[DI].start_X,AX
	MOV AX,place8.Y_start
	MOV CAR_ARRAY[DI].start_Y,AX
	
	CALL GET_RAND
	CMP AX,0
	JA ADD_LINE20_P3			
ADD_LINE20_P2:					;to the place 2
	MOV AX,place2.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place2.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE20_OUT
ADD_LINE20_P3:					;to the place 3
	CMP AX,1
	JA ADD_LINE20_P5	
	MOV AX,place3.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place3.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE20_OUT
ADD_LINE20_P5:					;to the place 5
	CMP AX,2
	JA ADD_LINE20_P6	
	MOV AX,place5.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place5.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE20_OUT
ADD_LINE20_P6:					;to the place 6
	CMP AX,3
	JA ADD_LINE20_P7	
	MOV AX,place6.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place6.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE20_OUT
ADD_LINE20_P7:					;to the place 7
	MOV AX,place7.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place7.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE20_OUT
ADD_LINE20_OUT:
	MOV CAR_ARRAY[DI].live,1
	MOV DH,10
	MOV AX,DI
	DIV DH
	MOV LINE2_0[86],AX
	DEC add_line2_0


ADD_LINE30:
	CMP LINE3_0[0],0
	JE ADD_LINE30_CAR
	JMP ADD_LINE01
ADD_LINE30_CAR:
	CMP add_line3_0,0
	JA ADD_LINE30_CAR0
	JMP ADD_LINE01
ADD_LINE30_CAR0:
	MOV DI,10
	MOV CX,337
ADD_LINE30_CAR1:
	CMP CAR_ARRAY[DI].live,0
	JE ADD_LINE30_CAR2
	ADD DI,10
	LOOP ADD_LINE30_CAR1
	JMP ADD_OUT
ADD_LINE30_CAR2:
	MOV AX,place5.X_start
	MOV CAR_ARRAY[DI].start_X,AX
	MOV AX,place5.Y_start
	MOV CAR_ARRAY[DI].start_Y,AX
	
	CALL GET_RAND
	CMP AX,0
	JA ADD_LINE30_P3			
ADD_LINE30_P2:					;to the place 2
	MOV AX,place2.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place2.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE30_OUT
ADD_LINE30_P3:					;to the place 3
	CMP AX,1
	JA ADD_LINE30_P6	
	MOV AX,place3.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place3.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE30_OUT
ADD_LINE30_P6:					;to the place 6
	CMP AX,2
	JA ADD_LINE30_P7	
	MOV AX,place6.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place6.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE30_OUT
ADD_LINE30_P7:					;to the place 7
	CMP AX,3
	JA ADD_LINE30_P8	
	MOV AX,place7.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place7.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE30_OUT
ADD_LINE30_P8:					;to the place 8
	MOV AX,place8.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place8.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE30_OUT
ADD_LINE30_OUT:
	MOV CAR_ARRAY[DI].live,1
	MOV DH,10
	MOV AX,DI
	DIV DH
	MOV LINE3_0[0],AX
	DEC add_line3_0

ADD_LINE01:
	CMP LINE0_1[0],0
	JE ADD_LINE01_CAR
	JMP ADD_LINE11
ADD_LINE01_CAR:
	CMP add_line0_1,0
	JA ADD_LINE01_CAR0
	JMP ADD_LINE11
ADD_LINE01_CAR0:
	MOV DI,10
	MOV CX,377
ADD_LINE01_CAR1:
	CMP CAR_ARRAY[DI].live,0
	JE ADD_LINE01_CAR2
	ADD DI,10
	LOOP ADD_LINE01_CAR1
	JMP ADD_OUT
ADD_LINE01_CAR2:

	MOV AX,place2.X_start
	MOV CAR_ARRAY[DI].start_X,AX
	MOV AX,place2.Y_start
	MOV CAR_ARRAY[DI].start_Y,AX
	
	CALL GET_RAND
	CMP AX,0
	JA ADD_LINE01_P4			
ADD_LINE01_P1:					;to the place 1
	MOV AX,place1.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place1.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE01_OUT
ADD_LINE01_P4:					;to the place 4
	CMP AX,1
	JA ADD_LINE01_P5	
	MOV AX,place4.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place4.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE01_OUT
ADD_LINE01_P5:					;to the place 5
	CMP AX,2
	JA ADD_LINE01_P6	
	MOV AX,place5.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place5.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE01_OUT
ADD_LINE01_P6:					;to the place 6
	CMP AX,3
	JA ADD_LINE01_P8	
	MOV AX,place6.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place6.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE01_OUT
ADD_LINE01_P8:					;to the place 8
	MOV AX,place8.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place8.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE01_OUT
ADD_LINE01_OUT:
	MOV CAR_ARRAY[DI].live,1
	MOV DH,10
	MOV AX,DI
	DIV DH
	MOV LINE0_1[0],AX
	DEC add_line0_1


ADD_LINE11:
	CMP LINE1_1[86],0
	JE ADD_LINE11_CAR
	JMP ADD_LINE21
ADD_LINE11_CAR:
	CMP add_line1_1,0
	JA ADD_LINE11_CAR0
	JMP ADD_LINE21
ADD_LINE11_CAR0:
	MOV DI,10
	MOV CX,377
ADD_LINE11_CAR1:
	CMP CAR_ARRAY[DI].live,0
	JE ADD_LINE11_CAR2
	ADD DI,10
	LOOP ADD_LINE11_CAR1
	JMP ADD_OUT
ADD_LINE11_CAR2:

	MOV AX,place6.X_start
	MOV CAR_ARRAY[DI].start_X,AX
	MOV AX,place6.Y_start
	MOV CAR_ARRAY[DI].start_Y,AX
	
	CALL GET_RAND
	CMP AX,0
	JA ADD_LINE11_P2			
ADD_LINE11_P1:					;to the place 1
	MOV AX,place1.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place1.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE11_OUT
ADD_LINE11_P2:					;to the place 2
	CMP AX,1
	JA ADD_LINE11_P4	
	MOV AX,place2.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place2.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE11_OUT
ADD_LINE11_P4:					;to the place 4
	CMP AX,2
	JA ADD_LINE11_P5	
	MOV AX,place4.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place4.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE11_OUT
ADD_LINE11_P5:					;to the place 5
	CMP AX,3
	JA ADD_LINE11_P8	
	MOV AX,place5.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place5.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE11_OUT
ADD_LINE11_P8:					;to the place 8
	MOV AX,place8.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place8.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE11_OUT
ADD_LINE11_OUT:
	MOV CAR_ARRAY[DI].live,1
	MOV DH,10
	MOV AX,DI
	DIV DH
	MOV LINE1_1[86],AX
	DEC add_line1_1


ADD_LINE21:
	CMP LINE2_1[0],0
	JE ADD_LINE21_CAR
	JMP ADD_LINE31
ADD_LINE21_CAR:
	CMP add_line2_1,0
	JA ADD_LINE21_CAR0
	JMP ADD_LINE31
ADD_LINE21_CAR0:
	MOV DI,10
	MOV CX,377
ADD_LINE21_CAR1:
	CMP CAR_ARRAY[DI].live,0
	JE ADD_LINE21_CAR2
	ADD DI,10
	LOOP ADD_LINE21_CAR1
	JMP ADD_OUT
ADD_LINE21_CAR2:

	MOV AX,place3.X_start
	MOV CAR_ARRAY[DI].start_X,AX
	MOV AX,place3.Y_start
	MOV CAR_ARRAY[DI].start_Y,AX
	
	CALL GET_RAND
	CMP AX,0
	JA ADD_LINE21_P4			
ADD_LINE21_P1:					;to the place 1
	MOV AX,place1.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place1.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE21_OUT
ADD_LINE21_P4:					;to the place 4
	CMP AX,1
	JA ADD_LINE21_P5	
	MOV AX,place4.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place4.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE21_OUT
ADD_LINE21_P5:					;to the place 5
	CMP AX,2
	JA ADD_LINE21_P7	
	MOV AX,place5.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place5.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE21_OUT
ADD_LINE21_P7:					;to the place 7
	CMP AX,3
	JA ADD_LINE21_P8	
	MOV AX,place7.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place7.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE21_OUT
ADD_LINE21_P8:					;to the place 8
	MOV AX,place8.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place8.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE21_OUT
ADD_LINE21_OUT:
	MOV CAR_ARRAY[DI].live,1
	MOV DH,10
	MOV AX,DI
	DIV DH
	MOV LINE2_1[0],AX
	DEC add_line2_1

ADD_LINE31:
	CMP LINE3_1[86],0
	JE ADD_LINE31_CAR
	JMP ADD_OUT
ADD_LINE31_CAR:
	CMP add_line3_1,0
	JA ADD_LINE31_CAR0
	JMP ADD_OUT
ADD_LINE31_CAR0:
	MOV DI,10
	MOV CX,377
ADD_LINE31_CAR1:
	CMP CAR_ARRAY[DI].live,0
	JE ADD_LINE31_CAR2
	ADD DI,10
	LOOP ADD_LINE31_CAR1
	JMP ADD_OUT
ADD_LINE31_CAR2:
	MOV AX,place7.X_start
	MOV CAR_ARRAY[DI].start_X,AX
	MOV AX,place7.Y_start
	MOV CAR_ARRAY[DI].start_Y,AX
	
	CALL GET_RAND
	CMP AX,0
	JA ADD_LINE31_P3			
ADD_LINE31_P1:					;to the place 1
	MOV AX,place1.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place1.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE31_OUT
ADD_LINE31_P3:					;to the place 3
	CMP AX,1
	JA ADD_LINE31_P4	
	MOV AX,place3.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place3.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE31_OUT
ADD_LINE31_P4:					;to the place 4
	CMP AX,2
	JA ADD_LINE31_P5	
	MOV AX,place4.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place4.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE31_OUT
ADD_LINE31_P5:					;to the place 5
	CMP AX,3
	JA ADD_LINE31_P8	
	MOV AX,place5.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place5.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE31_OUT
ADD_LINE31_P8:					;to the place 8
	MOV AX,place8.X_end
	MOV CAR_ARRAY[DI].end_X,AX
	MOV AX,place8.Y_end
	MOV CAR_ARRAY[DI].end_Y,AX
	JMP ADD_LINE31_OUT
ADD_LINE31_OUT:
	MOV CAR_ARRAY[DI].live,1
	MOV DH,10
	MOV AX,DI
	DIV DH
	MOV LINE3_1[86],AX
	DEC add_line3_1


ADD_OUT:	
	POP DI
	POP DX
	POP CX
	POP AX
RET
one_add endp

CODES      ENDS
CODES1 SEGMENT
	ASSUME CS:CODES1,DS:DATAS
start_run:
	PUSH AX
	PUSH DS
	MOV AX,DATAS
	MOV DS,AX
	Cmp FLAG_L,0
 	JA to_OR1
 	JMP OR0
to_OR1:
 	JMP far ptr OR1
OR0: 

 	CAR_RUN  line0_1,light_r,from_y_end
 	CAR_RUN  line1_1,light_r,from_y_start
 	CAR_RUN  line2_1,light_r,from_y_end
 	CAR_RUN  line3_1,light_r,from_y_start
 	CMP FLAG_NUM,10
 	JB TO_OR0_1
 	JMP OR0_0
TO_OR0_1:
  	JMP FAR PTR OR0_1
OR0_0:
	CAR_RUN  line0_0,light_g,from_x_start
 	CAR_RUN  line1_0,light_g,from_x_end
 	CAR_RUN  line2_0,light_g,from_x_start
 	CAR_RUN  line3_0,light_g,from_x_end
 	CAR_TURNX line0_0,from_x_start,line1_1,num_cro00_r0,line3_1,num_cro01_r0,cro00_l0_array, cro01_l0_array
 	CAR_TURNX line1_0,from_x_end,line0_1,num_cro00_r1,line2_1,num_cro01_r1,cro00_l1_array, cro01_l1_array
 	CAR_TURNX line2_0,from_x_start,line1_1,num_cro10_r0,line3_1,num_cro11_r0,cro10_l0_array, cro11_l0_array
 	CAR_TURNX line3_0,from_x_end,line0_1,num_cro10_r1,line2_1,num_cro11_r1,cro10_l1_array, cro11_l1_array
JMP FAR PTR ONE_RUN_OUT
OR0_1:
	CAR_RUN  line0_0,light_r,from_x_start
 	CAR_RUN  line1_0,light_r,from_x_end
 	CAR_RUN  line2_0,light_r,from_x_start
 	CAR_RUN  line3_0,light_r,from_x_end
	CAR_TURNL from_x_start,cro00_l0_array,line0_1
	CAR_TURNL from_x_end,cro00_l1_array,line1_1
	CAR_TURNL from_x_start,cro10_l0_array,line0_1
	CAR_TURNL from_x_end,cro10_l1_array,line1_1
	CAR_TURNL from_x_start,cro01_l0_array,line2_1
	CAR_TURNL from_x_end,cro01_l1_array,line3_1
	CAR_TURNL from_x_start,cro11_l0_array,line2_1
	CAR_TURNL from_x_end,cro11_l1_array,line3_1

 	JMP FAR PTR ONE_RUN_OUT
OR1:
 	CMP FLAG_L,1
 	JA to_OR2
 	JMP OR1_START
to_OR2:
 	JMP FAR PTR OR2
OR1_START:
	CAR_RUN  line0_0,light_y,from_x_start
 	CAR_RUN  line1_0,light_y,from_x_end
 	CAR_RUN  line2_0,light_y,from_x_start
 	CAR_RUN  line3_0,light_y,from_x_end
 	CAR_RUN  line0_1,light_r,from_y_end
 	CAR_RUN  line1_1,light_r,from_y_start
 	CAR_RUN  line2_1,light_r,from_y_end
 	CAR_RUN  line3_1,light_r,from_y_start


 	JMP FAR PTR ONE_RUN_OUT
OR2:
 	CMP FLAG_L,2
 	JA to_OR3
 	JMP OR2_START
to_OR3:
 	JMP FAR PTR OR3
OR2_START:
 	CAR_RUN  line0_0,light_r,from_x_start
 	CAR_RUN  line1_0,light_r,from_x_end
 	CAR_RUN  line2_0,light_r,from_x_start
 	CAR_RUN  line3_0,light_r,from_x_end
 	CMP FLAG_NUM,10
 	JB TO_OR2_1
 	JMP OR2_0
TO_OR2_1:
  	JMP FAR PTR OR2_1
OR2_0:
	CAR_RUN  line0_1,light_g,from_y_end
 	CAR_RUN  line1_1,light_g,from_y_start
 	CAR_RUN  line2_1,light_g,from_y_end
 	CAR_RUN  line3_1,light_g,from_y_start
	CAR_TURNY line0_1,from_y_end,line0_0,num_cro00_r3,line2_0,num_cro10_r3,cro00_l3_array, cro10_l3_array
	CAR_TURNY line1_1,from_y_start,line1_0,num_cro00_r2,line3_0,num_cro10_r2,cro00_l2_array, cro10_l2_array
	CAR_TURNY line2_1,from_y_end,line0_0,num_cro01_r3,line2_0,num_cro11_r3,cro01_l3_array, cro11_l3_array
	CAR_TURNY line3_1,from_y_start,line1_0,num_cro01_r2,line3_0,num_cro11_r2,cro01_l2_array, cro11_l2_array

JMP FAR PTR ONE_RUN_OUT
OR2_1:
	CAR_RUN  line0_1,light_r,from_y_end
 	CAR_RUN  line1_1,light_r,from_y_start
 	CAR_RUN  line2_1,light_r,from_y_end
 	CAR_RUN  line3_1,light_r,from_y_start
  	CAR_TURNL from_y_start,cro00_l2_array,line0_0
  	CAR_TURNL from_y_end,cro00_l3_array,line1_0
  	CAR_TURNL from_y_start,cro10_l2_array,line2_0
  	CAR_TURNL from_y_end,cro10_l3_array,line3_0
  	CAR_TURNL from_y_start,cro01_l2_array,line0_0
  	CAR_TURNL from_y_end,cro01_l3_array,line1_0
  	CAR_TURNL from_y_start,cro11_l2_array,line2_0
  	CAR_TURNL from_y_end,cro11_l3_array,line3_0
 	JMP FAR PTR ONE_RUN_OUT
OR3:
 	CAR_RUN  line0_0,light_r,from_x_start
 	CAR_RUN  line1_0,light_r,from_x_end
 	CAR_RUN  line2_0,light_r,from_x_start
 	CAR_RUN  line3_0,light_r,from_x_end
 	CAR_RUN  line0_1,light_y,from_y_end
 	CAR_RUN  line1_1,light_y,from_y_start
 	CAR_RUN  line2_1,light_y,from_y_end
 	CAR_RUN  line3_1,light_y,from_y_start
	JMP FAR PTR ONE_RUN_OUT
ONE_RUN_OUT:
	POP DS
	POP AX
	JMP FAR PTR ONE_RUN_OUT1
CODES1      ENDS	
END        START
