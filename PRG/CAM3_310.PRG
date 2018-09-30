******************************************************************************
* SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS              * 
* VERSAO    : 1.1 - Copyright 1992                                           * 
* PROGRAMA  : CAM3_310.PRG                                                   *
* DESCRI€AO : Programa para o Cadastramento das Fitas.                       *
* AUTOR     : Marcelo Leal Limaverde Cabral                                  *
* DATA      : 17/06/92                                                       * 
******************************************************************************
PRIVATE TELA
TELA=SAVESCREEN(4,0,21,79)
SET KEY 18 TO NULO
SET KEY 3  TO NULO

SELE C
USE PRECOS
SET INDEX TO PRECOS

SELE B
USE GENERO_F
SET INDEX TO GENERO_F

SELE A
USE FITAS 
SET INDEX TO FITAS01,FITAS02,FITAS03

@ 6,1 CLEA TO 19,78 && LIMPA A MOLDURA DO CENTRO

SETCOLOR(__COR(14))
@ 23,11 CLEA TO 23,78

SETCOLOR(__COR(9))

CAIXOUT(12,39,13,40)

DO WHIL .T.
  SETCOLOR(__COR(9))
  NIVHLP=210
  IF C=1
    TITC3="CADASTRAR"
    BTOV()
    OLDCDG=CODIGOXG+'-'+NUMERXFITA
  ELSE
    TITC3="MODIFICAR"
    TITULXFITA=SPACE(40)
    CODIG_FITA=SPACE(07)
    DO CAM3_320
    IF TITULXFITA=SPACE(40).AND.CODIG_FITA=SPACE(07)
       EXIT
    ENDIF   
    ATOV()
    OLDCDG=CODIGOXG+'-'+NUMERXFITA
  ENDIF  
  SETCOLOR(__COR(14))
  SCROLL(14,10,19,70,0)
  DO WHILE .T.
    CODIG_FITA=SPACE(7)
    SAI=1
    SETCOLOR(__COR(9))
    DO CAM3_311
    SET CURSOR ON 
    SET CONFIRM OFF
    READ 
    SET CONFIRM ON
    SETCOLOR(__COR(14))
    SET KEY 18 TO
    SET KEY 3  TO
    IF LASTKEY()=27
       SET KEY 18 TO NULO
       SET KEY 3  TO NULO
       SET CURSOR OFF 
       EXIT
    ENDIF
    NIVHLP=0
    SINOPXFITA=HARDCR(MEMOEDIT(SINOPXFITA,14,10,19,70,.T.,"TXTEDIT"))
    NIVHLP=210
    IF LASTKEY()=27
       LOOP
    ENDIF
    SET KEY 18 TO NULO
    SET KEY 3  TO NULO
    SET CURSOR OFF 

    SETCOLOR(__COR(22))
    TONE(300,3)

    @ 23,2 CLEA TO 23,78
    @ 23,2 SAY 'Escolha a Op‡„o :'
    @ 23,COL()+2 PROMPT'Confirmar'
    @ 23,COL()+3 PROMPT'Modificar'
    @ 23,COL()+3 PROMPT'Abandonar'
    MENU TO SAI
    @ 23,2 SAY "MENSAGEM:"+SPACE(65)
    IF SAI=1
     IF C=1
      GO BOTTOM
      APPEND BLANK
     ENDIF 
     VTOA()
     EXIT
    ELSEIF SAI=3
     EXIT
    ENDIF
  ENDDO
    SAI=1    
    SETCOLOR(__COR(22))
    @ 23,2 CLEA TO 23,78
    @ 23,13 SAY 'DESEJA &TITC3 MAIS UMA FITA ? '
    @ 23,COL()+1 PROMPT'Sim'
    @ 23,COL()+1 SAY 'ou'
    @ 23,COL()+1 PROMPT'N„o'
    MENU TO SAI
    @ 23,2 SAY "MENSAGEM:"+SPACE(65)
    IF SAI=2.OR.SAI=0
        EXIT 
    ENDIF
ENDDO
SET KEY 18 TO 
SET KEY 3  TO 
SET KEY 27 TO 
CLOSE DATABASE 
RESTSCREEN(4,0,21,79,TELA)
RETURN 

*****************
 FUNCTION GENERO
***************** 
PRIVA ACHOU,CORG,REG

CORG=SETCOLOR()

SELE B
SEEK CODIGOXG
ACHOU=FOUND()
IF ! ACHOU
   SETCOLOR(__COR(14))
   @ 23,2 SAY 'MENSAGEM:   Gˆnero Digitado N„o Consta na Tabela de Gˆneros'
   TONE(300,3)
   SETCOLOR(CORG)
   RETURN (ACHOU)
ELSE
   SETCOLOR(__COR(14))
   @ 23,11 SAY SPACE(65)
ENDIF

SELE A
IF C=1
   REG=RECNO()
   SET ORDER TO 2
   SET SOFTSEEK ON
   SEEK CODIGOXG+"9999"
   ACHOU=!EOF()
   SET SOFTSEEK OFF
   SKIP -1
   IF CODIGO_G==CODIGOXG
     KEYB STRZERO(VAL(NUMER_FITA)+1,4)
   ELSE
     KEYB "0001"
   ENDIF    
   GOTO REG
