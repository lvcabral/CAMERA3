*****************************************************************************
* SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS             * 
* VERSAO    : 1.0 - Copyright 1991                                          * 
* PROGRAMA  : CAM3_210.PRG                                                  *
* DESCRI€AO : Programa para o Cadastramento dos Socios.                     *
* AUTOR     : Marcelo Leal Limaverde Cabral                                 *
* DATA      : 26/02/92                                                      * 
*****************************************************************************

PRIVATE TIT,TELA

SET KEY 18 TO NULO
SET KEY 3  TO NULO
SET KEY 27 TO
TELA=SAVESCREEN(4,0,21,79)
SELE A
USE SOCIOS
SET INDEX TO SOCIOS01,SOCIOS02

SETCOLOR(__COR(11))

@ 6,1 CLEA TO 19,78 && LIMPA A MOLDURA DO CENTRO

SETCOLOR(__COR(14))

@ 23,11 CLEA TO 23,78

SETCOLOR(__COR(10))

CAIXOUT(12,39,13,40)

DO WHIL .T.

   IF B=1
      NIVHLP=210 
      TIT='CADASTRAR'
      BTOV()
      OLDNR=NUMEXSOCIO
      SET ORDER TO 2
      GO BOTTOM
      NUMEXSOCIO=NUME_SOCIO+1
      SET ORDER TO 1
      GO TOP
   ELSE
      NIVHLP=210
      TIT='MODIFICAR'
      NOMERSOCIO=SPACE(33)
      NUMERSOCIO=0
      DO CAM3_220
      IF NOMERSOCIO=SPACE(33).AND.NUMERSOCIO=0
         EXIT
      ENDIF
      ATOV()
      OLDNR=NUMEXSOCIO
   ENDIF 
  DO WHILE .T.
    SAI=1
    SETCOLOR(__COR(10))
    DO CAM3_211
    SET CURSOR ON 
    SET CONFIRM OFF
    READ 
    SET CONFIRM ON
    SET CURSOR OFF 

    SETCOLOR(__COR(22))
    IF LASTKEY()=27
       EXIT
    ENDIF
    @ 23,2 CLEA TO 23,78
    @ 23,02 SAY 'Escolha a Op‡„o :'
    @ 23,COL()+2 PROMPT'Confirmar'
    @ 23,COL()+3 PROMPT'Modificar'
    @ 23,COL()+3 PROMPT'Abandonar'
    MENU TO SAI
    @ 23,2 SAY "MENSAGEM:"+SPACE(65)
    IF SAI=1
      IF B=1
       GO BOTTOM
       APPEND BLANK
      ENDIF 
      VTOA()
      EXIT
    ELSEIF SAI=3
      EXIT
    ENDIF
  ENDDO
  SAI=1
  @ 23,2 CLEA TO 23,78
  @ 23,13 SAY 'DESEJA &TIT MAIS UM SOCIO ? '
  @ 23,COL()+1 PROMPT'Sim'
  @ 23,COL()+1 SAY 'ou'
  @ 23,COL()+1 PROMPT'N„o'
  MENU TO SAI
  @ 23,2 SAY "MENSAGEM:"+SPACE(65)
  IF SAI=2.OR.SAI=0
     EXIT 
  ENDIF
  SETCOLOR(__COR(10))
ENDDO
SET KEY 18 TO 
SET KEY 3  TO 
SET KEY 27 TO 
CLOSE DATA 
RESTSCREEN(4,0,21,79,TELA)
NIVHLP=0
RETURN

*****************
  FUNCTION NSOC
***************** 
PRIVA VOLTA,CORG,REG

CORG=SETCOLOR()

IF B=1.OR.NUMEXSOCIO#OLDNR
 REG=RECNO()
 SET ORDER TO 2
 GO TOP
 SEEK NUMEXSOCIO
 IF FOUND()
   SETCOLOR(__COR(14))
   @ 23,02 SAY 'MENSAGEM:       N£mero Digitado j  Existe no Cadastro'
   TONE(300,3)
   VOLTA=.F.
 ELSEIF NUMEXSOCIO=0
   SETCOLOR(__COR(14))
   @ 23,02 SAY 'MENSAGEM:        Digite o N£mero de Cadastro do Socio'
   TONE(300,3)
   VOLTA=.F.
 ELSE
   SETCOLOR(__COR(14))
   @ 23,11 SAY SPACE(60)
   VOLTA=.T.
 ENDIF  
 GOTO REG
 SETCOLOR(CORG)
 RETURN(VOLTA)
ELSE
 SETCOLOR(__COR(14))
 @ 23,11 SAY SPACE(60)
 SETCOLOR(CORG)
 RETURN(.T.)
ENDIF
 
****************
FUNCTION TESTCPF
****************
PARAMETER CPF
PRIVA COR
COR=SETCOLOR()
IF ! CPF(CPF)
   SETCOLOR(__COR(14))
   @ 23,2 SAY "MENSAGEM:           CPF Digitado ‚ Inv lido !!!"
   TONE(300,3)
   SETCOLOR(COR)
   RETURN(.F.)
ELSE
   SETCOLOR(__COR(14))
   @ 23,11 CLEAR TO 23,77
   SETCOLOR(COR)
   RETURN(.T.)
ENDIF   
*****************************>> FIM DO ARQUIVO <<*****************************
