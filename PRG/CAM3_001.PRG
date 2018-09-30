*ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
*º SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS          º 
*º VERSAO    : 1.1 - Copyright 1992                                       º 
*º PROGRAMA  : CAM3_001.PRG                                               º 
*º DESCRI€ŽO : Arquivo de Procedures e Functions do Sistema               º 
*º AUTOR     : Marcelo Leal Limaverde Cabral                              º 
*º DATA      : 08/09/92                                                   º
*ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
****************
PROCEDURE POPCAL
****************
PRIVA CURS,LINH,COLU
LINH=ROW()
COLU=COL()
CURS=SETCURSOR()
SETCURSOR(0)
CALENDARIO(6,28,DATE(),__COR(19))
SETCURSOR(CURS)
@ LINH,COLU SAY ""
RETURN

****************
PROCEDURE CALPOP
****************
PRIVA CURS,LINH,COLU
LINH=ROW()
COLU=COL()
CURS=SETCURSOR()
SETCURSOR(0)
CALCULA(@calcl,@calcc,__COR(20))
SETCURSOR(CURS)
@ LINH,COLU SAY ""
RETURN
************
PROC CAIXOUT
************
PARAM L1,C1,L2,C2

DO WHIL C1>1
    @ L1,C1 CLEA TO L2,C2 
    @ L1,C1 TO L2,C2 DOUBLE
    INKEY(.01)
    C1=C1-2
    C2=C2+2
ENDD 

@ L1,C1-1 CLEA TO L2,C2+1
@ L1,C1-1 TO L2,C2+1 DOUBLE

DO WHIL L1>3
    @ L1,C1-1 CLEA TO L2,C2+1
    @ L1,C1-1 TO L2,C2+1 DOUBLE
    INKEY(.01)
    L1=L1-1
    L2=L2+1
ENDD 
RETURN 
*************
PROC LOOK_FOR
*************
PARAM PRG,LIN,VAR

IF PRG="LOOK_FOR".OR.PRG="LF_UDF".OR.PRG="DBEDIT".OR.PRG="MEMOEDIT"
   RETURN
ENDIF

PRIVATE LF_COR,LF_TELA,LF_TOP,NIVEL

NIVEL=NIVHLP
NIVHLP=900

DO CASE
CASE VAR="NUMEXSOCIO".OR.VAR="NUMERSOCIO".OR.VAR="NOMERSOCIO"
     SET CURSOR OFF
     SET KEY 18 TO
     SET KEY  3 TO
     PRIVATE LF_CMP[2+cf_nd],LF_TIT[2+cf_nd]
     LF_COR=SETCOLOR()
     LF_TELA=SAVESCREEN(6,17,22,65)
     IF VAR="NUMEXSOCIO"
        SELE B
     ENDIF   
     SET ORDER TO 1
     GO TOP
     LF_CMP[1]="STRZERO(NUME_SOCIO,5)"
     LF_TIT[1]="N§"
     LF_CMP[2]="NOME_SOCIO"
     LF_TIT[2]="NOME"
     LF_CMP[3]="DEP1_SOCIO"
     LF_TIT[3]="DEPENDENTE 1"
     IF CF_ND >= 2
        LF_CMP[4]="DEP2_SOCIO"
        LF_TIT[4]="DEPENDENTE 2"
     ENDIF
     IF CF_ND >= 3
        LF_CMP[5]="DEP3_SOCIO"
        LF_TIT[5]="DEPENDENTE 3"
     ENDIF
     IF CF_ND = 4
        LF_CMP[6]="DEP4_SOCIO"
        LF_TIT[6]="DEPENDENTE 4"
     ENDIF
     LF_TOP="SOCIOS"
     SETCOLOR(__COR(21))
     @ 6,17 CLEAR TO 22,63
     @ 6,17 TO 22,63 DOUBLE
     SETCOLOR(__COR(1))
     @  7,18 SAY "         SOCIOS POR ORDEM ALFABTICA         "
     @ 21,18 SAY "             [F6] - MUDA A ORDEM             "
     SETCOLOR(__COR(21))
     DBEDIT(8,18,20,62,LF_CMP,"LF_UDF","@!",LF_TIT)
     IF LASTKEY()=13
        IF VAR="NOMERSOCIO"
           KEYB NOME_SOCIO
        ELSE
           KEYB STRZERO(NUME_SOCIO,5)
        ENDIF   
     ENDIF 
     RESTSCREEN(6,17,22,65,LF_TELA)
     SETCOLOR(LF_COR)
     SET ORDER TO 2
     SELE A
     SET CURSOR ON
     SET KEY 18 TO NULO
     SET KEY  3 TO NULO
     NIVHLP=NIVEL
     RETURN
