*ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»*
*º SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS          º*
*º VERSAO    : 1.1 - Copyright 1992                                       º*
*º PROGRAMA  : CAM3_431.PRG                                               º*
*º DESCRI€ŽO : Programa que gera o Cat logo Simples do acervo de fitas.   º*
*º AUTOR     : Marcelo Leal Limaverde Cabral                              º*
*º DATA      : 18/06/92                                                   º*
*ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*
#include "cam3.ch"
PARAMETERS NVIAS,NORG,FILTRO
SELE C
USE PRECOS INDEX PRECOS
SELE B
USE GENERO_F INDEX GENERO_F
SELE A
USE FITAS INDEX FITAS01,FITAS02
SET FILTER TO &FILTRO
SET ORDER TO NORG
SET RELATION TO CODIGO_P INTO C
SET RELATION TO CODIGO_G INTO B
GO TOP
IF EOF()
   TONE(300,3)
   MSG("N„o existem Fitas que obedecem … Sele‡„o Escolhida !! - Tecle [ESC]",.t.,"W+*/R")
   CLOSE DATA
   RETURN
ENDIF   
PRIVATE CAB1,CAB2,CAMPOS[6],TITU[4],COLC[6],COLT[4]
*********** CABECALHOS ************
IF NORG=1
   CAB1="RELA€"+chr(_ACTEL[AMATI])+"O DAS FITAS POR ORDEM ALFABTICA"
ELSE
   CAB1="RELA€"+chr(_ACTEL[AMATI])+"O DAS FITAS POR ORDEM DE C"+chr(_ACTEL[OMAAG])+"DIGO"
ENDIF
DO CASE
CASE NSEL=1
   CAB2=SPACE(50)
CASE NSEL=2
   CAB2="SELECIONANDO POR G"+chr(_ACTEL[EMACI])+"NERO"
CASE NSEL=4
   CAB2="INICIADAS POR: "+PARFIL
CASE NSEL=9
   CAB2="C"+chr(_ACTEL[OMAAG])+"DIGO DE PRE€O: "+C->TITULO_P
ENDCASE

*********** CAMPOS DO DETALHE **********
CAMPOS[1]="A->CODIGO_G"
CAMPOS[2]="'-'"
CAMPOS[3]="A->NUMER_FITA"
CAMPOS[4]="A->TITUL_FITA"
CAMPOS[5]="B->TITULO_G"
CAMPOS[6]="A->NUM_COPIAS"
*********** TITULOS DOS CAMPOS ************
TITU[1]="C¢digo"
TITU[2]="T¡tulo da Fita"
TITU[3]="Gˆnero"
TITU[4]="C¢pias"
*********** COLUNAS DOS CAMPOS ************
COLC[1]=0
COLC[2]=2
COLC[3]=3
COLC[4]=10
COLC[5]=54
COLC[6]=76
*********** COLUNAS DOS TITULOS ***********
COLT[1]=0
COLT[2]=10
COLT[3]=54
COLT[4]=74
REL10(CAB1,CAB2,CAMPOS,TITU,COLC,COLT,NVIAS,.t.)
CLOSE DATA
RETURN
