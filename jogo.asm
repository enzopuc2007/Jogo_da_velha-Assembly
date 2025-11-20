TITLE JOGO
.MODEL SMALL
.STACK 100h
.DATA
  MSG_BEMVINDO DB 'JOGO DA VELHA', 13, 10, 13, 10, '$'
  MSG1 DB 'Selecione o modo de jogo (0 - Multiplayer | 1 - Computador)', 13, 10, 13, 10,'Digite a sua opcao: $'
  MSG2 DB 10,10,'Tente novamente, digito nao reconhecido...',13, 13, 10, '$'
  MATRIZ DB 31H, 32H, 33H
         DB 34H, 35H, 36H
         DB 37H, 38H, 39H

  MSG_ZERO DB 13, 10, 'A opcao selecionada foi a opcao MULTIPLAYER.', 13, 10, '$'
  MSG_UM DB 13, 10, 'A opcao selecionada foi a opcao JOGO COM COMPUTADOR.', 13, 10, '$'

  MSG_INSIRA_LINHA DB 'Escolha a linha da jogada(Opcoes: 1, 2 ou 3): $'
  MSG_INSIRA_COLUNA DB 'Escolha a coluna da jogada(Opcoes: 1, 2 ou 3): $'

  MSG_INVALIDO DB 10,'Posicao invalida.',10,13,'Tente novamente...',10,13,10,'$'

  MSG_EMPATE DB 'Empate! $'

  MSG_VEZ_J1 DB 'Vez do jogador 1 $'
  MSG_VEZ_J2 DB 'Vez do jogador 2 $'

  MSG_GANHOU_J1 DB 'Jogador 1 ganhou $'
  MSG_GANHOU_J2 DB 'Jogador 2 ganhou $'
  MSG_VIT_JOG DB 'O jogador 1 é o vencedor$'
  MSG_VIT_JOG2_COMP DB 'O jogador 2 é o vencedor$'
.CODE 
INCLUDE macros.inc

 JOGO_MULTIPLAYER PROC
  IMPRIME_MATRIZ
  RET
 JOGO_MULTIPLAYER ENDP
 IMPRIME_MATRIZ PROC
    PUSH CX

    XOR BX,BX
    MOV AH,2
    MOV CH,3

  REPETE2:
    MOV CL,3
    XOR SI,SI
    MOV DL,20h
    INT 21h
  REPETE1:
    MOV AL,MATRIZ[BX][SI]

    CMP AL,6Fh
    JE IMPRIME0

    CMP AL,78h
    JE IMPRIMEX

    JMP NUMERO

  IMPRIME0:
    MOV DL,6Fh
    INT 21h
    JMP COND

  IMPRIMEX:
    MOV DL,78h
    INT 21h
    JMP COND

  NUMERO:
    MOV DL,AL
    INT 21H
    JMP COND

  COND:
    CMP CL,1
    JE FINAL1
    MOV DL,7Ch
    INT 21h  

  FINAL1:
    INC SI
    DEC CL
    JNZ REPETE1
    ADD BX,3

    CMP CH,1
    JE FINAL2

    MOV DL,10
    INT 21h

    MOV DL,20h
    INT 21h

    MOV DH,3
  DENOVO:
    MOV DL,2Dh
    INT 21h

    CMP DH,1
    JE FINAL2

    MOV DL,7Ch
    INT 21h
    DEC DH
    JNZ DENOVO

  FINAL2:
    MOV DL,10
    INT 21h
    DEC CH
    JNZ REPETE2

    POP CX
    POPALL
  RET
IMPRIME_MATRIZ ENDP

  IMPRIME_UM PROC
    MOV AH, 09H
    MOV DX, OFFSET MSG_UM
    INT 21H

    RET
  IMPRIME_UM ENDP

    INICIALIZACAO PROC
    ; PUSHALL

    ; IMPRIME MENSAGEM DE BEM-VINDO
    MOV AH, 09H
    MOV DX, OFFSET MSG_BEMVINDO
    INT 21H

    ENTRADA_OPCAO:
      ; IMPRIME MENSAGEM DE MODO DE JOGO
      MOV DX, OFFSET MSG1
      INT 21H

      MOV AH, 01H
      INT 21H

      AND AL, 0FH

      CMP AL, 0
      JZ VOLTAR
      CMP AL, 1
      JE VOLTAR

      MOV AH, 09H
      MOV DX, OFFSET MSG2
      INT 21H
      JMP ENTRADA_OPCAO

    VOLTAR:
      ; POPALL
      RET 
  INICIALIZACAO ENDP

VER_VIT PROC
;Verificação horizontal
    XOR BX,BX
    MOV CL,3

DENOVO1:
    XOR DX,DX
    XOR SI,SI
    MOV CH,3

AGAIN1:
    CMP AL,MATRIZ[BX][SI]
    CMP AL,78h
    JNE CONT1
    INC DH
CONT1:
    CMP AL,MATRIZ[BX][SI]
    CMP AL,6Fh
    JNE SAI1
    INC DL
SAI1:
    INC SI
    DEC CH
    JNZ AGAIN1
    CMP DH,3
    JE CORRECTION1
    CMP DL,3
    JE CORRECTION2
    ADD BX,3
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
    ADD BX,3
    DEC CH
    JNZ AGAIN2
    CMP DH,3
    JE VIT_JOG
    CMP DL,3
    JE VIT_JOG2_COMP
    INC SI
    DEC CL
    JNZ DENOVO2
    XOR BX,BX
    XOR SI,SI
    XOR DX,DX
    MOV CX,3
AGAIN3:
    CMP MATRIZ[BX][SI],78h
CORRECTION1:
    JNE CONT3
    INC DH
CONT3:
    CMP MATRIZ[BX][SI],6Fh
CORRECTION2:
    JNE SAI3
    INC DL
SAI3:
    ADD BX,3
    INC SI
    LOOP AGAIN3
    CMP DH,3
    JE VIT_JOG
    CMP DL,3
    JE VIT_JOG2_COMP
    XOR BX,BX
    MOV SI,2
    MOV CX,3
AGAIN4:
    CMP MATRIZ[BX][SI],78h
    JNE CONT4
    INC DH
CONT4:
    CMP MATRIZ[BX][SI],6Fh
    JNE SAI4
    INC DL
SAI4:
    ADD BX,3
    DEC SI
    LOOP AGAIN4
    CMP DH,3
    JE VIT_JOG
    CMP DL,3
    JE VIT_JOG2_COMP
VIT_JOG:
    MOV AH,9
    LEA DX,MSG_VIT_JOG
    INT 21h
    JMP RETORNA
VIT_JOG2_COMP:
    MOV AH,9
    LEA DX,MSG_VIT_JOG2_COMP
    INT 21h
RETORNA:
    RET
 VER_VIT ENDP

 MAIN PROC 
    MOV AX,@DATA      ;Inicialização dos dados
    MOV DS,AX

    CLS

    CALL INICIALIZACAO    ;Iniciação do jogo

    CLS

    CMP AL, 0         ;Condição para entrar no modo multiplayer
    JZ ESCOPO_ZERO    ;Condição 

    ESCOPO_UM:
      CALL IMPRIME_UM
      JMP FIM_PROGRAMA

    ESCOPO_ZERO:   
      CALL JOGO_MULTIPLAYER
      JMP FIM_PROGRAMA

    FIM_PROGRAMA:
      MOV AH, 4CH     ;Devolve o controle 
      INT 21H
 MAIN ENDP
END MAIN