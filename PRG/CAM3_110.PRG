******************************************************************************
* SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS              *
* VERSŽO    : 1.1 - Copyright 1992                                           *
* PROGRAMA  : CAM3_110.PRG                                                   *
* DESCRI€ŽO : Programa de Saidas de Fitas da Locadora.                       *
* AUTOR     : Marcelo Leal Limaverde Cabral                                  *
* DATA      : 17/07/92                                                       *
******************************************************************************
#include "cam3.ch"
SELECT E
USE CONTROLE
SET INDEX TO CONTROLE
SELECT D
USE PRECOS
SET INDEX TO PRECOS
SELECT C
USE FITAS
SET INDEX TO FITAS01,FITAS02,FITAS03
SET ORDER TO 2
GO TOP
SET RELATION TO CODIGO_P INTO D
SELECT B
USE SOCIOS
SET INDEX TO SOCIOS01,SOCIOS02
SET ORDER TO 2
GO TOP
SELECT A
USE COMPROV
SET INDEX TO COMPR01,COMPR02
BTOV()
GO BOTTOM
NUMEXCOMPR=A->NUME_COMPR+1
GO TOP
SET CONFIRM OFF
SET KEY 18 TO NULO
SET KEY  3 TO NULO
SET KEY -3 TO LOOK_FOR
COR=SETCOLOR()
TELA=SAVESCREEN(1,0,24,79)
SETCOLOR(__COR(13))
CPB(1,0,24,79)
DO WHILE .T.
  QTD_DIAS=0
  OPFP=1
  DECLARE NUMEFITA[10],VALOFITA[10]
  FOR T=1 TO 10
    NUMEFITA[T]=SPACE(7)
    VALOFITA[T]=0
  NEXT
  SETCOLOR(__COR(14))
  @ 24,0
  @ 24,1 SAY "MENSAGEM:"
  SETCOLOR(__COR(5))
  @  2,1 CLEAR TO  2,78
  @ 21,1 CLEAR TO 21,78
  TITULO="Comprovante de Retirada de Fitas"
  @  2, CENTRA(TITULO)  SAY TITULO
  @ 21, 48 SAY "VALOR TOTAL Cr$"
  SETCOLOR(__COR(13))
  @  1,  0  TO 22, 79    DOUBLE
  @  7,  1  TO  7, 78  
  @  3,  1  TO  5, 78    DOUBLE
  @  9,  1  TO  9, 78  
  TELACOMP(0)
  LACO=.T.
  DO WHILE LACO
   SETCOLOR(__COR(6))
   HLPKEY="[ESC] VOLTA"
   @ 23,  0
   @ 23, CENTRA(HLPKEY) SAY HLPKEY
   SETCOLOR(__COR(13))
   @  4,  6  GET  NUMEXCOMPR PICTURE "999999" VALID C_COMPR(NUMEXCOMPR)
   SET CURSOR ON
   READ
   SET CURSOR OFF
   IF LASTKEY()=27
      EXIT
   ENDIF
   DO WHILE LACO 
    SETCOLOR(__COR(6))
    HLPKEY="[ESC] VOLTA - [F4] PROCURA"
    @ 23,  0
    @ 23, CENTRA(HLPKEY) SAY HLPKEY
    SETCOLOR(__COR(7))
    @  4, 31  GET  NUMEXSOCIO  PICTURE "99999" VALID C_NUMSOC(NUMEXSOCIO)
    SET CURSOR ON
    READ
    SET CURSOR OFF
    @  4, 31 SAY STRZERO(NUMEXSOCIO,5)
    IF LASTKEY()=27
       EXIT
    ENDIF
    DO WHILE LACO
     SETCOLOR(__COR(6))
     HLPKEY="[ESC] VOLTA - "+CHR(24)+CHR(25)+" MUDAM ITEM"
     @ 23,  0
     @ 23, CENTRA(HLPKEY) SAY HLPKEY
     SETCOLOR(__COR(14))
     @ 24,11 CLEAR TO 24,79
     SETCOLOR(__COR(26))
     PRIVATE FOR_PAGA[5]
     FOR_PAGA[1]="24 horas"
     FOR_PAGA[2]="48 horas"
     FOR_PAGA[3]="S bado  "
     FOR_PAGA[4]="Especial"
     FOR_PAGA[5]="Teclado "
     FORMXPAGAM=ACHOICE(6,17,6,24,FOR_PAGA,.T.,"F_P",OPFP)
     IF FORMXPAGAM=0
        EXIT
     ENDIF
     IF FORMXPAGAM=3.AND.DOW(DATE())#7
        SETCOLOR(__COR(14))
        @ 24,32 SAY " Hoje n„o ‚ S bado "
        SETCOLOR(__COR(26))
        TONE(300,3)
        LOOP
     ENDIF
     DO WHILE LACO
      SETCOLOR(__COR(6))
      HLPKEY="[ESC] VOLTA"
      @ 23,  0
      @ 23, CENTRA(HLPKEY) SAY HLPKEY
      SETCOLOR(__COR(7))
      DATAXSAIDA=DATE()
      @  6, 34  SAY  DATAXSAIDA
      @  6, 55  GET  QTDEXDIAS PICTURE "99" VALID C_DIAS(QTDEXDIAS,FORMXPAGAM)
      IF FORMXPAGAM=3
         CLEAR GETS
         QTDEXDIAS=2
      ELSE
         SET CURSOR ON
         READ
         SET CURSOR OFF
      ENDIF   
      @ 6,55 SAY STRZERO(QTDEXDIAS,2)
      IF LASTKEY()=27
         EXIT
      ENDIF
      DATAXPREVI=INCR_DATA(DATAXSAIDA,QTDEXDIAS)
      DO WHILE LACO     
       SETCOLOR(__COR(6))
       HLPKEY="[ESC] VOLTA"
       @ 23,  0
       @ 23, CENTRA(HLPKEY) SAY HLPKEY
       SETCOLOR(__COR(14))
       @ 24,11 CLEAR TO 24,79
       SETCOLOR(__COR(26))
       @  6, 70  GET  DATAXPREVI VALID DATAXPREVI>DATE()
       SET CURSOR ON
       READ
       SET CURSOR OFF
       IF LASTKEY()=27
          EXIT
       ENDIF
       DO WHILE LACO
        SETCOLOR(__COR(6))
        HLPKEY="[ESC] VOLTA - [F4] PROCURA"
        @ 23,  0
        @ 23, CENTRA(HLPKEY) SAY HLPKEY
        SETCOLOR(__COR(14))
        @ 24,11 CLEAR TO 24,79
        SETCOLOR(__COR(26))
        @ 10, 8 GET NUMEFITA[01] PICT"@! AA-9999" VALID C_NUMFIT(NUMEFITA[1])
        IF FORMXPAGAM=5
           @ 10,65 GET VALOFITA[01] PICTURE "@E 999,999.99"
        ELSE
           @ 10,65 SAY VALOFITA[01] PICTURE "@E 999,999.99"
        ENDIF

        @ 11, 8 GET NUMEFITA[02] PICT"@! AA-9999" VALID C_NUMFIT(NUMEFITA[2])
        IF FORMXPAGAM=5
          @ 11,65 GET VALOFITA[02] PICTURE "@E 999,999.99"
        ELSE
          @ 11,65 SAY VALOFITA[02] PICTURE "@E 999,999.99"
        ENDIF

        @ 12, 8 GET NUMEFITA[03] PICT"@! AA-9999" VALID C_NUMFIT(NUMEFITA[3])
        IF FORMXPAGAM=5
           @ 12,65 GET VALOFITA[03] PICTURE "@E 999,999.99"
        ELSE
           @ 12,65 SAY VALOFITA[03] PICTURE "@E 999,999.99"
        ENDIF   

        @ 13, 8 GET NUMEFITA[04] PICT"@! AA-9999" VALID C_NUMFIT(NUMEFITA[4])
        IF FORMXPAGAM=5
           @ 13,65 GET VALOFITA[04] PICTURE "@E 999,999.99"
        ELSE
           @ 13,65 SAY VALOFITA[04] PICTURE "@E 999,999.99"
        ENDIF

        @ 14, 8 GET NUMEFITA[05] PICT"@! AA-9999" VALID C_NUMFIT(NUMEFITA[5])
        IF FORMXPAGAM=5
           @ 14,65 GET VALOFITA[05] PICTURE "@E 999,999.99"
        ELSE
           @ 14,65 SAY VALOFITA[05] PICTURE "@E 999,999.99"
        ENDIF

        @ 15, 8 GET NUMEFITA[06] PICT"@! AA-9999" VALID C_NUMFIT(NUMEFITA[6])
        IF FORMXPAGAM=5
           @ 15,65 GET VALOFITA[06] PICTURE "@E 999,999.99"
        ELSE
           @ 15,65 SAY VALOFITA[06] PICTURE "@E 999,999.99"
        ENDIF

        @ 16, 8 GET NUMEFITA[07] PICT"@! AA-9999" VALID C_NUMFIT(NUMEFITA[7])
        IF FORMXPAGAM=5
           @ 16,65 GET VALOFITA[07] PICTURE "@E 999,999.99"
        ELSE
           @ 16,65 SAY VALOFITA[07] PICTURE "@E 999,999.99"
        ENDIF

        @ 17, 8 GET NUMEFITA[08] PICT"@! AA-9999" VALID C_NUMFIT(NUMEFITA[8])
        IF FORMXPAGAM=5
           @ 17,65 GET VALOFITA[08] PICTURE "@E 999,999.99"
        ELSE
           @ 17,65 SAY VALOFITA[08] PICTURE "@E 999,999.99"
        ENDIF

        @ 18, 8 GET NUMEFITA[09] PICT"@! AA-9999" VALID C_NUMFIT(NUMEFITA[9])
        IF FORMXPAGAM=5
           @ 18,65 GET VALOFITA[09] PICTURE "@E 999,999.99"
        ELSE
           @ 18,65 SAY VALOFITA[09] PICTURE "@E 999,999.99"
        ENDIF

        @ 19, 8 GET NUMEFITA[10] PICT"@! AA-9999" VALID C_NUMFIT(NUMEFITA[10])
        IF FORMXPAGAM=5
           @ 19,65 GET VALOFITA[10] PICTURE "@E 999,999.99"
        ELSE
           @ 19,65 SAY VALOFITA[10] PICTURE "@E 999,999.99"
        ENDIF
        SET CURSOR ON
        READ
        SET CURSOR OFF
        IF LASTKEY()=27
           EXIT
        ENDIF
        IF EMPTY(NUMEFITA[1]).OR.NUMEFITA[1]=="  -    "
           LOOP
        ENDIF
        TOTAL=0
        DECLARE ITF[10]
        CITF=0
        FOR FT = 1 TO 10
           IF ! EMPTY(NUMEFITA[FT]).AND.NUMEFITA[FT]#"  -    "
            CITF=CITF+1
            TOTAL=TOTAL+VALOFITA[FT]
            ITF[CITF]=FT
           ENDIF 
        NEXT
        FT=FT-1    
        SETCOLOR(__COR(1))
        @ 21,64 SAY TOTAL PICTURE "@E 9999,999.99"
        DO WHILE LACO
         SETCOLOR(__COR(6))
         @ 23,  0
         SETCOLOR(__COR(22))
         @ 24,11 CLEA TO 24,78
         @ 24,13 SAY 'Escolha a Op‡„o :'
         @ 24,COL()+2 PROMPT'Confirmar'
         @ 24,COL()+3 PROMPT'Modificar'
         @ 24,COL()+3 PROMPT'Abandonar'
         MENU TO SAIC
         CMPR_OLD=NUMEXCOMPR
         @ 24,11 CLEA TO 24,78
         DO CASE
         CASE SAIC=0.OR.SAIC=2
            EXIT
         CASE SAIC=1
            SETCOLOR(__COR(21))
            PGA="S"
            SET CONFIRM ON
            KEYIN(11,14,'Pagamento na Sa¡da ou na Devolu‡„o ? (S/D):',@PGA,'!','PGA$"SD"',__COR(1))
            SET CONFIRM OFF
            IF LASTKEY()=27
               EXIT
            ENDIF   
            IF PGA="S"
               PAGOUX=.T.
            ENDIF   
            FOR TF = 1 TO CITF
                NUMEXFITA1=NUMEFITA[ITF[TF]]
                VALOXFITA1=VALOFITA[ITF[TF]]
                APPEND BLANK
                VTOA()
                SELE C
                SET ORDER TO 2
                SEEK LEFT(NUMEXFITA1,2)+RIGHT(NUMEXFITA1,4)
                IF MONTH(DATE())=MONTH(C->SAIDA_FITA).AND.YEAR(DATE())=YEAR(C->SAIDA_FITA)
                   REPLACE C->NUMER_SAID WITH C->NUMER_SAID+1
                ELSE
                   REPLACE C->NUMER_SAID WITH 1
                ENDIF
                REPLACE C->SAIDA_FITA WITH DATE()
                REPLACE C->COPIA_FORA WITH C->COPIA_FORA+1
                SELE E 
                SEEK ZIPS(B->NUME_SOCIO)+ZIPF(NUMEXFITA1)
                IF ! FOUND()
                   APPEND BLANK
                   REPLACE E->NUME_SOCIO WITH ZIPS(B->NUME_SOCIO)
                   REPLACE E->CODI_FITA  WITH ZIPF(NUMEXFITA1)
                   REPLACE E->DATA_ALUG  WITH DTOZ(DATE())
                ENDIF
                SELE A
            NEXT
            SELE B
            SET ORDER TO 2
            IF MONTH(DATE())=MONTH(B->ULTIM_ALUG).AND.YEAR(DATE())=YEAR(C->SAIDA_FITA)
               REPLACE B->NUME_FITAS WITH B->NUME_FITAS+CITF
            ELSE
               REPLACE B->NUME_FITAS WITH CITF
            ENDIF
            REPLACE B->ULTIM_ALUG WITH DATE()
            SELE A
            COMMIT
            IF MSG("Prepare a Impressora e aperte uma tecla para iniciar...",.t.,__cor(1))#27.AND.TESTA_IMP(__COR(24))
               IMP_COMP()
            ENDIF
            BTOV()
            NUMEXCOMPR=CMPR_OLD+1
            LACO=.F.
         CASE SAIC=3
            BTOV()
            NUMEXCOMPR=CMPR_OLD
            LACO=.F.
         ENDCASE
        ENDDO    
       ENDDO 
      ENDDO 
     ENDDO 
    ENDDO 
   ENDDO  
  ENDDO
