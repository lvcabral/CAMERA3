******************************************************************************
* SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS              *
* VERSAO    : 1.1 - Copyright 1992                                           *
* PROGRAMA  : CAM3.PRG                                                       *
* DESCRI─AO : Programa de Acesso ao Sistema                                  *
* AUTOR     : Marcelo Leal Limaverde Cabral                                  *
* DATA      : 04/09/92                                                       *
******************************************************************************
PARAM PB
CFING=SECONDS()
ARQHLP=""
IF ! FILE("CAM3.CFG")
  CF_MT="   MC3 VIDEO LOCADORA  "
  CF_MC=SPACE(60)
  CF_M1=SPACE(15)
  CF_M2=SPACE(15)
  STORE 0 TO CF_EL,CF_VC,CF_ND
  STORE SPACE(33) TO CF_NL,CF_EN
  STORE SPACE(06) TO CF_CE
  STORE SPACE(20) TO CF_CI
  STORE SPACE(02) TO CF_UF
  STORE SPACE(13) TO CF_TL
  STORE SPACE(18) TO CF_CP,CF_IE
  STORE '25352484B4F4' TO CF_SM &&------>MASTER
  STORE '445515648434' TO CF_SO &&------>ACESSO
  SAVE TO CAM3.CFG ALL LIKE CF_*
ELSE
  RESTORE FROM CAM3.CFG ADDITIVE
ENDIF
IF PCOUNT()=1
   PB=UPPER(PB)
   IF PB="/PB".OR.PB="-PB"
      CFC="M"
   ELSE
      CFC="C"
   ENDIF
ELSE
   CFC="C"
ENDIF
IF ! ISCOLOR()
   CFC="M"
ENDIF
SET DATE BRITISH
IF CFC="C".OR.ISCOLOR()
   MODOGRAF(IF(CFC="C",5,6))
   BLOAD("CAM3.PIC")
   INKEY(3)
   MODOGRAF(3)
ENDIF

SET CURSOR OFF
NOME=CHR(77)+CHR(65)+CHR(82)+CHR(67)+CHR(69)+CHR(76)+CHR(79)
SNOME=CHR(67)+CHR(65)+CHR(66)+CHR(82)+CHR(65)+CHR(76)
LNOME=CHR(76)+CHR(69)+CHR(65)+CHR(76)
SETCOLOR(__COR(1))
CLEAR
@ 1,0 TO 05,79
@ 1,14 SAY 'б'
@ 2,14 SAY 'Ё'
@ 3,14 SAY 'ц'
@ 4,14 SAY 'Ё'
@ 5,14 SAY 'а'
@ 1,68 SAY 'б'
@ 3,68 SAY '╢'
@ 5,68 SAY 'а'
@ 3,15 TO 3,67
@ 2,6 SAY "MC3"
@ 4,2 SAY "INFORMATICA"
@ 2,16 SAY 'ASSISTENCIA T░CNICA.............TEL: (081) 241-4705 Ё'
@ 4,16 SAY 'DESENVOLVIMENTO DE SISTEMAS.....TEL: (081) 222-0888 Ё'
@ 2,70 SAY DATE()
@ 4,70 SAY TIME()
@ 6,0 TO 24,79
SETCOLOR(__COR(2))
explode(08,2,19,77,3)
SETCOLOR(__COR(11))
@ 09,4 say'зддддддддд©  **************  Vers└o 1.1 (C)1990,1992  **************    '
@ 10,4 say'Ё зддддд© Ё здддддд©  здд© здд© зддддддд© зд©    здддддд©      иммммммм╩'
@ 11,4 say'Ё Ё     юды юдддд© Ё  Ё  юды  Ё Ё зддд© Ё Ё юдд© юдддд© Ё      хмммм╩  ╨'
@ 12,4 say'Ё Ё         здддды Ё  Ё з© з© Ё Ё юддды Ё Ё здды здддды Ё      имммм╪  ╨'
@ 13,4 say'Ё Ё     зд© Ё здд© Ё  Ё ЁюдыЁ Ё Ё зддддды Ё Ё    Ё здд© Ё      хмммм╩  ╨'
@ 14,4 say'Ё юддддды Ё Ё юдды ю© Ё Ё   Ё Ё Ё юддддд© Ё Ё    Ё юдды ю©     имммм╪  ╨'
@ 15,4 say'юддддддддды юддддддды юды   юды юддддддды юды    юддддддды     хммммммм╪'
@ 17,4 say'  ЧЧЧЧЧЧЧЧЧЧЧЧЧ  Sistema de Controle de V║deo Locadoras  ЧЧЧЧЧЧЧЧЧЧЧЧЧ  '
@ 16,4 TO 18,75 DOUBLE
NAME=CHR(77)+' '+CHR(65)+' '+CHR(82)+' '+CHR(67)+' '+CHR(69)+' '+CHR(76)+' '+CHR(79)
SNAME=CHR(67)+' '+CHR(65)+' '+CHR(66)+' '+CHR(82)+' '+CHR(65)+' '+CHR(76)
SPC=SPACE(39)
SETCOLOR(__COR(25))
@ 21,27 TO 23,53
FOR VEZES = 1 TO 3
    @ 22,29 SAY 'DIGITE A SENHA :'
    COD=SENHA(22,46)

    DO CASE
    CASE COD='433FD56464F4'
        ENTRA=.T.
        CFG=.T.
    CASE COD=CF_SM
        ENTRA=.T.
        CFG=.T.
    CASE COD=CF_SO
        ENTRA=.T.
        CFG=.F.
    OTHER
        ENTRA=.F.
    ENDCASE

    IF ENTRA

       DECLARE VD1[1],VD2[1],VD3[1],VD4[1],VD5[1]

       DO CASE
