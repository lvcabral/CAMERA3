******************************************************************************
* SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS              *
* VERSŽO    : 1.1 - Copyright 1992                                           *
* PROGRAMA  : CAM3_230.PRG                                                   *
* DESCRI€ŽO : Programa de Informa‡”es sobre o Cadastro de Socios.            *
* AUTOR     : Marcelo Leal Limaverde Cabral                                  *
* DATA      : 08/09/92                                                       *
******************************************************************************
PRIVATE TELA
SET KEY 18 TO NULO
SET KEY 3  TO NULO
DO WHILE .T.
   NIVHLP=230

   SETCOLOR(__COR(29))
   @ 21,0 SAY ' [ESC]  VOLTA AO MENU ANTERIOR   º  '+CHR(24)+CHR(25)+CHR(27)+;
              CHR(26)+'  MOVEM A BARRA  º  [ENTER]  SELECIONA '

   SETCOLOR(__COR(18))
   @ 23,11 CLEA TO 23,78
   @ 6,41 TO 12,69 DOUBLE
   @ 07,42  PROMPT' A. Consulta por N£mero    ' MESSAGE'Consulta Socio(s) pelo N£mero dele(s)'
   @ 08,41  SAY 'Ç                           ¶'
   @ 08,42 TO 8,68
   @ 09,42  PROMPT' B. Consulta por Nome      ' MESSAGE'Consulta Socio(s) pelo Nome dele(s)'
   @ 10,41  SAY 'Ç                           ¶'
   @ 10,42 TO 10,68
   @ 11,42  PROMPT' C. Comprovantes por S¢cio ' MESSAGE'Consulta os Comprovantes de Retirada de um S¢cio'

   MENU TO BC

   DO CASE
   CASE BC=0
      SET KEY 18 TO
      SET KEY 3  TO
      RELEASE CONTDBF
      NIVHLP=0
      RETURN
   CASE BC<3

      SELE A
      USE SOCIOS
      SET INDEX TO SOCIOS01,SOCIOS02

      DO CASE
      CASE BC=1
         SET ORDER TO 2
         NIVHLP=231
      CASE BC=2
         SET ORDER TO 1
         NIVHLP=232
      ENDCASE

      GO TOP

      DO CONSULS

    CASE BC=3
      NIVHLP=233
      SELE C
      USE FITAS
      SET INDEX TO FITAS02
      SELE B
      USE SOCIOS
      SET INDEX TO SOCIOS02

      SELE A
      USE COMPROV
      SET INDEX TO COMPR02
      SET RELATION TO NUME_SOCIO INTO B

      GO TOP

      TELA=SAVESCREEN(4,0,21,79)
      @ 23,11 CLEAR TO 23,78
      SETCOLOR(__COR(11))
      @ 20,0
      DECLARE CAMPOS[4],TITULOS[4],MASCARA[1]
      CAMPOS[01]="STRZERO(A->NUME_SOCIO,5)"
      CAMPOS[02]="B->NOME_SOCIO"
      CAMPOS[03]="STRZERO(A->NUME_COMPR,5)"
      CAMPOS[04]="IF(DATA_PREVI>=DATE(),' '+DtoC(A->DATA_PREVI)+' ','<Atrasado>')"
      TITULOS[01]="NUMERO"
      TITULOS[02]="NOME"
      TITULOS[03]="N§ DO COMPROVANTE"
      TITULOS[04]="DEVOLU€AO"
      SETCOLOR(__COR(9))
      SCROLL(4,0,19,79,0)
      @ 4,0 TO 19,79 DOUBLE
      CONSUL="ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ  C O N S U L T A   D E   S O C I O S  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
      @ 5,CENTRA(CONSUL) SAY CONSUL
      @ 6,0 SAY CHR(204)+REPL(CHR(205),78)+CHR(185)
      SETCOLOR(__COR(29))

      @ 21,0 SAY'  [ESC] VOLTA º  [F4] PROCURA  º  [ENTER] DETALHA  º  [I] INICIO  º  [F] FINAL  '

      SETCOLOR(__COR(7))
      @ 8,1 SAY REPL(CHR(205),78)

      SET KEY 18 TO
      SET KEY 3  TO

      DBEDIT(7,2,18,77,CAMPOS,"INFOR",MASCARA,TITULOS)

      SET KEY 18 TO NULO
      SET KEY 3  TO NULO

      CLOSE DATA
      RESTSCREEN(4,0,21,79,TELA)

      LOOP
  ENDCASE
