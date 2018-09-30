******************************************************************************
* SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS              *
* VERSŽO    : 1.1 - Copyright 1992                                           *
* PROGRAMA  : CAM3_150.PRG                                                   *
* DESCRI€ŽO : Programa de Configura‡„o do Sistema.                           *
* AUTOR     : Marcelo Leal Limaverde Cabral                                  *
* DATA      : 17/07/92                                                       *
******************************************************************************
#include "cam3.ch"
SET KEY 18 TO NULO
SET KEY 3  TO NULO
PRIVATE MSG,TELA
DO WHILE .T.

  NIVHLP=140
  SETCOLOR(__COR(29))
  @ 21,0 SAY ' [ESC]  VOLTA AO MENU ANTERIOR   º  '+CHR(24)+CHR(25)+CHR(27)+;
             CHR(26)+'  MOVEM A BARRA  º  [ENTER]  SELECIONA '
  SETCOLOR(__COR(18))
  @ 23,11 CLEA TO 23,78
  @ 6,28 TO 16,52 DOUBLE
  @ 07,29  PROMPT'   Dados da Locadora   ' MESSAGE IF(CFG,'Altera','Consulta')+' os Dados da Locadora'
  @ 08,28  SAY 'Ç                       ¶'
  @ 08,29 TO 8,51
  @ 09,29  PROMPT' Parƒmetros do Sistema ' MESSAGE IF(CFG,'Altera','Consulta')+' os Parƒmetros do Sistema'
  @ 10,28  SAY 'Ç                       ¶'
  @ 10,29 TO 10,51
  @ 11,29  PROMPT'   Tabela de Pre‡os    ' MESSAGE IF(CFG,'Altera','Consulta')+' a Tabela de Pre‡os'
  @ 12,28  SAY 'Ç                       ¶'
  @ 12,29 TO 12,51
  @ 13,29  PROMPT'  Gˆneros dos T¡tulos  ' MESSAGE IF(CFG,'Altera','Consulta')+' a Tabela de Gˆneros dos T¡tulos'
  @ 14,28  SAY 'Ç                       ¶'
  @ 14,29 TO 14,51
  IF CFG
   @ 15,29  PROMPT'   Senhas do Sistema   ' MESSAGE'Altera as Senhas do Sistema'
  ELSE
   SETCOLOR(__COR(27))
   @ 15,29  SAY'   Senhas do Sistema   '
   SETCOLOR(__COR(18))
  ENDIF
 
  MENU TO AD

  MSG=IF(CFG,'AS SETAS ('+CHR(24)+CHR(25)+CHR(27)+CHR(26)+') MOVIMENTAM E [ENTER] EDITA O CAMPO'," ")
  DO CASE
  CASE AD=0
    SET KEY 18 TO 
    SET KEY 3  TO 
    RETURN
  CASE AD=1
    RESTORE FROM CAM3.CFG ADDITIVE
    TELA=SAVESCREEN(06,1,19,78)
    SETCOLOR(__COR(11))

    CPB(06,1,19,78)
    @ 21,0    

    SETCOLOR(__COR(14))
    @ 23,11 CLEAR TO 23,77
    SETCOLOR(__COR(8))
    SCROLL(08,1,18,78,0)
    JANELA(08,1,18,78)
    TITU=' Dados da Locadora '
    @ 08,CENTRA(TITU) SAY TITU
    @ 10,03 SAY 'Nome da Locadora ..:'GET CF_NL
    @ 12,03 SAY 'Endere‡o ..........:'GET CF_EN
    @ 12,59 SAY 'C.E.P. ...:'GET CF_CE PICT"99.999"
    @ 14,03 SAY 'Cidade ............:'GET CF_CI
    @ 14,45 SAY 'Estado .:'GET CF_UF PICT"!!"
    @ 14,59 SAY 'Tel:' GET CF_TL PICT"(999)999-9999"
    @ 16,03 SAY 'C.G.C. ............:'GET CF_CP PICT"99.999.999/9999-99" VALID TESTCGC(CF_CP)
    @ 16,45 SAY 'Insc. Est. .:'GET CF_IE PICT REPL("#",18)
    IF CFG
       SET CURSOR ON 
       READ
       SET CURSOR OFF
    ELSE
       CLEAR GETS
       SETCOLOR(__COR(18))
       @ 23,11 CLEAR TO 23,78
       @ 23,CENTRA("Aperte uma tecla para continuar...") SAY "Aperte uma tecla para continuar..."
       INKEY(0)
    ENDIF
    IF UPDATED() .AND. LASTKEY()#27 .AND. CFG
       SETCOLOR(__COR(14))
       @ 2,5 SAY CF_MT
       SAVE TO CAM3.CFG ALL LIKE CF_*
    ENDIF
    RESTSCREEN(06,1,19,78,TELA)
 CASE AD=2
    NIVHLP=142
    RESTORE FROM CAM3.CFG ADDITIVE
    IF TYPE("CF_ND")#"N"
       CF_ND=0
    ENDIF
    TELA=SAVESCREEN(06,1,19,78)
    SETCOLOR(__COR(11))

    CPB(06,1,19,78)
    @ 21,0

    SETCOLOR(__COR(8))
    SCROLL(08,1,18,78,0)
    JANELA(08,1,18,78)
    TITU=' Parƒmetros do Sistema '
    @ 08,CENTRA(TITU) SAY TITU
    @ 10,3 SAY 'N§ de Vias por Comprovante...:'GET CF_VC PICT"9"
    @ 10,COL()+10 SAY 'N§ de Etiquetas por Linha....:'GET CF_EL PICT"9" RANGE 1,4
    @ 12,3 SAY 'Msg. Compr..:'GET CF_MC 
    @ 14,3 SAY 'Msg. Relat1.:'GET CF_M1
    @ 14,COL()+13 SAY 'Msg. Relat2....:'GET CF_M2
    @ 16,3 SAY 'Msg. Tela...:'GET CF_MT
    @ 16,COL()+05 SAY 'N£mero de Dependentes..(1->4):'GET CF_ND PICT "9" RANGE 1,4
    IF CFG
       SET CURSOR ON 
       READ
       SET CURSOR OFF
    ELSE
       CLEAR GETS
       SETCOLOR(__COR(18))
       @ 23,11 CLEAR TO 23,78
       @ 23,CENTRA("Aperte uma tecla para continuar...") SAY "Aperte uma tecla para continuar..."
       INKEY(0)
    ENDIF
    IF UPDATED() .AND. LASTKEY()#27 .AND. CFG
       SETCOLOR(__COR(14))
       @ 2,5 SAY CF_MT
       SAVE TO CAM3.CFG ALL LIKE CF_*
    ENDIF
    RESTSCREEN(06,1,19,78,TELA)
 CASE AD=3
    SELE B
    USE FITAS INDEX FITAS01,FITAS02,FITAS03
    SET ORDER TO 0
    SELE A
    USE PRECOS 
    SET INDEX TO PRECOS
    TELA=SAVESCREEN(4,0,21,79)
    @ 23,11 CLEAR TO 23,78
    @ 23,CENTRA(MSG) SAY MSG
    SETCOLOR(__COR(11))
    @ 20,0
    DECLARE CAMPOS[7],TITULOS[7],MASCARA[7]
    CAMPOS[1]="CODIGO_P"
    CAMPOS[2]="TITULO_P"
    CAMPOS[3]="PRECO_24H"
    CAMPOS[4]="PRECO_48H"
    CAMPOS[5]="PRECO_SAB"
    CAMPOS[6]="PRECO_ESP"
    CAMPOS[7]="PRECO_MUL"
    TITULOS[1]="COD"
    TITULOS[2]="  CATEGORIAS;  DAS  FITAS"
    TITULOS[3]="24 HORAS;  Cr$"
    TITULOS[4]="48 HORAS;  Cr$"
    TITULOS[5]=" SABADO ;  Cr$"
    TITULOS[6]="ESPECIAL;  Cr$"
    TITULOS[7]=" MULTA  ;  Cr$"
    STORE "@E" TO MASCARA[3],MASCARA[4],MASCARA[5],MASCARA[6],MASCARA[7]
    SETCOLOR(__COR(9))
    SCROLL(4,0,19,79,0)
    @ 4,0 TO 19,79 DOUBLE
    TABELA="°°°°°°°°°°°°°°°°°°   T A B E L A  D E  P R E € O S   °°°°°°°°°°°°°°°°°"
    @ 5,CENTRA(TABELA) SAY TABELA
    @ 6,0 SAY CHR(204)+REPL(CHR(205),78)+CHR(185)
    SETCOLOR(__COR(29))
    IF CFG
       @ 21,0 SAY'  [ESC]  VOLTA º [ALT-A]  APAGA  º  [ALT-I] INCLUI ITENS  º  [ALT-P]  IMPRIME   '
    ELSE
       @ 21,0 SAY'  [ESC] VOLTA AO MENU º ['+CHR(24)+CHR(25)+CHR(27)+CHR(26)+'] MOVIMENTAM O CURSOR º  [ALT-P] IMPRIME A TABELA '
    ENDIF

    SETCOLOR(__COR(7))
    @ 9,1 SAY REPL(CHR(205),78)
    PUBLIC APAGA
    APAGA=.F.
    NOVO=.F.
    
    SET KEY 18 TO 
    SET KEY 3  TO 
    
    DBEDIT(7,5,18,76,CAMPOS,"C_BRWS",MASCARA,TITULOS,CHR(209)+CHR(205),CHR(179)+" ")
    
    SET KEY 18 TO NULO
    SET KEY 3  TO NULO

    IF APAGA
     PACK
    ENDIF
    CLOSE DATA 
    RESTSCREEN(4,0,21,79,TELA)
 CASE AD=4
    SELE C
    USE COMPROV INDEX COMPR01,COMPR02
    SET ORDER TO 0
    SELE B
    USE FITAS INDEX FITAS01,FITAS02,FITAS03
    SET ORDER TO 0
    SELE A
    USE GENERO_F  
    SET INDEX TO GENERO_F
    GO TOP
    TELA=SAVESCREEN(6,54,19,77)
    @ 23,11 CLEAR TO 23,77
    @ 23,CENTRA(MSG) SAY MSG
    SETCOLOR(__COR(11))
    DECLARE CAMPOS[2],TITULOS[2]
    CAMPOS[1]="CODIGO_G"
    CAMPOS[2]="TITULO_G"
    TITULOS[1]=""
    TITULOS[2]=""
    SETCOLOR(__COR(9))
    SCROLL(6,54,19,77,0)
    @ 6,54 TO 19,77 DOUBLE
    @ 7,55 SAY "   TABELA DE GENEROS"
    SETCOLOR(__COR(29))

    IF CFG
       @ 21,0 SAY'  [ESC]  VOLTA º [ALT-A]  APAGA  º  [ALT-I] INCLUI ITENS  º  [ALT-P]  IMPRIME   '
    ELSE
       @ 21,0 SAY'  [ESC] VOLTA AO MENU º ['+CHR(24)+CHR(25)+CHR(27)+CHR(26)+'] MOVIMENTAM O CURSOR º  [ALT-P] IMPRIME A TABELA '
    ENDIF

    SETCOLOR(__COR(7))
    PUBLIC APAGA
    APAGA=.F.
    NOVO=.F.
    
    SET KEY 18 TO
    SET KEY 3  TO
    
    DBEDIT(8,55,18,76,CAMPOS,"C_BRWS","@!",TITULOS)
    
    SET KEY 18 TO NULO
    SET KEY 3  TO NULO

    IF APAGA
     PACK
    ENDIF
    CLOSE DATA 
    RESTSCREEN(6,54,19,77,TELA)
 CASE AD=5
    TELA=SAVESCREEN(10,55,17,75)
    SETCOLOR(__COR(10))
    SCROLL(10,55,14,75,0)
    @ 10,55 TO 14,75
    @ 11,56 PROMPT "   SENHA  MASTER   "
    @ 12,56 TO 12,74
    @ 13,56 PROMPT " SENHA DO OPERADOR "
    MENU TO S103
    IF S103=0
     RESTSCREEN(10,55,17,75,TELA)
     LOOP
    ENDIF
    SCROLL(15,55,17,75,0)
    @ 15,55 TO 17,75
    @ 16,56 SAY 'SENHA ATUAL:'
    SET CONFIRM OFF
    SETCOLOR(__COR(25))
    COD=SENHA(16,69)
    RESTORE FROM CAM3.CFG ADDITIVE

  DO CASE
  CASE S103=1
    IF COD==CF_SM
       SCROLL(15,55,17,75,0)
       @ 15,55 TO 17,75
       @ 16,56 SAY 'NOVA SENHA :'
       SET CONFIRM OFF
       SETCOLOR(__COR(25))
       COD1=SENHA(16,69)

       SCROLL(15,55,17,75,0)
       @ 15,55 TO 17,75
       @ 16,56 SAY 'CONFIRME ..:'
       SET CONFIRM OFF
       SETCOLOR(__COR(25))
       COD2=SENHA(16,69)
       IF COD1==COD2
          CF_SM=COD2
          SAVE TO CAM3.CFG ALL LIKE CF_*
       ELSE
        SETCOLOR(__COR(1))
        @ 16,56 CLEAR TO 16,74
        @ 16,56 SAY 'ERRO NA CONFIRMA€AO'
        INKEY(1)
      ENDIF
    ELSE
        SETCOLOR(__COR(1))
        @ 16,56 CLEAR TO 16,74
        @ 16,56 SAY 'SENHA INVALIDA !'
        INKEY(1)
    ENDIF
  CASE S103=2
    IF COD==CF_SO
       SCROLL(15,55,17,75,0)
       @ 15,55 TO 17,75
       @ 16,56 SAY 'NOVA SENHA :'
       SET CONFIRM OFF
       SETCOLOR(__COR(25))
       COD1=SENHA(16,69)

       SCROLL(15,55,17,75,0)
       @ 15,55 TO 17,75
       @ 16,56 SAY 'CONFIRME ..:'
       SET CONFIRM OFF
       SETCOLOR(__COR(25))
       COD2=SENHA(16,69)
       IF COD1==COD2
          CF_SO=COD2
          SAVE TO CAM3.CFG ALL LIKE CF_*
       ELSE
          SETCOLOR(__COR(1))
          @ 16,56 CLEAR TO 16,74
          @ 16,56 SAY 'ERRO NA CONFIRMA€AO'
          INKEY(1)
       ENDIF
    ELSE
        SETCOLOR(__COR(1))
        @ 16,56 CLEAR TO 16,74
        @ 16,56 SAY 'SENHA INVALIDA !'
        INKEY(1)
    ENDIF

  ENDCASE
  RELEASE ALL LIKE CF_*
  SET CONFIRM ON
  RESTSCREEN(10,55,17,75,TELA)
