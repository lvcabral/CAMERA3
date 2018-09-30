*ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป*
*บ SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS          บ*
*บ VERSAO    : 1.1 - Copyright 1992                                       บ*
*บ PROGRAMA  : CAM3_450.PRG                                               บ*
*บ DESCRI€O : Programa que gera Histขrico de TITULOS Por Sขcio.          บ*
*บ AUTOR     : Marcelo Leal Limaverde Cabral                              บ*
*บ DATA      : 18/06/92                                                   บ*
*ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ*
#include "cam3.ch"
SELE A
USE SOCIOS INDEX SOCIOS02
SELE B
USE FITAS  INDEX FITAS02
SELE C
USE CONTROLE 
SET RELATION TO UnZIPF(CODI_FITA) INTO B
PRIVATE NUMEXSOCIO,CAB1,CAB2,CAMPOS[3],TITU[3],COLC[3],COLT[3],TELA,COR
TELA=SAVESCREEN(07,2,17,70)
COR=SETCOLOR()
NUMEXSOCIO=0
SETCOLOR(__COR(1))
@ 6,9 CLEAR TO 8,31
JANELA(6,9,8,31)
@ 7,10 SAY " Digite o Nง :" GET NUMEXSOCIO PICTURE "99999" VALID H_NUMSOC(NUMEXSOCIO)
SET CURSOR ON
READ
SET CURSOR OFF
IF LASTKEY()=27
   RESTSCREEN(07,02,17,70,TELA)
   SETCOLOR(COR)
   CLOSE DATA
   RETURN
ENDIF
MSG("AGUARDE, PROCESSANDO...",.F.,__COR(28))
SET FILTER TO C->NUME_SOCIO==ZIPS(NUMEXSOCIO)
GO TOP
IF EOF()
   TONE(300,3)
   MSG("No existem Registros deste Sขcio no Arquivo de Controle ! - Tecle [ESC]",.t.,__cor(28))
   RESTSCREEN(07,02,17,70,TELA)
   SETCOLOR(COR)
   CLOSE DATA
   RETURN
ENDIF   
PERG="D"
KEYIN(11,11,"Organizando pela Data ou pelo Cขdigo do Tกtulo ? (D/C):",@PERG,"!","PERG$'DC'",__cor(1))
IF PERG="C"
   SET INDEX TO CONTROLE
   GO TOP
ENDIF
IF MSG("Prepare a Impressora e Aperte uma Tecla ....",.T.,__COR(1))=27
   RESTSCREEN(07,02,17,70,TELA)
   SETCOLOR(COR)
   CLOSE DATA
   RETURN
ENDIF       
*********** CABECALHOS ************
CAB1:="HIST"+chr(_ACTEL[OMAAG])+"RICO DE T"+chr(_ACTEL[IMAAG])+"TULOS ALUGADOS"
CAB2:="SOCIO: "+STRZERO(NUMEXSOCIO,5)+" - "+A->NOME_SOCIO
*********** CAMPOS DO DETALHE *************
CAMPOS[1]="ZTOD(C->DATA_ALUG)"
CAMPOS[2]="B->CODIGO_G+'-'+B->NUMER_FITA"
CAMPOS[3]="B->TITUL_FITA"
*********** TITULOS DOS CAMPOS ************
TITU[1]="Data"
TITU[2]="Cขdigo"
TITU[3]="Tกtulo"
*********** COLUNAS DOS CAMPOS ************
COLC[1]=0
COLC[2]=11
COLC[3]=21
*********** COLUNAS DOS TITULOS ***********
COLT[1]=0
COLT[2]=11
COLT[3]=21
*******************************************
IF TESTA_IMP(__cor(24))
   MSG("  ****  IMPRIMINDO ......... [ESC] - Pausa na Impresso",.F.,__COR(1))
   REL10(CAB1,CAB2,CAMPOS,TITU,COLC,COLT,1,.t.)
ENDIF
RESTSCREEN(07,02,17,70,TELA)
SETCOLOR(COR)
CLOSE DATA
RETURN
*****************
FUNCTION H_NUMSOC
*****************
PARAM NS
SELE A
PRIVATE CORF
CORF=SETCOLOR()
SEEK NS
IF FOUND()
   SELE C
   SETCOLOR(__COR(18))
   @ 23,11 CLEAR TO 23,60
   SETCOLOR(CORF)
   RETURN(.T.)
ELSE
   SELE C
   SETCOLOR(__COR(18))
   @ 23,11 CLEAR TO 23,60
   @ 23,11 SAY "                 Sขcio no cadastrado !!"
   SETCOLOR(CORF)
   TONE(300,3)
   RETURN(.F.)
ENDIF   
