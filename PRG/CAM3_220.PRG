******************************************************************************
* SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS              *
* VERSAO    : 1.1 - Copyright 1992                                           *
* PROGRAMA  : CAM3_220.PRG                                                   *
* DESCRI€AO : Programa para Altera‡„o de Dados dos Socios.                   *
* AUTOR     : Marcelo Leal Limaverde Cabral                                  *
* DATA      : 04/09/92                                                       *
******************************************************************************
SET CONFIRM OFF
COR=SETCOLOR()
DO WHILE .T.
SETCOLOR(COR)
@  5,  2  SAY "°°°°°°°°°°°°°°°°°°°°°°                                 °°°°°°°°°°°°°°°°°°°°°"
SETCOLOR(__COR(1))
@  5, 27  SAY "FICHA DE CADASTRO DE SOCIOS"
@ 07,  4  SAY "NOME  :"+SPACE(34)
@ 07, 47  SAY "NUMERO:"+SPACE(6)
@ 09,  4  SAY "ENDER.:"+SPACE(34)
@ 09, 47  SAY "BAIRRO:"+SPACE(22)
@ 11,  4  SAY "CIDADE:"+SPACE(22)
@ 11, 35  SAY "ESTADO:"+SPACE(3)
@ 11, 47  SAY "C.E.P.:"+SPACE(7)
@ 11, 62  SAY "FONE :"+SPACE(9)
@ 13,  4  SAY "C.P.F.:"+SPACE(15)
@ 13, 28  SAY "IDENTIDADE:"+SPACE(15)
@ 13, 57  SAY "DATA NASC.:"+SPACE(9)
@ 16, 11  SAY "DEPENDENTE N§ 1"
@ 17,  4  SAY  SPACE(30)
IF CF_ND >= 2
   @ 16, 53  SAY "DEPENDENTE N§ 2"
   @ 17, 46  SAY  SPACE(30)
ENDIF
IF CF_ND >= 3
   @ 19, 11  SAY "DEPENDENTE N§ 3"
   @ 20,  4  SAY  SPACE(30)
ENDIF
IF CF_ND >= 4
   @ 19, 53  SAY "DEPENDENTE N§ 4"
   @ 20, 46  SAY  SPACE(30)
ENDIF
SETCOLOR(COR)
@  6,  1  TO  6, 78
@  6,  0  SAY CHR(199)
@  6, 79  SAY CHR(182)
@ 14, 01  SAY REPL('_',78)
SETCOLOR(__COR(1))
SET KEY -3 TO LOOK_FOR
SET KEY 27 TO
@ 21,CENTRA("X[F4] - PROCURAX") SAY " [F4] - PROCURA "
@ 07, 12  GET  NOMERSOCIO PICTURE "@!"
SET CURSOR ON
READ
SET CURSOR OFF
SET ORDER TO 1
IF ! (DBSEEK(EAC(NOMERSOCIO),.T.)) 
   IF NOMERSOCIO#SPACE(33)
      SETCOLOR(__COR(14))
      @ 23,2 SAY 'MENSAGEM:                    Nome Nao Encontrado'
   ENDIF
   SETCOLOR(__COR(1))
   @ 07,12 CLEAR TO 07,45
   @ 07, 55  GET  NUMERSOCIO PICTURE "99999"
   SET CURSOR ON
   READ
   SET CURSOR OFF
   IF (NUMERSOCIO=0.AND.NOMERSOCIO=SPACE(33)) .OR. LASTKEY()=27
      SET KEY -3 TO
      RETURN
   ENDIF
   SET ORDER TO 2
   SEEK NUMERSOCIO
   IF .NOT. FOUND()
      SETCOLOR(__COR(14))
      @ 23,2 SAY 'MENSAGEM:           S¢cio Nao Cadastrado -  Aperte uma Tecla ...'
      INKEY(0)
      NOMERSOCIO=SPACE(33)
      NUMERSOCIO=0
      @ 23,11 CLEAR TO 23,77
      SETCOLOR(__COR(1))
      LOOP
   ENDIF
ENDIF
SETCOLOR(COR)
@ 4,0 TO 21,79 DOUBLE
SETCOLOR(__COR(14))
@ 23,11 CLEAR TO 23,77
SET KEY -3 TO
SETCOLOR(COR)
RETURN
ENDDO
****>> EOF <<****