*       CASE ADIR('\DOS.SYS',VD1,VD2,VD3,VD4,VD5)=0
*           CDG="301"
*           DO PIRATA WITH CDG
       CASE ADIR('*.DBF')<7
            CDG="302"
            DO PIRATA WITH CDG
*      CASE NOMEDIR()#"C:\CAMERA3"+CHR(255)
*           CDG="303"
*           DO PIRATA WITH CDG
       OTHER
            RELEASE ALL EXCEPT CF*
            DO CAM3_000 WITH CFG,CF_MT,CFING
       ENDCASE       
    ELSE 
        @ 22,28 CLEAR TO 22,52
        @ 22,29 SAY 'SENHA INVALIDA !'
        TONE(200,2)
        @ 2,70 SAY DATE()
        @ 4,70 SAY TIME()
    ENDIF 
    IF VEZES<3
        INKEY(1)
    ENDIF 
NEXT
SET COLOR TO 
EXPLODE(0,0,24,79)
SETCOLOR(__COR(1))
JANELA(1,0,6,38)
@ 2,1 SAY "     A SUA SENHA ESTA' INCORRETA !!  "
@ 3,1 SAY "  MELHORES INFORMA─OES LIGAR PARA :  "
@ 4,1 SAY "       "
@ 4,8 SAY NOME+' '+LNOME+' '+CHR(76)+CHR(46)+' '+SNOME+SPACE(8)
@ 5,1 SAY "          (081) 222-0888             "
SET COLOR TO 
@ 8,0
CLEAR ALL 
SET CURSOR ON
QUIT 
**************
FUNCTION __COR
**************
PARAM COR
IF CFC="C"
   DO CASE
   CASE COR=1
      RETURN("W+/B")
   CASE COR=2
      RETURN("W+/BG")
   CASE COR=3
      RETURN("R/W")
   CASE COR=4
      RETURN("W+/RB,RB/W")
   CASE COR=5
      RETURN("GR+/B")
   CASE COR=6
      RETURN("GR+/N,B/W")
   CASE COR=7
      RETURN("W+/N,B/W")
   CASE COR=8
      RETURN("W+/B,N/W")
   CASE COR=9
      RETURN("BG+/N,B/W")
   CASE COR=10
      RETURN("BG+/B,N/W")
   CASE COR=11
      RETURN("B/BG")
   CASE COR=12
      RETURN("N/BG")
   CASE COR=13
      RETURN("W/N,B/W")
   CASE COR=14
      RETURN("B/W")
   CASE COR=15
      RETURN("B+/W")
   CASE COR=16
      RETURN("N/W")
   CASE COR=17
      RETURN("R/W")
   CASE COR=18
      RETURN("B/W,BG+/B")
   CASE COR=19
      RETURN("B/W,GR+/B")
   CASE COR=20
      RETURN("W+/R,B/W")
   CASE COR=21
      RETURN("B/W,W+/B")
   CASE COR=22
      RETURN("B/W,R*/W")
   CASE COR=23
      RETURN("W+/N,N/W,N,W,W/N")
   CASE COR=24
      RETURN("W+/B,B/W,N,W,BG/B")
   CASE COR=25
      RETURN("W+/B,W*/B")
   CASE COR=26
      RETURN("W+/N,B/W,N,,W+/N")
   CASE COR=27
      RETURN("W+/W")
   CASE COR=28
      RETURN("W+*/R")
   CASE COR=29
      RETURN("W+/B")
   ENDCASE
ELSE
   DO CASE
   CASE COR<=10
       RETURN("W+/N,N/W")
   CASE COR<=13
       RETURN("W/N,N/W")
   CASE COR<=17
       RETURN("N/W,W/N")
   CASE COR=20
       RETURN("W/N,N/W")
   CASE COR<=22
       RETURN("N/W,W+/N")
   CASE COR<=24
       RETURN("W+/N,N/W,N,W,W/N")
   CASE COR=25
       RETURN("W+/N,W*/N")
   CASE COR=26
       RETURN("W+/N,N/W,N,,W+/N")
   CASE COR=27
      RETURN("W+/W")
   CASE COR=28
      RETURN("W+*/N")
   CASE COR=29
       RETURN("N/W,W/N")
   ENDCASE
ENDIF
****************
PROCEDURE PIRATA
****************
PARAMETER CDG
SET COLOR TO 
EXPLODE(0,0,24,79)
SETCOLOR(__COR(1))
JANELA(1,0,7,38)
@ 2,1 SAY "O SISTEMA CAMERA 3 FOI ADULTERADO !!!"
@ 3,1 SAY "           CODIGO N╖ "+CDG+"             "
@ 4,1 SAY "  MELHORES INFORMA─OES LIGAR PARA :  "
@ 5,1 SAY "       "
@ 5,8 SAY NOME+SPACE(1)+LNOME+SPACE(1)+CHR(76)+CHR(46)+SPACE(1)+SNOME+SPACE(8)
@ 6,1 SAY "          (081) 222-0888             "
SET COLOR TO
CLEAR ALL 
SET CURSOR ON
@ 9,0
QUIT 
*****************************>> FIM DO PROGRAMA <<*****************************