CASE VAR="NUMEFITA".OR.VAR="TITULXFITA".OR.VAR="CODIG_FITA"
     SET CURSOR OFF
     SET KEY 18 TO
     SET KEY  3 TO
     PRIVATE LF_CMP[2],LF_TIT[2]
     LF_COR=SETCOLOR()
     LF_TELA=SAVESCREEN(6,13,22,69)
     IF VAR="NUMEFITA"
        SELE C
     ENDIF   
     SET ORDER TO 1
     GO TOP
     LF_CMP[1]="CODIGO_G+CHR(45)+NUMER_FITA"
     LF_CMP[2]="TITUL_FITA"
     LF_TIT[1]="COD."
     LF_TIT[2]="TITULO"
     LF_TOP=" FITAS"
     SETCOLOR(__COR(21))
     @ 6,13 CLEAR TO 22,67
     @ 6,13 TO 22,67 DOUBLE
     SETCOLOR(__COR(1))
     @  7,14 SAY "              FITAS POR ORDEM ALFABTICA             "
     @ 21,14 SAY "                 [F6] - MUDA A ORDEM                 "
     SETCOLOR(__COR(21))
     DBEDIT(8,14,20,66,LF_CMP,"LF_UDF","@!",LF_TIT)
     IF LASTKEY()=13
        IF VAR='TITULXFITA'
           KEYB TITUL_FITA
        ELSE   
           KEYB CODIGO_G+NUMER_FITA
        ENDIF   
     ENDIF 
     RESTSCREEN(6,13,22,69,LF_TELA)
     SETCOLOR(LF_COR)
     SET ORDER TO 2
     SELE A
     SET CURSOR ON
     SET KEY 18 TO NULO
     SET KEY  3 TO NULO
     NIVHLP=NIVEL
     RETURN
OTHER
     NIVHLP=NIVEL
     RETURN
ENDCASE
***********
FUNC LF_UDF
***********
PARAM MODO,NUM
DO CASE
CASE MODO=3
 RETURN(0)
CASE MODO=4
 IF LF_TOP="SOCIOS"
    _S=.T.
 ELSE
    _S=.F.
 ENDIF
 DO CASE
 CASE LASTKEY()=13 .OR. LASTKEY()=27
     RETURN(0)
 CASE LASTKEY()=-5
   IF INDEXORD()=1
     SET ORDER TO 2
     SETCOLOR(__COR(1))
     @  7,IF(_S,18,14) SAY IF(_S,SPACE(10),SPACE(14))+LF_TOP+" POR ORDEM NUMRICA"+;
                           IF(_S,SPACE(10),SPACE(14))
     SETCOLOR(__COR(21))
   ELSE
     SET ORDER TO 1
     SETCOLOR(__COR(1))
     @ 7,IF(_S,18,14) SAY IF(_S,SPACE(9),SPACE(13))+LF_TOP+" POR ORDEM ALFABTICA"+;
                          IF(_S,SPACE(9),SPACE(13))
     SETCOLOR(__COR(21))
   ENDIF
   RETURN(2)
 CASE UPPER(CHR(LASTKEY()))$"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
   IF INDEXORD()=1
      REG=RECNO()
      SEEK UPPER(CHR(LASTKEY()))
      IF ! FOUND()
         GO REG
      ENDIF
      RETURN(2)
   ENDIF   
 ENDCASE