IF LASTKEY()=27
   EXIT
ENDIF
ENDDO
CLOSE DATA
RESTSCREEN(1,0,24,79,TELA)
SETCOLOR(COR)
SET KEY 18 TO
SET KEY 3  TO
SET KEY -3 TO
SET CONFIRM ON
RETURN
*****************
FUNCTION IMP_COMP
*****************
PRIVATE X,LN
RESTORE FROM CAM3.CFG ADDITIVE
SET DEVICE TO PRINT
SETPRC(0,0)
LN=1
FOR X = 1 TO CF_VC
   @LN   ,0  SAY REPL("=",80)
   @LN+01,0  SAY REPL("*",23)+" COMPROVANTE DE RETIRADA DE FITAS "+REPL("*",23)
   @LN+02,0  SAY REPL("=",80)
   @LN+03,0  SAY CI("LN")+IAC(CF_NL)+CI("DN")+SPACE(33)+"No..:    "+STRZERO(NUMEXCOMPR,5)
   @LN+04,0  SAY IAC(CF_EN)
   @LN+05,0  SAY "CEP: "+CF_CE+" - FONE: "+CF_TL+"  C.P.F....: "+CF_CP
   @LN+05,66 SAY "DATA: "+DTOC(DATE())
   @LN+06,0  SAY IAC(ALLTRIM(CF_CI))+"-"+CF_UF
   @LN+06,35 SAY "INSC.EST.: "+CF_IE
   @LN+06,66 SAY "HORA: "+TIME()
   @LN+07,0  SAY REPL("=",80)
   @LN+08,0  SAY "DADOS DO S"+_ACIMP[OMAAG]+"CIO:  No.: "+;
                  CI("LN")+STRZERO(B->NUME_SOCIO,5)+CI("DN")
   @LN+08,30 SAY "-  Nome: "+IAC(B->NOME_SOCIO)
   @LN+08,30 SAY "         "+IAC(B->NOME_SOCIO)
   @LN+09,0  SAY IAC("Data Sa¡da: ")+CI("LN")+DTOC(DATAXSAIDA)+CI("DN")+;
                 "   -    Devolu"+_ACIMP[CMICE]+_ACIMP[AMITI]+"o: "+;
                 CI("LN")+DTOC(DATAXPREVI)+CI("DN")
   @LN+10,0  SAY REPL("-",80)
   @LN+11,0  SAY "C"+_ACIMP[OMAAG]+"DIGO        T"+_ACIMP[IMAAG]+"TULO      "+;
                 "                                             VALOR CR$"
   @LN+12,0  SAY REPL("-",80)
   SET ORDER TO 1
   GO TOP
   SEEK NUMEXCOMPR
   SET ORDER TO 0
   STORE 0 TO CF,STOTAL
   LN=LN+13
   DO WHILE A->NUME_COMPR=CMPR_OLD.AND.!EOF()
      ATOV()
      @ LN+CF, 0 SAY NUMEXFITA1 PICT"@! AA-9999"
      SELE C
      SEEK LEFT(NUMEXFITA1,2)+RIGHT(NUMEXFITA1,4)
      @ LN+CF,14 SAY IAC(C->TITUL_FITA)
      @ LN+CF,70 SAY VALOXFITA1 PICT"@E 999,999.99"
      SELE A
      SKIP
      CF=CF+1
   ENDDO
   LN=LN+10
   SET ORDER TO 1
   @ LN  ,0  SAY REPL("-",80)  
   @ LN+1,55 SAY "VALOR TOTAL..: "
   @ LN+1,70 SAY TOTAL PICT"@E 999,999.99"
   @ LN+2,00 SAY REPL("_",27)
   @ LN+2,55 SAY "VALOR PAGO...: "
   @ LN+2,70 SAY IF(PAGOUX,TOTAL,0) PICT"@E 999,999.99"
   @ LN+3,04 SAY "ASSINATURA DO S"+_ACIMP[OMAAG]+"CIO"
   @ LN+3,55 SAY "VALOR A PAGAR: "
   @ LN+3,70 SAY IF(PAGOUX,0,TOTAL) PICT"@E 999,999.99"
   @ LN+4,0  SAY REPL("-",80)  
   @ LN+5,CENTRA(CF_MC) SAY IAC(CF_MC)
   @ LN+6,0  SAY REPL("-",80)  
   @ LN+8,0  SAY ""
   LN=LN+10
   IF PAR(X)
      LN=1
   ENDIF