ENDCASE
ENDDO

***************
FUNCTION C_BRWS
***************

PARAM MODO,I

PRIVA CAMPO,CAB1,CAB2,REG

CAMPO=CAMPOS[I]
DO CASE
   CASE MODO<4
        IF MODO=2.OR.MODO=1
          TONE(400,2)
          RETURN(1)
        ELSEIF MODO=3 
          APPEND BLANK
          GO TOP
          KEYBOARD CHR(29)+CHR(13)
         ENDIF
       RETURN(1)
   CASE LASTKEY()=27
       RETURN(0)
   CASE LASTKEY()=286.AND.CFG
       DELETE
       IF ROW()=10.AND.LEN(CAMPOS)>2
        KEYB CHR(31)
       ELSEIF ROW()=9.AND.LEN(CAMPOS)=2
        KEYB CHR(31)
       ENDIF
       APAGA=.T.
       RETURN(2)
  CASE LASTKEY()=279.AND.CFG
       GO BOTTOM
       APPEND BLANK
       NOVO=.T.
       KEYBOARD CHR(31)+CHR(29)+CHR(13)
       RETURN(1)
  CASE LASTKEY()=281
       DO CASE
       CASE AD=3
          CAB1="TABELA DE PRE€OS"
          PRIVATE TITU[7],COLC[7],COLT[7]
          TITU[1]="Cod."
          TITU[2]="Descri‡"+chr(_ACTEL[AMITI])+"o"
          TITU[3]="24 hrs Cr$"
          TITU[4]="48 hrs Cr$"
          TITU[5]="S bado Cr$"
          TITU[6]="Espec. Cr$"
          TITU[7]=" Multa Cr$"
          COLT[1]=0
          COLT[2]=5
          COLT[3]=21
          COLT[4]=33
          COLT[5]=45
          COLT[6]=59
          COLT[7]=70
          COLC[1]=0
          COLC[2]=5
          COLC[3]=23
          COLC[4]=35
          COLC[5]=49
          COLC[6]=61
          COLC[7]=72
       CASE AD=4
          CAB1="TABELA DE G"+chr(_ACTEL[EMACI])+"NEROS DAS FITAS"
          PRIVATE TITU[2],COLC[2],COLT[2]
          TITU[1]="C¢digo"
          TITU[2]="Descri‡"+chr(_ACTEL[AMITI])+"o"
          COLC[1]=0
          COLC[2]=10
          COLT=COLC
       ENDCASE   
       CAB2=SPACE(50)
       IF TESTA_IMP(__cor(24))
          REG=RECNO()
          REL10(CAB1,CAB2,CAMPOS,TITU,COLC,COLT,1,.T.)
          GO REG
       ENDIF   
       RETURN(2)
  CASE LASTKEY()=13.AND.CFG
       NUM=RECNO()
       SET CURSOR ON
       OLDCPO=&CAMPO
       IF I<3
         @ ROW(),COL() GET &CAMPO PICTURE "@!"
       ELSE
         @ ROW(),COL() GET &CAMPO PICTURE "@E"
       ENDIF
       READ
       SET CURSOR OFF
       IF UPDATED()
          IF I=1
             IF NOVO
                NOVO=.F. 
                KEYBOARD CHR(4)+CHR(13)
             ELSE
                TE103=MSG(" ATUALIZANDO OS ARQUIVOS ... ",.F.,__COR(1))
                SELE B
                GO TOP
                REPLACE ALL &CAMPO WITH A->&CAMPO FOR &CAMPO==OLDCPO
                IF AD=4
                   SELE C
                   GO TOP
                   REPLACE ALL NUME_FITA1 WITH A->&CAMPO+RIGHT(NUME_FITA1,5);
                   FOR LEFT(NUME_FITA1,2)=OLDCPO
                ENDIF
                SELE A
                RESTSCREEN(11,0,13,79,TE103)
             ENDIF
             RETURN(2)
          ELSE
             RETURN(1)
          ENDIF
       ELSE
          RETURN(1)   
       ENDIF   
    OTHER
       RETURN(1)
ENDCASE
****************
FUNCTION TestCgc
****************
PARAMETER Cgc
PRIVA Cor
COR=SETCOLOR()
IF ! Cgc(Cgc)
   SETCOLOR(__COR(14))
   @ 23,2 SAY "MENSAGEM:           CGC Digitado ‚ Inv lido !!!"
   TONE(300,3)
   SETCOLOR(COR)
   RETURN(.F.)
ELSE
   SETCOLOR(__COR(14))
   @ 23,11 CLEAR TO 23,77
   SETCOLOR(COR)
   RETURN(.T.)
ENDIF   
******************************>> FIM DO ARQUIVO <<*****************************
