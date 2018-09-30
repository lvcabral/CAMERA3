*ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
*บ SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS          บ 
*บ VERSAO    : 1.1 - Copyright 1992                                       บ 
*บ PROGRAMA  : CAM3_000.PRG                                               บ 
*บ DESCRI€O : Menu Pricipal do Sistema                                   บ 
*บ AUTOR     : Marcelo Leal Limaverde Cabral                              บ 
*บ DATA      : 05/09/92                                                   บ
*ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
 
PARAMETER CFG,MSG,_TINIC

#include "cam3.ch"

SET BELL        OFF 
SET CENTURY     OFF 
SET CURSOR      OFF 
SET SCOREBOARD  OFF 
SET ACCENT      ON
SET INSCURSOR   ON
SET EXCLUSIVE   ON
SET CONFIRM     ON 
SET WRAP        ON 
SET UNIQUE      ON
SET DELETED     ON
SET DATE        BRITISH
SET MESSAGE     TO 23 CENTER
SET DECIMALS    TO 09
SET PROCEDURE   TO CAM3_001
SET KEY  -1     TO CALPOP
SET KEY  -2     TO POPCAL
SET KEY 305     TO DIANO
SET KEY 306     TO MEMORIA
*******************
EXTERN HELP
PUBLIC ARQHLP,NIVHLP,CORHLP
arqhlp="cam3.hlp"
nivhlp=0
corhlp=__cor(4)
********************
PUBLIC CALCL,CALCC
store 2 to calcl,calcc
********************
SETCOLOR(__COR(11))
CLEAR
SETCOLOR(__COR(14))
@ 0,0
@ 0,1 SAY "MC3 Inform tica"
@ 0,24 SAY "-Ajuda"
@ 0,34 SAY "-Calculadora"
@ 0,50 SAY "-Calend rio"
IF CFC="C"
   @ 2,1 SAY 'ÛÛÛÛ'+MSG+'ÛÛÛÛ   SISTEMA CAMERA 3   ÛÛÛÛ Verso 1.1 1992 ÛÛÛÛ'
ELSE
   @ 2,1 SAY 'ฒฒฒฒ'+MSG+'ฒฒฒฒ   SISTEMA CAMERA 3   ฒฒฒฒ Verso 1.1 1992 ฒฒฒฒ'
ENDIF
SETCOLOR(__COR(3))
@ 0,22 SAY "F1"
@ 0,32 SAY "F2"
@ 0,48 SAY "F3"
SETCOLOR(__COR(12))
@ 1,0 TO 3,79   && MOLDURA DO TITULO
@ 5,0 TO 20,79  && MOLDURA DO CENTRO
@ 22,0 TO 24,79 && MOLDURA DA MENSAGEM
IF DATE()<CTOD("01/09/92")
   KEYBOARD "UD"
ENDIF
IF ADIR("*.NTX")<10
   KEYBOARD "U"+CHR(13)+CHR(27)