ENDCASE
RETURN(1)      
**************
FUNCTION REL10
**************
PARAMETERS CAB1,CAB2,aCamp,aTits,aColc,aColt,nVias,lTot
PRIVATE PAG,V,CNT,T,DETALHE
RESTORE FROM CAM3.CFG ADDITIVE
SET PRINT ON
SET CONSOLE OFF
SET DEVICE TO PRINT
CAB1=ALLTRIM(CAB1)
CAB1=SPACE(CENTRA(CAB1,50))+CAB1
CAB1=CAB1+SPACE(50-LEN(CAB1))
CAB2=ALLTRIM(CAB2)
CAB2=SPACE(CENTRA(CAB2,50))+CAB2
CAB2=CAB2+SPACE(50-LEN(CAB2))
FOR V = 1 TO NVIAS
      GO TOP
      PAG=0
      CNT=0      
      DO WHILE .NOT. EOF()

         IF PAG=0 .OR. PROW()>60
            IF PAG=0
               SETPRC(0,0)
            ELSE
               @ PROW()+1,0 SAY REPL("-",80)   
            ENDIF   
            PAG=PAG+1
            @ 0, 0 SAY REPL("-",80)
            @ 1, 0 SAY IAC(CF_M1+CAB1+"PAG. :      "+STR(PAG,3))
            @ 2, 0 SAY IAC(CF_M2+CAB2+"DATA : "+DTOC(DATE()))
            @ 3, 0 SAY REPL("-",80)
            FOR T = 1 TO LEN(aTits)
                @ 4, aColt[T] SAY IAC(aTits[T])
            NEXT
            @ 5, 0 SAY REPL("-",80)
         ENDIF   
         @ PROW()+1, 0 SAY ""
         FOR T = 1 TO LEN(aCamp)
             DETALHE=aCamp[T]
             IF TYPE(DETALHE)="C"
                @ PROW(),aColc[T] SAY IAC(&DETALHE)
             ELSE
                @ PROW(),aColc[T] SAY &DETALHE
             ENDIF   
         NEXT
         IF ! PAUSA(__cor(24))
            SET PRINT OFF
            SET CONSOLE ON
            SET DEVICE TO SCREEN
            RETURN (.T.)
         ENDIF  
         CNT=CNT+1
         SKIP
      ENDDO
      @ PROW()+1,0 SAY REPL("-",80)   
      IF lTot
         @ PROW()+1,0 SAY "TOTAL DE REGISTROS IMPRESSOS -----> "+STR(CNT,4)
         @ PROW()+1,0 SAY REPL("-",80)   
      ENDIF   
      EJECT
NEXT      
SET PRINT OFF
SET CONSOLE ON
SET DEVICE TO SCREEN
RETURN (.T.)
******************
FUNCTION MENURELAT
******************
PRIVATE TIPO
COR_TELA(07,04,12,28,__COR(9))
SETCOLOR(__COR(24))
SCROLL(06,02,11,26,0)
JANELA(06,2,11,26)
@ 07,04 PROMPT "1. Cat logo Simples  "
@ 08,04 PROMPT "2. Cat logo Detalhado"
@ 09,04 PROMPT "3. Ficha(s) Cadastro "
@ 10,04 PROMPT "4. Etiquetas         "
MENU TO TIPO
RETURN(TIPO)
******************
FUNCTION MENUSELEC
******************
COR_TELA(07,32,12,78,"W/N")
SCROLL(06,30,11,76,0)
JANELA(06,30,11,76)
@ 07,32 PROMPT "A. Selecionando por... >"
@ 07,57 SAY SEL1[NSEL]
@ 08,32 PROMPT "B. Organizando  por... >"
@ 08,57 SAY ORG1[NORG]
@ 09,32 PROMPT "C. N£mero de Vias ...  >"
@ 09,57 SAY STR(NVIAS,1)+"              "
@ 10,32 PROMPT "D. Iniciar o Processamento ..."
MENU TO CONF
DO CASE
   CASE CONF=0
        RESTSCREEN(06,30,12,78,TELA1)
        RETURN(CONF)
   CASE CONF=1
        TELA2=SAVESCREEN(06,57,7+LEN(SEL1),77)
        SCROLL(06,57,7+LEN(SEL1),77,0)
        JANELA(06,57,7+LEN(SEL1),77)
        @ 6+NSEL,59 SAY CHR(251)
        NSEL1=ACHOICE(07,61,6+LEN(SEL1),75,SEL1,SEL2)
        IF LASTKEY()=13
           NSEL=NSEL1
        ENDIF   
        RESTSCREEN(06,57,7+LEN(SEL1),77,TELA2)
   CASE CONF=2
        TELA2=SAVESCREEN(07,57,10,77)
        SCROLL(07,57,10,77,0)
        JANELA(07,57,10,77)
        @ 07+NORG,59 SAY CHR(251)
        NORG1=ACHOICE(08,61,09,75,ORG1)
        IF LASTKEY()=13
           NORG=NORG1
        ENDIF   
        RESTSCREEN(07,57,10,77,TELA2)
   CASE CONF=3
        @ 9,57 GET NVIAS PICT "9" VALID (NVIAS>0)
        SET CURSOR ON
        READ
        SET CURSOR OFF
