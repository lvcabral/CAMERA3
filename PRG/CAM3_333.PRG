******************************************************************************
* SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS              * 
* VERSAO    : 1.1 - Copyright 1992                                           * 
* PROGRAMA  : CAM3_333.PRG                                                   *
* DESCRI€AO : Programa que gera um grafico estatistico de saida por fita.    *
* AUTOR     : Marcelo Leal Limaverde Cabral                                  *
* DATA      : 18/06/92                                                       * 
******************************************************************************
#include "cam3.ch"
PRIVATE COLU[9],CORES[9],TITU[9],GRAF,T,MAX,DAT,MES,TELA,TG

SAVE SCRE TO TELA

GRAF=.T.
CREG=0

SETCOLOR(__COR(23))   
EXPLODE(0,0,24,79)
PAGINA=1
IF CFC="C"
   CORES[1]='Bg+'
   CORES[2]='R+'
   CORES[3]='B+'
   CORES[4]='G+'
   CORES[5]='GR+'
   CORES[6]='GR'
   CORES[7]='RB+'
   CORES[9]='W+'
ELSE
   CORES[1]='W+'
   CORES[2]='W'
   CORES[3]='W+'
   CORES[4]='W'
   CORES[5]='W+'
   CORES[6]='W'
   CORES[7]='W+'
   CORES[8]='W'
   CORES[9]='W+'
ENDIF
MES=MONTH(DATE())
DAT=DATE()
DO WHILE MONTH(DAT) = MES
   DAT = DAT + 1
ENDDO
DAT=DAT-1
MAX=DAY(DAT)
SELE A
USE FITAS
SET INDEX TO FITAS03
GO TOP
FOR T = 1 TO 9
    IF ! EOF()
       COLU[T] = ROUND(A->NUMER_SAID/A->NUM_COPIAS,0)
       TITU[T] = A->CODIGO_G+"-"+A->NUMER_FITA
       SKIP 1
    ELSE
       COLU[T] = 0
       TITU[T] = SPACE(7)
    ENDIF      
NEXT    
DO WHIL GRAF
  tg="GR"+chr(_ACTEL[AMAAG])+"FICO ESTAT"+chr(_ACTEL[IMAAG])+"STICO DE SA"+chr(_ACTEL[IMAAG]);
         +"DAS POR T"+chr(_ACTEL[IMAAG])+"TULO"
  GRAF=GRAPH(tg,09,8,0,MAX,COLU,TITU,CORES)
ENDDO 
REST SCRE FROM TELA
CLOSE DATA
RETURN 

******************************************************************************
* FUN€AO GRAPH
* PARAMETROS PASSADOS : 
* TITULO    --> TITULO
* NO_COL    --> NUMERO DE COLUNAS NO GRAFICO
* LARG_COL  --> LARGURA DE CADA BARRA NO GRAFICO
* LR        --> MENOR VALOR DO EIXO-Y
* HR        --> MAIOR VALOR DO EIXO-Y
* COL       --> VETOR CONTENDO OS VALORES DOS ITENS DO GRAFICO.
* TITULOS   --> VETOR CONTENDO OS TITULOS CORRESPONDENTES AOS VALORES
* COR       --> VETOR CONTENDO AS CORES DAS BARRAS DO GRAFICO
******************************************************************************
FUNCTION GRAPH
PARAMETERS TITULO,NO_COL,LARG_COL,LR,HR,COL,TITULOS,COR

TWIDTH  = LARG_COL-1
BLINE   = SPAC(6)

FOR SUB = 1 TO NO_COL
    
    TITULOS[SUB] = SUBS(TITULOS[SUB],1,TWIDTH)+SPAC(TWIDTH-LEN(TITULOS[SUB]))
    BLINE       = BLINE+TITULOS[SUB]+SPAC(1)
    
NEXT

MESANO=MES(DATE())+SUBS(DTOC(DATE()),6)

TITULO = MESANO+SPAC((77- (LEN(TRIM(TITULO))+LEN(MESANO) ) )/2)+TITULO

XCHAR = CHR(196)
YCHAR = CHR(179)
BCHAR = CHR(219)

LINE  = SPAC(1)+YCHAR
XLINE = " Á"+REPL(XCHAR,NO_COL*LARG_COL)
BAR   = " " +REPL(BCHAR,LARG_COL-1)

@ 1,7 CLEA TO 21,79
@ 00,00 SAY TITULO
@ 00,69 SAY 'PAG.: '+STR(PAGINA,4)
?
BCOUNT  = 0
CNTR    = 1

FOR CNTR = 1 TO 20
    LEFT = SPAC(5)+LINE
    IF (((CNTR-1)/4=INT((CNTR-1)/4)).OR.CNTR=1).AND.CNTR<20
        LEFT = STR(HR-((BCOUNT/5)*HR),5)+SPAC(1)+CHR(180)
        BCOUNT = BCOUNT + 1
    ENDIF 
    ? LEFT 