ENDIF
DO WHILE .T.
    VC=2
    NIVHLP=0    
    SET KEY 4 TO MEN2
    SET KEY 19 TO NULO
    SETCOLOR(__COR(11))
    @ 6,1 CLEA TO 19,78 && LIMPA A MOLDURA DO CENTRO
    @ 4,27 SAY ' SOCIOS '
    @ 4,66 SAY ' RELATORIOS '
    @ 4,46 SAY ' FITAS '
    SETCOLOR(__COR(29))
    @ 4,3 SAY ' MOVIMENTOS '
    @ 21,0 SAY '  [ESC] SAI DO SISTEMA  บ  '+CHR(24)+CHR(25)+;
    '  MOVEM A BARRA DE SELE€O  บ  '+CHR(27)+' '+CHR(26)+'  MUDAM A OP€O  '
    SETCOLOR(__COR(18))
    @ 0,67 SAY LEFT(DIA(DATE()),3)+' '+DTOC(DATE())
    @ 23,1 CLEA TO 23,78 && LIMPA A LINHA DE MENSAGEM
    @ 23,2 SAY 'MENSAGEM:'
    @ 06,3 TO 16,26 DOUBLE && MOLDURA DO MENU-MOVIMENTOS
    @ 07,4  PROMPT'    Saกda de Fitas    ' MESSAGE'Registra a Saกda de Fitas e Emite Comprovante'
    @ 08,3  SAY 'ว                      ถ'
    @ 08,4 TO 8,25
    @ 09,4  PROMPT'  Devoluo de Fitas  ' MESSAGE'Registra Devoluo de Fitas'
    @ 10,3  SAY 'ว                      ถ'
    @ 10,4 TO 10,25
    @ 11,4  PROMPT'  Fichas de Crdito   ' MESSAGE'Registra os crditos adquiridos pelos sขcios'
    @ 12,3  SAY 'ว                      ถ'
    @ 12,4 TO 12,25
    @ 13,4  PROMPT'     Utilit rios      ' MESSAGE'Reorganizao de Arquivos, Backup, Data/Hora do Sistema'
    @ 14,3  SAY 'ว                      ถ'
    @ 14,4 TO 14,25
    @ 15,4  PROMPT'     Configurao     ' MESSAGE'Dados da Locadora, Parmetros, Tabelas, Senhas'
    MENU TO A
    IF VC=1
        LOOP 
    ENDI 
    IF A=0
     SET KEY 4 TO
     SET KEY 19 TO
     DO SAIR
    ELSEIF A=1
          SET KEY 4 TO 
          SET KEY 19 TO 
          DO CAM3_110
    ELSEIF A=2
          SET KEY 4 TO 
          SET KEY 19 TO 
          DO CAM3_120
    ELSEIF A=3
          SET KEY 4 TO 
          SET KEY 19 TO 
          DO CAM3_130
    ELSEIF A=4
          SET KEY 4 TO 
          SET KEY 19 TO 
          DO CAM3_140
    ELSEIF A=5
          SET KEY 4 TO 
          SET KEY 19 TO 
          DO CAM3_150
    ENDIF
ENDDO 

**************
PROC MEN2
**************

B=1
DO WHIL .T.
    VV=2
    VC=2
    NIVHLP=0    
    SET KEY 4 TO MEN3
    SET KEY 19 TO VOLTAR
    SETCOLOR(__COR(11))
    @ 4,46 SAY ' FITAS '
    @ 4,03 SAY ' MOVIMENTOS '
    @ 4,66 SAY ' RELATORIOS '
    @ 6,1 CLEA TO 19,78 && LIMPA A MOLDURA DO CENTRO
    SETCOLOR(__COR(29))
    @ 4,27 SAY ' SOCIOS '
    @ 21,0 SAY '  [ESC] SAI DO SISTEMA  บ  '+CHR(24)+CHR(25)+;
    '  MOVEM A BARRA DE SELE€O  บ  '+CHR(27)+' '+CHR(26)+'  MUDAM A OP€O  '
    SETCOLOR(__COR(18))
    @ 0,67 SAY LEFT(DIA(DATE()),3)+' '+DTOC(DATE())
    @ 23,11 CLEA TO 23,78 && LIMPA A LINHA DE MENSAGEM
    @ 06,22 TO 14,38 DOUBLE && MOLDURA DO MENU-SOCIOS
    @ 07,23 PROMPT' Cadastramento ' MESSAGE'Inclui Sขcio(s) no Cadastro'
    @ 08,22 SAY 'ว               ถ'
    @ 08,23 TO 8,37
    @ 09,23 PROMPT' Modifica”es  ' MESSAGE'Modifica Dados dos Sขcios'
    @ 10,22 SAY 'ว               ถ'
    @ 10,23 TO 10,37
    @ 11,23 PROMPT' Informa”es   ' MESSAGE'Consulta Dados do Cadastro de Sขcios'
    @ 12,22 SAY 'ว               ถ'
    @ 12,23 TO 12,37
    IF CFG
       @ 13,23 PROMPT' Exclus”es     ' MESSAGE'Apaga Sขcios do Cadastro'
    ELSE
       SETCOLOR(__COR(27))
       @ 13,23 SAY   ' Exclus”es     '
       SETCOLOR(__COR(14))
    ENDIF   
    MENU TO B
    IF VV=1
        VV=2
        SET KEY 19 TO NULO
        SET KEY 4 TO MEN2
        SETCOLOR(__COR(11))
        @ 6,1 CLEA TO 19,78
        RETURN
    ENDI 
    
    IF VC=1
        LOOP 
    ENDI 
    
    IF B=0
        SET KEY 4 TO
        SET KEY 19 TO
        DO SAIR
    ELSEIF B=1
        SET KEY 4 TO 
        SET KEY 19 TO 
        DO CAM3_210
    ELSEIF B=2
        SET KEY 4 TO 
        SET KEY 19 TO 
        DO CAM3_210
    ELSEIF B=3
        SET KEY 4 TO 
        SET KEY 19 TO 
        DO CAM3_230
    ELSEIF B=4
        SET KEY 4 TO 
        SET KEY 19 TO 
        DO CAM3_240
    ENDIF 
