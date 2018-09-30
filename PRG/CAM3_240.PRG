******************************************************************************
* SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS              * 
* VERSAO    : 1.1 - Copyright 1992                                           * 
* PROGRAMA  : CAM3_240.PRG                                                   *
* DESCRI€AO : Programa para Apagar Socios do Arquivo.                        *
* AUTOR     : Marcelo Leal Limaverde Cabral                                  *
* DATA      : 27/02/92                                                       * 
******************************************************************************
PRIVATE ACHA,COR,CORI,TELA,MENS,APAGA
ACHA=0
COR=SETCOLOR()
SAVE SCREEN TO TELA
SETCOLOR(__COR(21))
@ 12,43 CLEAR TO 14,65
@ 12,43 TO 14,65
@ 13,44 SAY " Digite o N§ :" GET ACHA PICTURE "99999"
SET CURSOR ON
READ
SET CURSOR OFF
IF ACHA=0
   SETCOLOR(COR)
   RESTORE SCREEN FROM TELA 
   RETURN
ENDIF
SELE C
USE CONTROLE INDEX CONTROLE
SELE B
USE COMPROV INDEX COMPR02
SELE A
USE SOCIOS INDEX SOCIOS02,SOCIOS01
SEEK ACHA
IF ! FOUND()
   @ 13,44 SAY " N§ N„o Cadastrado !!" 
   INKEY(2)
   SETCOLOR(COR)
   RESTORE SCREEN FROM TELA 
   CLOSE DATA
   RETURN
ENDIF   
SELE B
SEEK STR(ACHA,5)
IF FOUND()
   MSG(" ESTE SOCIO ESTA COM FITA(S) ALUGADA(S) ! Aperte uma Tecla ... ",.T.)
   SETCOLOR(COR)
   RESTORE SCREEN FROM TELA 
   CLOSE DATA
   RETURN
ENDIF
SELE A
ATOV()

SETCOLOR(COR)

SETCOLOR(__COR(10))

CAIXOUT(12,39,13,40)

CORI=SETCOLOR()
DO WHILE .T.
  DO CAM3_211
  CLEAR GETS
  APAGA=' '
  MENS="Confirma a Exclus„o deste S¢cio do Arquivo ? (S/N) :"
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
    SELE C
    DELETE FOR C->NUME_SOCIO=ZIPS(ACHA)
    EXIT  
  ENDIF
ENDDO
RESTORE SCREEN FROM TELA 
SETCOLOR(COR)
CLOSE DATA
RETURN
****>> EOF <<****
