******************************************************************************
* SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS              * 
* VERSAO    : 1.0 - Copyright 1991                                           * 
* PROGRAMA  : CAM3_340.PRG                                                   *
* DESCRI€AO : Programa para Apagar Socios do Arquivo.                        *
* AUTOR     : Marcelo Leal Limaverde Cabral                                  *
* DATA      : 27/02/92                                                       * 
******************************************************************************
PRIVATE NUME,ACHA,COR,CORI,TELA,MENS,APAGA
NUME=SPACE(7)
COR=SETCOLOR()
SAVE SCREEN TO TELA
SETCOLOR(__COR(21))
@ 12,13 CLEAR TO 14,37
@ 12,13 TO 14,37
@ 13,14 SAY " Digite o N§ :" GET NUME PICTURE "@! AA-9999"
SET CURSOR ON
READ
SET CURSOR OFF
ACHA=LEFT(NUME,2)+RIGHT(NUME,4)
IF ACHA=SPACE(6)
   SETCOLOR(COR)
   RESTORE SCREEN FROM TELA 
   RETURN
ENDIF
SELE A
USE FITAS
SET INDEX TO FITAS02,FITAS01,FITAS03
SEEK ACHA
IF ! FOUND()
   @ 13,14 SAY " Cod. N„o Cadastrado !" 
   INKEY(2)
   SETCOLOR(COR)
   RESTORE SCREEN FROM TELA 
   CLOSE DATA
   RETURN
ENDIF   
IF COPIA_FORA#0
   MSG(" ESTA FITA TEM COPIA(S) ALUGADA(S) ! Aperte uma Tecla ... ",.T.)
   SETCOLOR(COR)
   RESTORE SCREEN FROM TELA 
   CLOSE DATA
   RETURN
ENDIF
ATOV()

SETCOLOR(COR)

SETCOLOR(__COR(9))
CAIXOUT(12,39,13,40)
DO WHILE .T.
   DO CAM3_311
   CLEAR GETS
   APAGA=' '
   MENS="Confirma a Exclus„o desta Fita do Arquivo ? (S/N) :"
   SETCOLOR(__COR(21))
   @ 23,CENTRA(MENS) SAY MENS GET APAGA PICTURE"!" VALID APAGA$"SN"
   SET CURSOR ON
   READ
   SET CURSOR OFF
   IF LASTKEY()=27.OR.APAGA='N'
    EXIT
   ELSEIF APAGA='S'
    @ 23,CENTRA(MENS) CLEAR TO 23,77
    MENS="APAGANDO .........."
    @ 23,CENTRA(MENS) SAY MENS
    DELETE 
    PACK
    EXIT  
   ENDIF
ENDDO
RESTORE SCREEN FROM TELA 
SETCOLOR(COR)
CLOSE DATA
RETURN
****>> EOF <<****
