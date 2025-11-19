.MODEL SMALL
.STACK 100h
.DATA
MATRIZ DB 'x','o','x'
       DB 'x','o','x'
       DB 'X',38h,'o'
.CODE 
 MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX

    CALL VER_VIT

    MOV AH,4Ch
    INT 21h
 MAIN ENDP

 VER_VIT PROC
;Verificação horizontal
    XOR BX,BX
    MOV CL,3

DENOVO1:
    XOR DX,DX
    XOR SI,SI
    MOV CH,3

AGAIN1:
    CMP MATRIZ[BX][SI],78h
    JNE CONT1
    INC DH
CONT1:
    CMP MATRIZ[BX][SI],6Fh
    JNE SAI1
    INC DL
SAI1:
    INC SI
    DEC CH
    JNZ AGAIN1

    CMP DH,3
    JE VIT_JOG
    CMP DL,3
    JE VIT_JOG2_COMP

    DEC CL
    JNZ DENOVO1

;Verificação vertical
    XOR SI,SI
    MOV CL,3

DENOVO2:
    XOR DX,DX
    XOR BX,BX
    MOV CH,3

AGAIN2:
    CMP MATRIZ[BX][SI],78h
    JNE CONT2
    INC DH
CONT2:
    CMP MATRIZ[BX][SI],6Fh
    JNE SAI2
    INC DL
SAI2:
    INC SI
    DEC CH
    JNZ AGAIN2

    CMP DH,3
    JE VIT_JOG
    CMP DL,3
    JE VIT_JOG2_COMP

    DEC CL
    JNZ DENOVO2