ENDDO

*****************
PROCEDURE CONSULS
*****************
    PRIVATE TELA
    TELA=SAVESCREEN(4,0,21,79)
    @ 23,11 CLEAR TO 23,78
    SETCOLOR(__COR(11))
    @ 20,0
    DECLARE CAMPOS[4],TITULOS[4],MASCARA[1]
    IF INDEXORD()=1
       NO=1
       NU=2
    ELSE
       NO=2
       NU=1
    ENDIF
    CAMPOS[NU]="STRZERO(A->NUME_SOCIO,5)"
    CAMPOS[NO]="A->NOME_SOCIO"
    CAMPOS[03]="A->FONE_SOCIO"
    CAMPOS[04]="SPACE(3)+LEFT(DTOC(A->ANIV_SOCIO),5)+SPACE(3)"
    TITULOS[NU]="NUMERO"
    TITULOS[NO]="NOME"
    TITULOS[03]="TELEFONE"
    TITULOS[04]="ANIVERSARIO"
    SETCOLOR(__COR(9))
    SCROLL(4,0,19,79,0)
    @ 4,0 TO 19,79 DOUBLE
    CONSUL="ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ  C O N S U L T A   D E   S O C I O S  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
    @ 5,CENTRA(CONSUL) SAY CONSUL
    @ 6,0 SAY CHR(204)+REPL(CHR(205),78)+CHR(185)
    SETCOLOR(__COR(29))

    @ 21,0 SAY'  [ESC] VOLTA º  [F4] PROCURA  º  [ENTER] DETALHA  º  [I] INICIO  º  [F] FINAL  '

    SETCOLOR(__COR(7))
    @ 8,1 SAY REPL(CHR(205),78)

    SET KEY 18 TO
    SET KEY 3  TO

    DBEDIT(7,2,18,77,CAMPOS,"INFOR",MASCARA,TITULOS)

    SET KEY 18 TO NULO
    SET KEY 3  TO NULO

    CLOSE DATA
    RESTSCREEN(4,0,21,79,TELA)
    RETURN

*****************
PROCEDURE DETALHA
*****************

PRIVATE TELA,MENS
TELA=SAVESCREEN(4,0,21,79)

SETCOLOR(__COR(10))

CAIXOUT(12,39,13,40)
ATOV()
DO CAM3_211
CLEAR GETS
MENS="Aperte uma Tecla para Continuar ...."
SETCOLOR(__COR(14))
@ 23,CENTRA(MENS) SAY MENS
INKEY(0)
RESTSCREEN(4,0,21,79,TELA)
SETCOLOR(__COR(7))
RETURN

******************
PROCEDURE DETALHA2
******************
PRIVATE CORD,TELAD
CORd=SETCOLOR()
TELAd=SAVESCREEN(1,0,24,79)
SETCOLOR(__COR(13))
CPB(1,0,24,79)
  SETCOLOR(__COR(14))
  @ 24,0
  @ 24,1 SAY "MENSAGEM:"
  SETCOLOR(__COR(5))
  @  2,1 CLEAR TO  2,78
  @ 21,1 CLEAR TO 22,78
  TITULO="Comprovante de Retiradas de Fitas"
  @  2, CENTRA(TITULO)  SAY TITULO
  @ 21, 48 SAY "      MULTA Cr$"
  @ 22, 48 SAY "VALOR TOTAL Cr$"
  SETCOLOR(__COR(13))
  @  1,  0  TO 23, 79    DOUBLE
  @  7,  1  TO  7, 78
  @  3,  1  TO  5, 78    DOUBLE
  @  9,  1  TO  9, 78
  TELACOMP(0)
  SETCOLOR(__COR(7))
  @  4,  6  SAY  A->NUME_COMPR PICTURE "999999"
  @  4, 31  SAY  STRZERO(A->NUME_SOCIO,5)
  @  4, 44  SAY  B->NOME_SOCIO
  PRIVATE FOR_PAGA[5]
  FOR_PAGA[1]="24 horas"
  FOR_PAGA[2]="48 horas"
  FOR_PAGA[3]="S bado  "
  FOR_PAGA[4]="Especial"
  FOR_PAGA[5]="Teclado "
  @  6, 17  SAY  FOR_PAGA[FORM_PAGAM]
  @  6, 34  SAY  A->DATA_SAIDA
  @  6, 55  SAY  STRZERO(A->QTDE_DIAS,2)
  SETCOLOR(__COR( IF(A->DATA_PREVI<DATE(),17,7) ))
  @  6, 70  SAY  A->DATA_PREVI
  SETCOLOR(__COR(7))
  CF=0
  STOTAL=0
  ATOV()
  PRIVATE NUMEFITA[10]
  SET ORDER TO 0
  DO WHILE A->NUME_COMPR=NUMEXCOMPR
     IF CF#0
        ATOV()
     ENDIF
     @ 10+CF, 8 SAY NUMEXFITA1 PICT"@! AA-9999"
     @ 10+CF,65 SAY VALOXFITA1 PICT"@E 999,999.99"
     CF=CF+1
     NUMEFITA[CF]=NUMEXFITA1
     STOTAL=STOTAL+VALOXFITA1
     SELE C
     SEEK LEFT(NUMEXFITA1,2)+RIGHT(NUMEXFITA1,4)
     @ 10+CF-1,20 SAY C->TITUL_FITA
     SELE A
     SKIP
  ENDDO
  SKIP -CF
  SET ORDER TO 1
  VLMULTA=0
  SETCOLOR(__COR(1))
  @ 21,65 SAY VLMULTA PICTURE "@E 999,999.99"
  @ 22,65 SAY STOTAL  PICTURE "@E 999,999.99"
  SETCOLOR(__COR(14))
  @ 24,11 CLEA TO 24,78
  TITULO='Aperte Qualquer Tecla ....'
  @ 24,CENTRA(TITULO) SAY TITULO
  INKEY(0)
  RESTSCREEN(1,0,24,79,TELAD)
  SETCOLOR(CORD)
  RETURN