NEXT
IF PAR(CF_VC)
   EJECT
ENDIF
SET DEVICE TO SCREEN
RETURN(.T.)
************************************************************************
*********** FUNCOES DE VALIDACAO DOS DADOS DOS COMPROVANTES ************
************************************************************************
****************
FUNCTION C_COMPR
****************
PARAM NC

CORF=SETCOLOR()

IF EMPTY(NC)
   SETCOLOR(__COR(14))
   @ 24,11
   @ 24,11 SAY " N£mero de Comprovante n„o pode ser Zero ."
   SETCOLOR(CORF)
   TONE(300,3)
   RETURN(.F.)
ENDIF   
   
SEEK NC
IF ! FOUND()
   SELE A
   SETCOLOR(__COR(14))
   @ 24,11
   SETCOLOR(CORF)
   RETURN(.T.)
ELSE
   SELE A
   SETCOLOR(__COR(14))
   @ 24,11
   @ 24,11 SAY " N£mero de Comprovante j  existente no Cadastro ."
   SETCOLOR(CORF)
   TONE(300,3)
   RETURN(.F.)
ENDIF   
*****************
FUNCTION C_NUMSOC
*****************
PARAM NS
SELE B
CORF=SETCOLOR()
SEEK NS
IF FOUND()
   SELE A
   @  4, 44  SAY  B->NOME_SOCIO
   SETCOLOR(__COR(14))
   @ 24,11
   SETCOLOR(CORF)
   RETURN(.T.)