NEXT

? STR(LR,5)+XLINE
? '  '+BLINE
COLPOS = 7
DIV    = (HR-LR)/10
CORF=SETCOLOR()
FOR OLOOP = 1 TO NO_COL
    IF TYPE("COR[OLOOP]") = "U"
       CORG = CORF
    ELSE
       CORG = COR[OLOOP]
    ENDIF   
    @ 23,COLPOS SAY " "
    VALOR  = 2* COL[OLOOP]/DIV
    ROW   = 21
    SETCOLOR( CORG )
    DO WHIL VALOR > 0
        @ ROW,COLPOS SAY BAR
        ROW = ROW - 1
        VALOR = VALOR - 1
    ENDDO
    IF TITULOS[OLOOP]#SPACE(7)
       @ ROW,COLPOS+3 SAY STR(COL[OLOOP],2)
    ENDIF   
    COLPOS = COLPOS + LARG_COL
NEXT 
SETCOLOR(__COR(14))

@ 24,0 SAY '  [ESC] SAI  º '+CHR(24)+CHR(25)+' MUDAM A PAGINA '+;
'º [ALT-P] IMPRIME A PAGINA º [ALT-T]  TEXTO   '
SETCOLOR(CORF)
DO WHIL INKEY(0)#281
    IF LASTKEY()==27
        RETU (.F.) 
    ELSEIF LASTKEY()==276
        SAVE SCRE TO TELA2
        CLEA 
        @ 12,35 SAY 'TEXTO'
        INKE(3)
        REST SCRE FROM TELA2
    ELSEIF LASTKEY()==5     &&=======> seta para cima
        IF EOF()
           LOOP
        ENDIF
        PAGINA=PAGINA+1
        CREG=0
        FOR T = 1 TO 9
            IF ! EOF()
               COLU[T] = ROUND(A->NUMER_SAID/A->NUM_COPIAS,0)
               TITU[T] = A->CODIGO_G+"-"+A->NUMER_FITA
               CREG=CREG+1
               SKIP 1
            ELSE
               COLU[T] = 0
               TITU[T] = SPACE(7)
            ENDIF      
        NEXT    
        RETU (.T.)
    ELSEIF LASTKEY()==24     &&=======> seta para baixo
        IF PAGINA=1
           LOOP
        ENDIF
        PAGINA=PAGINA-1
        SKIP -(9+CREG)
        CREG=0
        FOR T = 1 TO 9
            IF ! EOF()
               COLU[T] = ROUND(A->NUMER_SAID/A->NUM_COPIAS,0)
               TITU[T] = A->CODIGO_G+"-"+A->NUMER_FITA
               CREG=CREG+1
               SKIP 1
            ELSE
               COLU[T] = 0
               TITU[T] = SPACE(7)
            ENDIF      
        NEXT    
        RETU (.T.)
    ENDI 
ENDD 
IF TESTA_IMP(__COR(24))
   XCHAR = CHR(45)
   YCHAR = CHR(124)
   BCHAR = CHR(35)

   XLINE  = REPL(XCHAR,(NO_COL*LARG_COL)-1)
   BAR    = REPL(BCHAR,LARG_COL-1)
   BLANKS = SPAC(LARG_COL-1)
   TOPO   = SPAC(LARG_COL/2-1)
   
   SET DEVICE TO PRINT
   SET PRIN ON 
   SET CONS OFF 

   ? IAC(TITULO)+SPAC(7)+'PAG.: '+STR(PAGINA,4)
   ?

   LCOUNT = 1
   BCOUNT = 0
   
   DO WHIL LCOUNT < 21
      GLINE     = SPAC(5)+YCHAR
      IF (((LCOUNT-1)/4=INT((LCOUNT-1)/4)).OR.LCOUNT=1).AND.LCOUNT<20
         GLINE  = STR(HR-((BCOUNT/5)*HR),5)+YCHAR
         BCOUNT = BCOUNT + 1
      ENDI 
    
      FOR CCT = 1 TO NO_COL
        IF LCOUNT = INT(20-(2*(COL[CCT]/DIV))).AND.TITULOS[CCT]#SPACE(7)
           GLINE = GLINE+TOPO+STR(COL[CCT],2)+TOPO
        ELSEIF LCOUNT > ( 20 - ( 2 * ( COL[CCT]/DIV )))
           GLINE = GLINE+BAR+" "
        ELSE
           GLINE = GLINE+BLANKS+" "
        ENDIF   
      NEXT
    
      ? GLINE
      LCOUNT = LCOUNT + 1
   ENDD 
   ? STR(LR,5)+' '+XLINE
   ? BLINE
   EJECT
   SET PRINT  OFF 
   SET CONSOLE ON 
   SET DEVICE TO SCREEN
ENDIF   
RETURN(.T.)

******************************>> FIM DO ARQUIVO <<*****************************
