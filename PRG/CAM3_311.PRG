******************************************************************************
* SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS              *
* VERSAO    : 1.1 - Copyright 1992                                           *
* PROGRAMA  : CAM3_311.PRG                                                   *
* DESCRI€AO : Formato de Tela para entrada e altera‡ao de dados das Fitas.   *
* AUTOR     : Marcelo Leal Limaverde Cabral                                  *
* DATA      : 08/09/92                                                       * 
******************************************************************************

COR=SETCOLOR()

@  5,  2  SAY "°°°°°°°°°°°°°°°°°°°°°°                                 °°°°°°°°°°°°°°°°°°°°°"
SETCOLOR(__COR(7))
@  5, 27  SAY "FICHA DE CADASTRO DE  FITAS"
@  7,  2  SAY "T¡tulo da Fita :"
@  7, 19  GET  TITULXFITA PICTURE '@!'VALID ! EMPTY(TITULXFITA)
@  7, 61  SAY "C¢digo :"
IF C=1
   @  7, 71  GET  CODIGOXG PICTURE '@!' VALID IF(LASTKEY()=5,.T.,GENERO())
   @  7, 73  SAY "-"
   @  7, 74  GET  NUMERXFITA PICTURE "9999" VALID NUMFITA()
ELSE
   @  7, 71  SAY  CODIGOXG+"-"+NUMERXFITA
ENDIF
@  8,  2  SAY "T¡tulo Original:"
@  8, 19  GET  TITULXORIG PICTURE '@!'
@  8, 61  SAY "Cod. do Pre‡o:"
@  8, 76  GET  CODIGOXP PICTURE '!!' VALID TSTPRC()
@  9,  2  SAY "Atores Princip.:"
@  9, 19  GET  ELENCXFITA PICTURE '@!'
@  9, 61  SAY "Pa¡s Origem :"
@  9, 75  GET  NACAOXFITA PICTURE '@!'
@ 10,  2  SAY "Diretor(es) ...:"
@ 10, 19  GET  DIRETXFITA PICTURE '@!'
@ 10, 61  SAY "Ano Produ‡„o:"
@ 10, 74  GET  ANOXLANC PICTURE '9999' VALID VAL(ANOXLANC)>1900
@ 11,  2  SAY "Fornecedor ....:"
@ 11, 19  GET  FORNEXFITA
@ 11, 61  SAY "N§ de C¢pias :"
@ 11, 76  GET  NUMXCOPIAS PICT'99' VALID NUMXCOPIAS>=COPIAXFORA.AND.!EMPTY(NUMXCOPIAS)
SETCOLOR(__COR(14))
SET KEY 27 TO
KEYB CHR(27)
MEMOEDIT(SINOPXFITA,14,10,19,70,.F.)
SETCOLOR(__COR(9))
@  6,  1  TO  6, 78
@  6,  0  SAY CHR(199)
@  6, 79  SAY CHR(182)
@ 13,  9  TO 20, 71  
@ 13,CENTRA('XSINOPSEX') SAY ' SINOPSE '
SETCOLOR(COR)
****>> EOF <<****
