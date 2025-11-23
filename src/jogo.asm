TITLE JOGO_DA_VELHA_OSC
; Este trabalho foi realizado durante as aulas prática de Organização de Sistemas de Computação
; pelos alunos de Engenharia de Computação da Pontifícia Universidade Católica de Campinas 
; Enzo Marchi Romera e Gabriel de Oliveira Baptista
.MODEL SMALL ; o modelo de código deste programa Assembly x8086 é SMALL
.STACK 100h ; definição do tamanho da pilha
.DATA ; início do segmento de dados;
  MSG_BEMVINDO DB 'JOGO DA VELHA $' ; mensagem de boas-vindas direcionada ao usuário
  MSG1 DB 'Selecione o modo de jogo (0 - Multiplayer | 1 - Computador)', 13, 10, 13, 10,'Digite a sua opcao: $' ; mensagem de seleção de modo de jogo
  MSG2 DB 10,10,'Tente novamente, digito nao reconhecido...',13, 13, 10, '$' ; caso o dígito para a entrada do ti de jogo não for conhecida, esta mensagem será exibida
  MATRIZ DB 31H, 32H, 33H ; declaração inicial da matriz com a numeração das posições dos dígitos.
         DB 34H, 35H, 36H
         DB 37H, 38H, 39H

  MSG_ZERO DB 13, 10, 'A opcao selecionada foi a opcao MULTIPLAYER.', 13, 10, '$' ; Esta mensagem será exibida caso o jogador selecione a opção de multijogador
  MSG_UM DB 13, 10, 'A opcao selecionada foi a opcao JOGO COM COMPUTADOR.', 13, 10, '$' ; Esta mensagem será exibida caso o jogador selecione a opção de jogo contra a máquina 

  MSG_CAPTA_JOG DB 'Escolha o numero da jogada(Opcoes: 1 a 9): $' ; Esta mensagem será exibida para o jogador selecionar a posição de jogada.

  MSG_INVALIDO DB 10,'Posicao invalida.',10,13,'Tente novamente...',10,13,10,'$' ; Esta mensgame será exibida caso o jogador insira uma posição fora do intervalo de possibildades de entrada (1-9) ou em uma posição já ocupada

  MSG_EMPATE DB 'Empate! $' ; Esta mensagem será exibida em caso de jogo terminar em empate ou em "velha"

  MSG_VEZ_J1 DB 'Vez do jogador 1 $' ; Mensagem exibida quando for a vez do jogador 1 jogar
  MSG_VEZ_J2 DB 'Vez do jogador 2 $' ; Mensagem exibida quando for a vez do jogador 2 jogar
  MSG_VEZ_ROBO DB 'Vez do robo $' ; Mensagem exibida quando for a vez do robô jogar

  MSG_VIT_JOG DB 'O jogador 1 eh o vencedor $' ; Mensagem exibida quando o jogador 1 for o vencedor
  MSG_VIT_JOG2 DB 'O jogador 2 eh o vencedor $' ; Mensagem exibida quando o jogador 2 for o vencedor
  MSG_VIT_COMP DB 'O robo eh o vencedor $' ; Mensagem exibida quando o robô no modo de jogo 1 for vencedor

  MSG_FINAL DB 'Deseja jogar novamente?(1-Sim / 2-Nao): $' ; Mensagem exibida ao fim de cada rodada para saber se o jogador gostaria de jogar outra partida no mesmo modo.

  MSG_QUALQUER_TECLA DB 'Pressione qualquer tecla para continuar...$' ; mensagem exibida após a tratativa de um erro para que o fluxo do programa continue 
.CODE ; início do segmento de código
  ; Durante o desenvolvimento deste jogo, trabalhamos com a modularização, ou seja, separamos vários procedimentos e macros em diferentes arquivos a fim de deixar o programa principal (este arquivo aqui) mais enxuto e fácil de compreender no caso de outros leitores terem acesso a ele e quiserem editá-lo ou fazer manutenção no código.
  INCLUDE macros.inc ; importa o arquivo de definição e de declaração com as MACROS
  INCLUDE procs.inc ; importa o arquivo de definição e de declaração com os procedimentos
 MAIN PROC ; declaração do programa principal
  MOV AX,@DATA      ;Inicialização dos dados
  MOV DS,AX
  XOR DI,DI ; limpa o registrador DI

  CLS ; Executa a macro de limpeza de tela.

  CALL INICIALIZACAO    ;Iniciação do jogo

  CLS ; Executa a macro de limpeza de tela.

  CMP AL, 0         ;Condição para entrar no modo multiplayer
  JZ ESCOPO_ZERO
  ; Se AL (entrada do usuário) for zero, entre no escopo de acesso ao jogo multiplayer
  ; Se AL (entrada do usuário) for um, entre no escopo de acesso ao jogo contra o computador
  ; Se AL (entrada do usuário) for um dígito não reconhecido, imprima uma mensagem de erro e repita a leitura inicial

ESCOPO_UM:
JOG_NOV1:
  OR DI,1
  CALL JOGO_ROBO
  PERGUNTA_FINAL1
  JMP FIM_PROGRAMA

ESCOPO_ZERO:
JOG_NOV2:  
  CALL JOGO_MULTIPLAYER ; executa o procedimento de jogo multiplayer
  PERGUNTA_FINAL2 ; executa a macro de pergunta d
  JMP FIM_PROGRAMA ; 

FIM_PROGRAMA:
  MOV AH, 4CH     ;Devolve o controle 
  INT 21H         ; Fim do programa
 MAIN ENDP
END MAIN