ENDDO 

**************
PROC MEN3
**************

PRM=1
DO WHIL .T.
    VV=2
    VC=2
    NIVHLP=0    
    SETCOLOR(__COR(11))
    SET KEY 4 TO 
    SET KEY 19 TO 
    @ 4,27 SAY ' SOCIOS '
    @ 4,66 SAY ' RELATORIOS '
    @ 6,1 CLEA TO 19,78 && LIMPA A MOLDURA DO CENTRO
    
    SETCOLOR(__COR(14))
    @ 0,67 SAY LEFT(DIA(DATE()),3)+' '+DTOC(DATE())
    @ 23,11 CLEA TO 23,78 && LIMPA A LINHA DE MENSAGEM
    DO CASE 
    CASE PRM=1
        MENSAGEM='Inclui Fita(s) no Cadastro'
    CASE PRM=3
        MENSAGEM='Modifica Dados das Fitas'
    CASE PRM=5
        MENSAGEM='Obtm Informa”es sobre as Fitas'
    CASE PRM=7
        MENSAGEM='Apaga uma Fita do Cadastro'
    ENDCASE 
    @ 23,CENTRA(MENSAGEM) SAY MENSAGEM
    SETCOLOR(__COR(29))
    @ 4,46 SAY ' FITAS '
    SETCOLOR(__COR(23))
    @ 06,38 SAY "ฺฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฟ"
    @ 07,38 SAY "ณþณ                 ณþณ"
    @ 08,38 SAY "ณþณ                 ณþณ"
    @ 09,38 SAY "ณþณ                 ณþณ"
    @ 10,38 SAY "ณþณ                 ณþณ"
    @ 11,38 SAY "ณþณ                 ณþณ"
    @ 12,38 SAY "ณþณ                 ณþณ"
    @ 13,38 SAY "ณþณ                 ณþณ"
    @ 14,38 SAY "ภฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤู"
    
    DECL AFITA[7]
    AFITA[1]='Cadastramento' 
    AFITA[2]='             ' 
    AFITA[3]='Modifica”es ' 
    AFITA[4]='             ' 
    AFITA[5]='Informa”es  ' 
    AFITA[6]='             ' 
    AFITA[7]='Exclus”es    ' 
    
    DECL LFITA[7]
    STOR .T. TO LFITA[1],LFITA[3],LFITA[5]
    STOR .F. TO LFITA[2],LFITA[4],LFITA[6]
    STOR CFG TO LFITA[7]
    
    C=ACHOICE(7,43,13,55,AFITA,LFITA,"MENUFUNC",PRM)
    
    SETCOLOR(__COR(12))
    
    PRM=C
    
    IF C=0
        IF LASTKEY()=19
            VV=2
            SET KEY 19 TO NULO
            SET KEY 4 TO MEN3
            SETCOLOR(__COR(11))
            @ 6,1 CLEA TO 19,78
            VC=1
            B=1
            KEYB CHR(13)
            RETURN 
        ELSEIF LASTKEY()=4
            DO MEN4  
        ELSEIF LASTKEY()=27
            DO SAIR
        ENDI 
        LOOP 
     ELSEIF C=1
          SET KEY 4 TO 
          SET KEY 19 TO 
          DO CAM3_310
     ELSEIF C=3
          SET KEY 4 TO 
          SET KEY 19 TO 
          DO CAM3_310
     ELSEIF C=5
        SET KEY 4 TO 
        SET KEY 19 TO 
        DO CAM3_330
     ELSEIF C=7
        SET KEY 4 TO 
        SET KEY 19 TO 
        DO CAM3_340
    ENDIF
