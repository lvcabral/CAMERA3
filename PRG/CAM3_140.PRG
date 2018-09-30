*ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
*บ SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS           บ
*บ VERSO    : 1.1 - Copyright 1992                                        บ
*บ PROGRAMA  : CAM3_140.PRG                                                บ
*บ DESCRI€O : Programa de Utilit rios do Sistema.                         บ
*บ AUTOR     : Marcelo Leal Limaverde Cabral                               บ
*บ DATA      : 05/09/92                                                    บ
*ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

SET KEY 18 TO NULO
SET KEY 3  TO NULO
PRIVATE TELA
DO WHILE .T.

  SETCOLOR(__COR(29))
  @ 21,0 SAY ' [ESC]  VOLTA AO MENU ANTERIOR   บ  '+CHR(24)+CHR(25)+CHR(27)+;
             CHR(26)+'  MOVEM A BARRA  บ  [ENTER]  SELECIONA '
  SETCOLOR(__COR(18))
  @ 23,11 CLEA TO 23,78
  @ 6,28 TO 16,52 DOUBLE
  @ 07,29  PROMPT'  Organizar Arquivos   ' MESSAGE'Reindexa todos os Arquivos do Sistema'
  @ 08,28  SAY 'ว                       ถ'
  @ 08,29 TO 08,51
  @ 09,29  PROMPT'  Backup de Segurana  ' MESSAGE'Copia os Arquivos em Diskete'
  @ 10,28  SAY 'ว                       ถ'
  @ 10,29 TO 10,51
  @ 11,29  PROMPT'    Restaura Backup    ' MESSAGE'Recupera os Arquivos em Diskete'
  @ 12,28  SAY 'ว                       ถ'
  @ 12,29 TO 12,51
  @ 13,29  PROMPT'    Data do Sistema    ' MESSAGE'Altera a Data do Sistema'
  @ 14,28  SAY 'ว                       ถ'
  @ 14,29 TO 14,51
  @ 15,29  PROMPT'    Hora do Sistema    ' MESSAGE'Altera a Hora do Sistema'
 
  MENU TO AC

  DO CASE
  CASE AC=0
    SET KEY 18 TO 
    SET KEY 3  TO 
    RETURN
  CASE AC=1
    TELA=MSG("ARQUIVO -> SOCIOS......",.F.,__COR(1))
    USE SOCIOS
    INDEX ON EAC(NOME_SOCIO) TO SOCIOS01
    INDEX ON NUME_SOCIO TO SOCIOS02
    MSG("ARQUIVO -> FITAS.......",.F.,__COR(1))
    USE FITAS
    INDEX ON DESCEND(STR(ROUND(NUMER_SAID/(NUM_COPIAS+0.0000001),2),2))+CODIGO_G+NUMER_FITA TO FITAS03
    INDEX ON EAC(TITUL_FITA) TO FITAS01
    INDEX ON CODIGO_G+NUMER_FITA  TO FITAS02
    MSG("ARQUIVO -> COMPROVANTES",.F.,__COR(1))
    USE COMPROV
    PACK
    INDEX ON NUME_COMPR TO COMPR01
    INDEX ON STR(NUME_SOCIO,5)+STR(NUME_COMPR,6) TO COMPR02
*   INDEX ON NUME_FITA1+STR(NUME_COMPR,6) TO COMPR03
    MSG("ARQUIVO -> CONTROLE....",.F.,__COR(1))
    USE CONTROLE
    PACK
    INDEX ON NUME_SOCIO+CODI_FITA TO CONTROLE
    MSG("ARQUIVO -> GENERO......",.F.,__COR(1))
    USE GENERO_F
    INDEX ON CODIGO_G TO GENERO_F
    MSG("ARQUIVO -> PRE€OS......",.F.,__COR(1))
    USE PRECOS
    INDEX ON CODIGO_P TO PRECOS
    CLOSE DATA
    RESTSCREEN(11,0,13,79,TELA)
 CASE AC=2
    TELA=SAVESCREEN(6,54,11,63)
    @ 06,54 CLEAR TO 11,63 
    @ 06,54 TO 11,63 
    @ 07,55 SAY " DRIVE: " 
    @ 08,55 TO 08,62 
    @ 09,55 PROMPT "   A:   " 
    @ 10,55 PROMPT "   B:   " 
    MENU TO NDRV
    IF NDRV=0
      RESTSCREEN(6,54,11,63,TELA)
      LOOP
    ENDIF
    FBACKUP("*.DB?",NDRV,13,28,__COR(1),__COR(5),__COR(28))
    RESTSCREEN(6,54,11,63,TELA)
 CASE AC=3
    TELA=SAVESCREEN(6,54,11,63)
    @ 06,54 CLEAR TO 11,63 
    @ 06,54 TO 11,63 
    @ 07,55 SAY " DRIVE: " 
    @ 08,55 TO 08,62 
    @ 09,55 PROMPT "   A:   " 
    @ 10,55 PROMPT "   B:   " 
    MENU TO NDRV
    IF NDRV=0
      RESTSCREEN(6,54,11,63,TELA)
      LOOP
    ENDIF
    FRESTORE(NDRV,3,13,28,__COR(1),__COR(5),__COR(28))
    RESTSCREEN(6,54,11,63,TELA)
 CASE AC=4
    TELA=SAVESCREEN(6,54,19,73)
    @ 06,54 CLEAR TO 08,73
    @ 06,54 TO 08,73
    DATA=DATE()
    @ 07,56 SAY "DATA ->"
    @ 07,64 GET DATA VALID DATA>=CTOD("01/01/92") 
    SET CURSOR ON
    READ
    SET CURSOR OFF
    DATA(DATA)
    SETCOLOR(__COR(14))
    @ 0,67 SAY LEFT(DIA(DATE()),3)+" "+DTOC(DATE())
    RESTSCREEN(6,54,19,73,TELA)
 CASE AC=5
    TELA=SAVESCREEN(6,54,19,73)
    @ 06,54 CLEAR TO 08,73
    @ 06,54 TO 08,73
    HORA=TIME()
    @ 07,56 SAY "HORA ->"
    @ 07,64 GET HORA PICTURE "99:99:99" VALID HORA(HORA)
    SET CURSOR ON
    READ
    SET CURSOR OFF
    SETCOLOR(__COR(14))
    RESTSCREEN(6,54,19,73,TELA)
ENDCASE
ENDDO
*****************************>> FIM DO ARQUIVO <<***************************** 