ENDCASE
RETURN(1)
*************
FUNC TELACOMP
*************
  PARAM DIF
  @  4-DIF,  3  SAY "N§"+SPACE(5)
  @  4-DIF, 16  SAY "Cod. do S¢cio:"+SPACE(7)
  @  4-DIF, 38  SAY "Nome: "+SPACE(33)
  @  6-DIF,  3  SAY "Forma Pagto.: "+SPACE(8)
  @  6-DIF, 27  SAY "Sa¡da:"+SPACE(9)
  @  6-DIF, 44  SAY "Qtd. Dias:"+SPACE(3)
  @  6-DIF, 59  SAY "Devolu‡„o:"+SPACE(9)
  @  8-DIF,  8  SAY "C¢digo"
  @  8-DIF, 20  SAY "T¡tulo da Fita"
  @  8-DIF, 66  SAY "Valor Cr$"
  @ 10-DIF,  4  SAY "1 -"+SPACE(71)
  @ 11-DIF,  4  SAY "2 -"+SPACE(71)
  @ 12-DIF,  4  SAY "3 -"+SPACE(71)
  @ 13-DIF,  4  SAY "4 -"+SPACE(71)
  @ 14-DIF,  4  SAY "5 -"+SPACE(71)
  @ 15-DIF,  4  SAY "6 -"+SPACE(71)
  @ 16-DIF,  4  SAY "7 -"+SPACE(71)
  @ 17-DIF,  4  SAY "8 -"+SPACE(71)
  @ 18-DIF,  4  SAY "9 -"+SPACE(71)
  @ 19-DIF,  3  SAY "10 -"+SPACE(71)
  @ 20-DIF,  1  TO 20-DIF, 78  
  @ 10-DIF, 17  TO 19-DIF, 17
  @  9-DIF, 17  SAY CHR(194)
  @ 20-DIF, 17  SAY CHR(193)
  @ 10-DIF, 62  TO 19-DIF, 62
  @  9-DIF, 62  SAY CHR(194)
  @ 20-DIF, 62  SAY CHR(193)
  RETURN .T.
**********
Func  ZIPS
**********
PARAM NS
NS=STRZERO(NS,6)
RETURN(CHR(VAL(LEFT(NS,2)))+CHR(VAL(SUBSTR(NS,3,2)))+CHR(VAL(RIGHT(NS,2))))
***********
Func UnZIPS
***********
PARAM NS
RETURN RIGHT(STRZERO(ASC(LEFT(NS,1)),2)+STRZERO(ASC(SUBSTR(NS,2,1)),2)+STRZERO(ASC(RIGHT(NS,1)),2),5)
**********
Func  ZIPF
**********
PARAM NF
RETURN(LEFT(NF,2)+CHR(VAL(SUBSTR(NF,4,2)))+CHR(VAL(RIGHT(NF,2))))
***********
Func UnZIPF
***********
PARAM NF
RETURN(LEFT(NF,2)+STRZERO(ASC(SUBSTR(NF,3,1)),2)+STRZERO(ASC(RIGHT(NF,1)),2))
**********
PROC diano
**********
MSG("Hoje ‚ o "+LTRIM(STR(dda()))+"§ Dia do Ano.",.T.,__COR(1))
RETURN
************
PROC MEMORIA
************
MSG("TOTAL DE MEMORIA DISPONIVEL: "+LTRIM(STR(MEMORY(0)))+"Kb",.T.,__COR(1))
RETURN
