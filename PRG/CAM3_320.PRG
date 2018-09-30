******************************************************************************
* SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS              * 
* VERSAO    : 1.1 - Copyright 1992                                           * 
* PROGRAMA  : CAM3_320.PRG                                                   *
* DESCRI€AO : Programa para Altera‡„o de Dados das Fitas.                    *
* AUTOR     : Marcelo Leal Limaverde Cabral                                  *
* DATA      : 08/09/92                                                       * 
******************************************************************************
SET FORMAT TO
COR=SETCOLOR()
DO WHILE .T.
   SETCOLOR(COR)
   @  5,  2  SAY "°°°°°°°°°°°°°°°°°°°°°°                                 °°°°°°°°°°°°°°°°°°°°°"
   SETCOLOR(__COR(7))
   @  5, 27  SAY "FICHA DE CADASTRO DE  FITAS"
   @  7,  2  SAY "T¡tulo da Fita :"
   @  7, 19  SAY SPACE(40)
   @  7, 61  SAY "C¢digo :"
   @  7, 71  SAY SPACE(07)
   @  8,  2  SAY "T¡tulo Original:"
   @  8, 19  SAY SPACE(40)
   @  8, 61  SAY "Cod. do Pre‡o:"
   @  8, 76  SAY SPACE(02)
   @  9,  2  SAY "Atores Princip.:"
   @  9, 19  SAY SPACE(40)
   @  9, 61  SAY "Pa¡s Origem :"
   @  9, 75  SAY SPACE(3)
   @ 10,  2  SAY "Diretor(es) ...:"
   @ 10, 19  SAY SPACE(40)
   @ 10, 61  SAY "Ano Produ‡„o:"
   @ 10, 74  SAY SPACE(04)
   @ 11,  2  SAY "Fornecedor ....:"
   @ 11, 19  SAY SPACE(40)
   @ 11, 61  SAY "N§ de C¢pias :"
   @ 11, 76  SAY SPACE(02)
   SETCOLOR(COR)
   @  6,  1  TO  6, 78
   @  6,  0  SAY CHR(199)
   @  6, 79  SAY CHR(182)
   @ 13,  9  TO 20, 71  
   @ 13,CENTRA('XSINOPSEX') SAY ' SINOPSE '
   SETCOLOR(__COR(14))
   @ 14,10 CLEAR TO 19,70
   SETCOLOR(cor)
   @ 21,CENTRA("X[F4] - PROCURAX") SAY " [F4] - PROCURA "
   SET KEY 27 TO
   SET KEY -3 TO LOOK_FOR
   @  7, 19  GET  TITULXFITA PICTURE "@!"
   SET CURSOR ON
   READ
   SET CURSOR OFF
   SET ORDER TO 1
   IF ! (DBSEEK(EAC(TITULXFITA),.T.))
      IF TITULXFITA#SPACE(40)
         SETCOLOR(__COR(14))
         @ 23,2 SAY 'MENSAGEM:                 TITULO NŽO ENCONTRADO'
      ENDIF   
      SETCOLOR(__COR(7))
      @ 07,19 CLEAR TO 07,58
      @  7, 71  GET  CODIG_FITA PICTURE "@! AA-9999"
      SET CURSOR ON
      READ
      SET CURSOR OFF
      IF CODIG_FITA=SPACE(7).AND.TITULXFITA=SPACE(40)
         SET KEY -3 TO
         RETURN
      ENDIF
      SET ORDER TO 2
      ACHA=LEFT(CODIG_FITA,2)+SUBSTR(CODIG_FITA,4)
      SEEK ACHA
      IF .NOT. FOUND()
         SETCOLOR(__COR(14))
         @ 23,2 SAY 'MENSAGEM:            FITA NAO CADASTRADA -  APERTE UMA TECLA ...'
         INKEY(0)
         TITULXFITA=SPACE(40)
         CODIG_FITA=SPACE(07)
         @ 23,11 CLEAR TO 23,77
         SETCOLOR(__COR(1))
         LOOP
      ENDIF
   ENDIF
   SETCOLOR(COR)
   @ 4,0 TO 21,79 DOUBLE 
   SETCOLOR(__COR(14))
   SET KEY 27 TO NULO
   SET KEY -3 TO
   @ 23,11 CLEAR TO 23,77
   SETCOLOR(COR)
   RETURN      
ENDDO
****>> EOF <<****
