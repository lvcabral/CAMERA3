******************************************************************************
* SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS              * 
* VERSAO    : 1.0 - Copyright 1991                                           * 
* PROGRAMA  : CAM3_211.PRG                                                   *
* DESCRI€AO : Formato de Tela para entrada e altera‡ao de dados dos Socios.  *
* AUTOR     : Marcelo Leal Limaverde Cabral                                  *
* DATA      : 26/02/92                                                       * 
******************************************************************************
COR=SETCOLOR()
@  5,  2  SAY "°°°°°°°°°°°°°°°°°°°°°°                                 °°°°°°°°°°°°°°°°°°°°°"
SETCOLOR(__COR(1))
@  5, 27  SAY "FICHA DE CADASTRO DE SOCIOS"
@ 07,  4  SAY "NOME  :"
@ 07, 12  GET  NOMEXSOCIO PICTURE "@!"    VALID NOMEXSOCIO#SPACE(33)
@ 07, 47  SAY "NUMERO:"
IF B=1
   @ 07, 55  GET  NUMEXSOCIO PICTURE "99999" VALID NSOC()
ELSE
   @ 07, 55  SAY  STRZERO(NUMEXSOCIO,5) 
ENDIF
@ 09,  4  SAY "ENDER.:"
@ 09, 12  GET  ENDEXSOCIO 
@ 09, 47  SAY "BAIRRO:"
@ 09, 55  GET  BAIRXSOCIO
@ 11,  4  SAY "CIDADE:"
@ 11, 12  GET  CIDAXSOCIO  PICTURE "@!"
@ 11, 35  SAY "ESTADO:"
@ 11, 43  GET  ESTAXSOCIO  PICTURE "@!"
@ 11, 47  SAY "C.E.P.:"
@ 11, 55  GET  CEPX_SOCIO  PICTURE "99.999"
@ 11, 62  SAY "FONE :"
@ 11, 68  GET  FONEXSOCIO  PICTURE "999-9999"
@ 13,  4  SAY "C.P.F.:"
@ 13, 12  GET  CPFX_SOCIO  PICTURE "999.999.999-99" VALID TESTCPF(CPFX_SOCIO)
@ 13, 28  SAY "IDENTIDADE:" 
@ 13, 40  GET  IDENXSOCIO  PICTURE "@!"
@ 13, 57  SAY "DATA NASC.:"
@ 13, 68  GET  ANIVXSOCIO
@ 16, 11  SAY "DEPENDENTE N§ 1"
@ 17,  4  GET  DEP1XSOCIO  PICTURE "@!"
IF CF_ND >= 2
   @ 16, 53  SAY "DEPENDENTE N§ 2"
   @ 17, 46  GET  DEP2XSOCIO  PICTURE "@!"
ENDIF
IF CF_ND >= 3
   @ 19, 11  SAY "DEPENDENTE N§ 3"
   @ 20,  4  GET  DEP3XSOCIO  PICTURE "@!"
ENDIF
IF CF_ND >= 4
   @ 19, 53  SAY "DEPENDENTE N§ 4"
   @ 20, 46  GET  DEP4XSOCIO  PICTURE "@!"
ENDIF
SETCOLOR(COR)
@  6,  1  TO  6, 78
@  6,  0  SAY CHR(199)
@  6, 79  SAY CHR(182)
@ 14, 01  SAY REPL('_',78)
****>> EOF <<****
