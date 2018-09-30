*ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»*
*º SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS          º*
*º VERSAO    : 1.1 - Copyright 1992                                       º*
*º PROGRAMA  : CAM3_441.PRG                                               º*
*º DESCRI€ŽO : Programa que gera Relat¢rio Simples do Cadastro de S¢cios. º*
*º AUTOR     : Marcelo Leal Limaverde Cabral                              º*
*º DATA      : 18/06/92                                                   º*
*ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*
#include "cam3.ch"
PARAMETERS NVIAS,NORG,NSEL,FILTRO
SELE A
USE SOCIOS INDEX SOCIOS01,SOCIOS02
SET FILTER TO &FILTRO
SET ORDER TO NORG
GO TOP
IF EOF()
   TONE(300,3)
   MSG("N„o existem S¢cios que obedecem … Sele‡„o Escolhida !! - Tecle [ESC]",.t.,"W+*/R")
   CLOSE DATA
   RETURN
ENDIF   
PRIVATE CAB1,CAB2,CAMPOS[4],TITU[4],COLC[4],COLT[4]
*********** CABECALHOS ************
IF NORG=1
   CAB1="      RELA€"+chr(_ACTEL[AMATI])+"O DE S"+chr(_ACTEL[OMAAG])+;
        "CIOS POR ORDEM ALFABTICA      "
   CAMPOS[1]="A->NOME_SOCIO"
   CAMPOS[2]="STRZERO(A->NUME_SOCIO,5)"
   TITU[1]="Nome do S¢cio"
   TITU[2]="N£mero"
   COLC[1]=0
   COLC[2]=36
   COLT[1]=0
   COLT[2]=35
ELSE
   CAB1="       RELA€"+chr(_ACTEL[AMATI])+"O DE S"+chr(_ACTEL[OMAAG])+;
        "CIOS POR ORDEM NUMRICA       "
   CAMPOS[1]="STRZERO(A->NUME_SOCIO,5)"
   CAMPOS[2]="A->NOME_SOCIO"
   TITU[1]="N£mero"
   TITU[2]="Nome do S¢cio"
   COLC[1]=0
   COLC[2]=8
   COLT[1]=0
   COLT[2]=8
ENDIF
*********** CAMPOS DO DETALHE *************
CAMPOS[3]="left(dtoc(A->ANIV_SOCIO),5)"
CAMPOS[4]="A->FONE_SOCIO"
*********** TITULOS DOS CAMPOS ************
TITU[3]="Anivers rio"
TITU[4]="Telefone"
*********** COLUNAS DOS CAMPOS ************
COLC[3]=53
COLC[4]=72
*********** COLUNAS DOS TITULOS ***********
COLT[3]=50
COLT[4]=72
*******************************************
DO CASE 
CASE NSEL=1
   CAB2=SPACE(50)
CASE NSEL=2
   CAB2="INICIADOS POR: "+PARFIL
CASE NSEL=4
   CAB2="ANIVERSARIANTES DO MES DE "+UPPER(MES(PARFIL))
ENDCASE
REL10(CAB1,CAB2,CAMPOS,TITU,COLC,COLT,NVIAS,.t.)
CLOSE DATA
RETURN