ELSE
   SELE A
   @  4, 44  SAY  SPACE(33)
   SETCOLOR(__COR(14))
   @ 24,11
   @ 24,11 SAY " C¢digo de S¢cio n„o cadastrado !!"
   SETCOLOR(CORF)
   TONE(300,3)
   RETURN(.F.)
ENDIF   
***************
FUNCTION C_DIAS
***************
PARAM QTD,FORMA

CORF=SETCOLOR()

IF EMPTY(QTD)
   SETCOLOR(__COR(14))
   @ 24,11
   @ 24,11 SAY " Quantidade de Dias n„o pode ser Zero ."
   SETCOLOR(CORF)
   TONE(300,3)
   RETURN(.F.)
ENDIF   
IF FORMA=2.AND.IMPAR(QTD)
   SETCOLOR(__COR(14))
   @ 24,11
   @ 24,11 SAY " Quantidade de Dias para forma de pagmto. 48 HORAS deve ser PAR."
   SETCOLOR(CORF)
   TONE(300,3)
   RETURN(.F.)
ENDIF
SETCOLOR(__COR(14))
@ 24,11
SETCOLOR(CORF)
RETURN(.T.)
*****************
FUNCTION C_NUMFIT
*****************
PARAM NF
PRIVATE LINHA,CORF,CFM
LINHA=ROW()
CORF=SETCOLOR()
IF ! EMPTY(NF).AND.NF#"  -    "
   SELE C
   SET ORDER TO 2
   SEEK LEFT(NF,2)+RIGHT(NF,4)
   IF FOUND()
     SELE A
     FOR IG = 1 TO LINHA-10
         IF NUMEFITA[IG]=NUMEFITA[LINHA-9]
           @ ROW(), 20  SAY  C->TITUL_FITA
           TONE(300,3)
           SETCOLOR(__COR(14))
           @ 24,11
           @ 24,11 SAY " C¢digo de Fita repetido no mesmo Comprovante."
           SETCOLOR(CORF)
           RETURN(.F.)
         ENDIF  
     NEXT    
     IF C->NUM_COPIAS-C->COPIA_FORA#0
       SELE E
       SEEK ZIPS(NUMEXSOCIO)+ZIPF(NF)
       CFM="Aten‡„o! T¡tulo j  alugado em "+dtoc(ztod(E->data_alug))+", Confirma ? "
       IF IF(FOUND(),CONFIRMA(CFM,__cor(1)),.T.)
          SELE A
          @ LINHA, 20  SAY  C->TITUL_FITA
          SETCOLOR(__COR(14))
          @ 24,11
          SETCOLOR(CORF)
          IF FORMXPAGAM#5
             SELE D
             CAMPO=FIELDNAME(FORMXPAGAM+2) 
             IF FORMXPAGAM=2.OR.FORMXPAGAM=3
                Q_D=QTDEXDIAS/2
             ELSE
                Q_D=QTDEXDIAS
             ENDIF      
             VALOFITA[LINHA-9]=&CAMPO * Q_D
             @ LINHA,65 SAY VALOFITA[LINHA-9] PICTURE "@E 999,999.99"
             SELE A
          ENDIF
          RETURN(.T.)
       ELSE
          SELE A
          SETCOLOR(__COR(14))
          @ 24,11
          SETCOLOR(CORF)
          RETURN(.F.)
       ENDIF
     ELSE
       @ LINHA,20  SAY  C->TITUL_FITA
       TONE(300,3)
       SETCOLOR(__COR(14))
       @ 24,11
       @ 24,11 SAY " N„o existem mais copias dispon¡veis desta fita."
       SETCOLOR(CORF)
       RETURN(.F.)
     ENDIF  
  ELSE
     SELE A
     @ LINHA, 20  SAY  SPACE(40)
     TONE(300,3)
     SETCOLOR(__COR(14))
     @ 24,11
     @ 24,11 SAY " C¢digo de Fita n„o cadastrado !!"
     SETCOLOR(CORF)
     RETURN(.F.)
  ENDIF   
ELSE
  VALOFITA[LINHA-9]=0
  @ LINHA, 20  SAY  SPACE(40)
  @ LINHA, 65  SAY VALOFITA[LINHA-9] PICTURE "@E 999,999.99"
  SETCOLOR(__COR(14))
  @ 24,11
  SETCOLOR(CORF)
  RETURN(.T.)
ENDIF  
**************
FUNC INCR_DATA
**************
PARAM DATA,DIAS

DATA=DATA+DIAS
IF DOW(DATA)=1
   DATA=DATA+1
ENDIF
RETURN (DATA)

************
FUNCTION F_P
************
PARA MOD,ELM,POS
OPFP=ELM

IF MOD=1
   KEYB CHR(30)
ELSEIF MOD=2
   KEYB CHR(31)
ELSEIF MOD=3
   UT=LASTKEY()
   DO CASE
   CASE UT=19
        RETU (2)
   CASE UT=4
        RETU (2)
   CASE UT=27
        RETU (0)
   CASE UT=13
        RETU (1)
   ENDCASE

    RETURN (3)
ENDI
RETU (2)
******************************>> FIM DO ARQUIVO <<*****************************