**************
FUNCTION INFOR
**************

PARAM MODO,I

PRIVA CAMPO,CCOR,VAI,REF

CAMPO=CAMPOS[I]
DO CASE
   CASE MODO<4
        IF MODO=2.OR.MODO=1
          TONE(400,2)
          RETURN(1)
        ELSEIF MODO=3
          RETURN(0)
         ENDIF
       RETURN(1)
   CASE LASTKEY()=27
       RETURN(0)
   CASE LASTKEY() = -3
       IF (INDEXORD()=2.AND.BC<3).OR.BC=3
        CCOR=SETCOLOR()
        SETCOLOR(__COR(21))
        VAI=0
        REF=CENTRA(REPL("X",22))
        @ 23,REF SAY 'N§ de Cadastro :'GET VAI PICT"99999"
        SET CURSOR ON
        READ
        SET CURSOR OFF
        @ 23,11 CLEAR TO 23,70
        IF LASTKEY()#27 .AND. .NOT. EMPTY(VAI)
           NUMREG=RECNO()
           IF BC<3
              SEEK VAI
           ELSE
              SEEK STR(VAI,5)
           ENDIF
           IF ! FOUND()
              TONE(300,3)
              GO NUMREG
           ENDIF
        ENDIF
        SETCOLOR(CCOR)
       ELSE
        CCOR=SETCOLOR()
        SETCOLOR(__COR(21))
        VAI=SPACE(33)
        REF=CENTRA(REPL("X",48))
        @ 23,REF SAY 'Nome do S¢cio :'GET VAI PICT"@!"
        SET CURSOR ON
        READ
        SET CURSOR OFF
        @ 23,11 CLEAR TO 23,70
        VAI=ALLTRIM(EAC(VAI))
        IF LASTKEY()#27 .AND. .NOT. EMPTY(VAI)
           NUMREG=RECNO()
           DBSEEK(VAI,.T.)
           IF EOF()
              TONE(300,3)
              GO NUMREG
           ENDIF
        ENDIF
        SETCOLOR(CCOR)
       ENDIF
       RETURN(1)
   CASE LASTKEY() = 13
        IF BC<3
           DO DETALHA
        ELSE
           DO DETALHA2
        ENDIF
        SETCOLOR(__COR(18))
        @ 23,11 CLEAR TO 23,78
        SETCOLOR(__COR(7))
        RETURN(2)
   CASE UPPER(CHR(LASTKEY())) = "I"
        GO TOP
        RETURN(1)
   CASE UPPER(CHR(LASTKEY())) = "F"
        IF DBFILTER()=""
           KEYBOARD CHR(30)
        ELSE
           GO BOTTOM
        ENDIF
        RETURN(1)
   OTHER
       RETURN(1)
ENDCASE
******************************>> FIM DO ARQUIVO <<*****************************