ENDDO

**************
PROC MEN4
**************
D=1
DO WHIL .T.
    NIVHLP=0    
    SETCOLOR(__COR(11))
    SET KEY 4 TO NULO
    SET KEY 19 TO VOLTAR
    @ 4,46 SAY ' FITAS '
    @ 4,27 SAY ' SOCIOS '
    @ 6,1 CLEA TO 19,78 && LIMPA A MOLDURA DO CENTRO
    
    SETCOLOR(__COR(29))
    
    @ 4,66 SAY ' RELATORIOS '
    
    SETCOLOR(__COR(16))
    IF GETE("MODO")#"1"
      @ 06,33 SAY 'ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ'
      @ 07,33 SAY 'ณ๘                                         ๘ณ'
      @ 08,33 SAY 'ณ๘                                         ๘ณ'
      @ 09,33 SAY 'ณ๘                                         ๘ณ'
      @ 10,33 SAY 'ณ๘                                         ๘ณ'
      @ 11,33 SAY 'ณ๘                                         ๘ณ'
      @ 12,33 SAY 'ณ๘                                         ๘ณ'
      @ 13,33 SAY 'ณ๘                                         ๘ณ'
      @ 14,33 SAY 'ณ๘                                         ๘ณ'
      @ 15,33 SAY 'ณ๘                                         ๘ณ'
      @ 16,33 SAY 'ณ๘                                         ๘ณ'
      @ 17,33 SAY 'ณ๘                                         ๘ณ'
      @ 18,33 SAY 'ภง-----------------------------------------งู'
    ELSE
      @ 06,33 SAY 'ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ'
      @ 07,33 SAY 'ณo                                         oณ'
      @ 08,33 SAY 'ณo                                         oณ'
      @ 09,33 SAY 'ณo                                         oณ'
      @ 10,33 SAY 'ณo                                         oณ'
      @ 11,33 SAY 'ณo                                         oณ'
      @ 12,33 SAY 'ณo                                         oณ'
      @ 13,33 SAY 'ณo                                         oณ'
      @ 14,33 SAY 'ณo                                         oณ'
      @ 15,33 SAY 'ณo                                         oณ'
      @ 16,33 SAY 'ณo                                         oณ'
      @ 17,33 SAY 'ณo                                         oณ'
      @ 18,33 SAY 'ภ-------------------------------------------ู'
    ENDIF      
    
    SETCOLOR(__COR(18))
    @ 0,67 SAY LEFT(DIA(DATE()),3)+' '+DTOC(DATE())
    @ 23,11 CLEA TO 23,78 && LIMPA A LINHA DE MENSAGEM
    
    @ 08,37 PROMPT ' 1. Resumo Di rio de Movimentos       ';
            MESSAGE 'Relatขrio dos Movimentos do Dia'
    @ 09,37 PROMPT ' 2. Mapa Di rio de Receitas           ';
            MESSAGE 'Relatขrio da Receita do Dia e do Acumulado Ms'
    @ 10,37 PROMPT ' 3. Relatขrios do Acervo de Fitas     ';
            MESSAGE 'Cat logos ou Etiquetas das Fitas do Acervo'
    @ 11,37 PROMPT ' 4. Relatขrios do Arquivo de Sขcios   ';
            MESSAGE 'Relatขrios ou Etiquetas dos Sขcios'
    @ 12,37 PROMPT ' 5. Histขrico de Tกtulos por Sขcio    ';
            MESSAGE 'Controle dos Tกtulos que o Sขcio j  alugou'
    @ 13,37 PROMPT ' 6. Mapa de Fitas Alugadas            ';
            MESSAGE 'Lista as fitas que esto atualmente fora'
    @ 14,37 PROMPT ' 7. Relatขrio Previso de Devolu”es  ';
            MESSAGE 'Lista as fitas que devero ser devolvidas em uma data'
    @ 15,37 PROMPT ' 8. Relatขrio de Saกdas por Tกtulo    ';
            MESSAGE 'Imprime as Saกdas de Fitas do Inกcio do Ms at Hoje'
    @ 16,37 PROMPT ' 9. Mala Direta (Etiquetas)           ';
            MESSAGE 'Imprime Etiquetas para Correspondncia'
    MENU TO D
    
    IF VV=1
        VV=2
        SETCOLOR(__COR(11))
        @ 6,1 CLEA TO 19,78
        RETURN
    ENDIF 
    IF D=0
        DO SAIR
    ELSEIF D=1
        LOOP
    ELSEIF D=2
        LOOP
    ELSEIF D=3
        SET KEY 4 TO 
        SET KEY 19 TO 
        DO CAM3_430
    ELSEIF D=4
        SET KEY 4 TO 
        SET KEY 19 TO 
        DO CAM3_440
    ELSEIF D=5
        SET KEY 4 TO 
        SET KEY 19 TO 
        DO CAM3_450
    ENDIF
