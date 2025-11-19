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
.CODE 
INCLUDE macros.inc
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