ENDIF   
SETCOLOR(__COR(14))
@ 23,11 SAY SPACE(65)
SETCOLOR(CORG)
RETURN(.T.)

******************
 FUNCTION NUMFITA
******************
PRIVA ACHOU,CORG,REG

CORG=SETCOLOR()
IF NUMERXFITA=SPACE(4).OR.VAL(NUMERXFITA)<1
   SETCOLOR(__COR(14))
   @ 23,2 SAY 'MENSAGEM:   Digite o N£mero de Cadastro da Fita'
   TONE(300,3)
   SETCOLOR(CORG)
   RETURN (.F.)
ELSE
   SETCOLOR(__COR(14))
   @ 23,11 SAY SPACE(65)
ENDIF
SELE A
CODIG_FITA=CODIGOXG+'-'+NUMERXFITA
IF C=1.OR.CODIG_FITA#OLDCDG
   REG=RECNO()
   SET ORDER TO 2
   SEEK LEFT(CODIG_FITA,2)+RIGHT(CODIG_FITA,4)
   ACHOU=FOUND()
   IF ACHOU
      SETCOLOR(__COR(14))
      @ 23,2 SAY 'MENSAGEM:   N£mero Digitado j  Existe no Arquivo de Fitas'
      TONE(300,3)
      SETCOLOR(CORG)
      GOTO REG
      RETURN (.F.)
   ELSE
      SETCOLOR(__COR(14))
      @ 23,11 SAY SPACE(65)
      SETCOLOR(CORG)
      GOTO REG
      RETURN(.T.)
   ENDIF
ENDIF   
SETCOLOR(__COR(14))
@ 23,11 SAY SPACE(65)
SETCOLOR(CORG)
RETURN(.T.)

*****************
 FUNCTION TSTPRC
*****************
PRIVA ACHOU,CORG

CORG=SETCOLOR()

SELE C
SEEK CODIGOXP
ACHOU=FOUND()
IF ! ACHOU
   SETCOLOR(__COR(14))
   @ 23,2 SAY 'MENSAGEM:                 C¢digo de Pre‡o Inv lido'
   TONE(300,3)
ELSE
   SETCOLOR(__COR(14))
   @ 23,11 SAY SPACE(65)
ENDIF
SELE A
SETCOLOR(CORG)
RETURN (ACHOU)
****************
FUNCTION TXTEDIT
****************

PARAMETERS MODO,LINHA,COLUNA
PRIVATE FORA
UT=LASTKEY()

*********************************************
* MODO DE PROCESSAMENTO DE MOVIMENTO NORMAL *
*********************************************
IF MODO=0
   OCOL=COL()
   OLIN=ROW()
   
   IF LINHA > 10
      KEYBOARD REPL(CHR(5),LINHA-10)
      RETURN(0)
   ENDIF
   
   SETCOLOR(__COR(9))

   @ 20,11 SAY 'L: '+LTRIM(STR(LINHA))+' '
   @ 20,20 SAY 'C: '+LTRIM(STR(COLUNA+1))+' '

   SETCOLOR(__COR(14))

   @ OLIN,OCOL SAY ""
   RETURN(0)
ELSE
*********************************************
* MODO DE PROCESSAMENTO DE TECLAS ESPECIAIS *
*********************************************
   VEZ=0
   DO CASE
   CASE UT=286  &&---------------------------> TECLA ALT-A [CARACTERE ¦]
     KEYB CHR(166)
     RETURN(0)
   CASE UT=280  &&---------------------------> TECLA ALT-O [CARACTERE §]
     KEYB CHR(167)
     RETURN(0)
   CASE UT=271  &&---------------------------> TECLA SHIFT-TAB [VOLTA TAB'S]
     KEYB REPL(CHR(19),4)
     RETURN(0)
   CASE UT=16   &&---------------------------> TECLA CTRL-P [APAGA PALAVRA]
     RETURN(20)
   CASE UT=-1   &&---------------------------> TECLA F2     [ROLAMENTO]
     RETURN(35)
   CASE UT=-2   &&---------------------------> TECLA F3     [QUEBRA PALAVRA]
     RETURN(34)
   CASE UT=2    &&---------------------------> TECLA CTRL-B [REFORMATA]
     RETURN(2)
   CASE UT=287  &&---------------------------> TECLA ALT-S  [SAI E SALVA]
     RETURN(23)
   CASE UT=27   &&---------------------------> TECLA ESC    [ABORTA]
     RETURN(27)
   CASE UT=12   &&---------------------------> TECLA CTRL-L [APAGA LINHA]
     RETURN(25)
   CASE UT=279  &&---------------------------> TECLA ALT-I  [INSERE LINHA]
     RETURN(14)
   ENDCASE
   RETURN(0)
ENDIF
******************************>> FIM DO ARQUIVO <<*****************************