ENDDO

****************
PROC VOLTAR
****************
PARA PRG,LIN,VAR

IF PRG='MEN2'
    A=1
    VV=1
    VC=1
    KEYB CHR(13)+CHR(13)
    
ELSEIF PRG='MEN4'
    PRM=1
    VV=1
    VC=1
    KEYB CHR(13)
ENDI 
RETU 

*****************
FUNC MENUFUNC
*****************

PARA MOD,ELM,POS
IF MOD=0
    DO CASE 
    CASE ELM=1
        MENSAGEM='Inclui Fita(s) no Cadastro'
    CASE ELM=3
        MENSAGEM='Modifica Dados das Fitas'
    CASE ELM=5
        MENSAGEM='Obtm Informa”es sobre as Fitas'
    CASE ELM=7
        MENSAGEM='Apaga uma Fita do Cadastro'
    ENDCASE 
    SETCOLOR(__COR(14))
    @ 23,11 CLEA TO 23,78 && LIMPA A LINHA DE MENSAGEM
    @ 23,CENTRA(MENSAGEM) SAY MENSAGEM
    SETCOLOR(__COR(23))
ELSEIF MOD=1
    KEYB CHR(3)
ELSEIF MOD=2
    KEYB CHR(18)
ELSEIF MOD=3
    UT=LASTKEY()
    DO CASE 
    CASE UT=19
        RETURN(0)
    CASE UT=4
        RETURN(0)
    CASE UT=27
        RETURN(0)
    CASE UT=13 
        RETURN(1)
    CASE UPPER(CHR(UT))$"CMIE"
        KEYB CHR(13)
    ENDCASE 
    RETURN(3)
ENDIF
RETURN(2)

*********
PROC SAIR
*********
PRIVATE escolha,tela,cor
 COR=SETCOLOR()
 TELA=SAVESCREEN(11,24,14,62)
 SETCOLOR(__COR(15))
 COR_TELA(12,26,14,62,"W/N")
 SETCOLOR(__COR(4))
 SCROLL(11,24,13,60,0)
 janela(11,24,13,60)
 ESCOLHA=' '
 @ 12,26 SAY"DESEJA SAIR DO SISTEMA ? (S/N):"GET ESCOLHA PICT'!' VALID (ESCOLHA$"SN")
 SET CURSOR ON
 SET CONFIRM OFF
 READ
 SET CONFIRM ON
 SET CURSOR OFF
 IF ESCOLHA='S'
  SET COLOR TO
  CLEA 
  SETCOLOR(__COR(5))
  FINAL=SECONDS()
  TOTAL=FINAL-_TINIC
  TEMPO=TSTRING(TOTAL)
  HORAS=LEFT(TEMPO,2)
  MIN=SUBST(TEMPO,4,2)
  SEG=RIGHT(TEMPO,2)  
  @ 0,0
  @ 0,2 SAY "O Sistema CAMERA 3 foi utilizado durante "+HORAS+" horas, ";
            +min+" minutos e "+seg+" segundos."
  SET COLO TO 
  SET CURSOR ON 
  @ 2,0
  CLEA ALL 
  QUIT 
 ELSE
  SETCOLOR(COR)
  RESTSCREEN(11,24,14,62,TELA)
  RETURN 
 ENDIF
*********
PROC NULO
*********
RETURN 
******************************>> FIM DO ARQUIVO <<*****************************
