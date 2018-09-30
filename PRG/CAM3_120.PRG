******************************************************************************
* SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS              *
* VERSŽO    : 1.1 - Copyright 1992                                           *
* PROGRAMA  : CAM3_120.PRG                                                   *
* DESCRI€ŽO : Programa de Devolu‡„o de Fitas da Locadora.                    *
* AUTOR     : Marcelo Leal Limaverde Cabral                                  *
* DATA      : 05/09/92                                                       *
******************************************************************************
SELECT E
USE PRECOS
SET INDEX TO PRECOS
SELECT D
USE CONTROLE
SET INDEX TO CONTROLE
SELECT C
USE FITAS
SET INDEX TO FITAS02,FITAS01,FITAS03
SET RELATION TO CODIGO_P INTO E
GO TOP
SELECT B
USE SOCIOS
SET INDEX TO SOCIOS02,SOCIOS01
SELECT A
USE COMPROV
SET INDEX TO COMPR01,COMPR02
SET RELATION TO LEFT(NUME_FITA1,2)+RIGHT(NUME_FITA1,4) INTO C,;
                ZIPS(NUME_SOCIO)+ZIPF(NUME_FITA1)      INTO D
GO TOP
BTOV()

SET CONFIRM OFF
SET KEY 18 TO NULO
SET KEY 3  TO NULO
COR=SETCOLOR()
TELA=SAVESCREEN(1,0,24,79)
SETCOLOR(__COR(7))
CPB(1,0,24,79)
DO WHILE .T.
  SETCOLOR(__COR(14))
  @ 24,0
  @ 24,1 SAY "MENSAGEM:"
  SETCOLOR(__COR(5))
  @  1,0 CLEAR TO  1,79
  @ 20,1 CLEAR TO 22,78
  TITULO="Devolu‡„o de Fitas"
  @  1, CENTRA(TITULO)  SAY TITULO
  @ 20, 45 SAY "SALDO  DEVEDOR Cr$"
  @ 21, 45 SAY "         MULTA Cr$"
  @ 22, 45 SAY "         TOTAL Cr$"
  SETCOLOR(__COR(13))
  @  2,  0  TO 23, 79    DOUBLE
  @  6,  1  TO  6, 78  
  @  4,  1  TO  4, 78    DOUBLE
  @  8,  1  TO  8, 78  
  TELACOMP(1)
  @  3,  6  GET  NUMEXCOMPR PICTURE "999999" VALID D_COMPR(NUMEXCOMPR)
  SET CURSOR ON
  READ
  SET CURSOR OFF
  IF LASTKEY()=27
     EXIT
  ENDIF
  REGINI=RECNO()
  ATOV()
  SETCOLOR(__COR(7))
  @  3, 31  SAY  STRZERO(NUMEXSOCIO,5)
  SELE B
  SEEK NUMEXSOCIO
  SELE A
  @  3, 44  SAY  B->NOME_SOCIO
  SETCOLOR(__COR(14))
  @ 24,11
  SETCOLOR(__COR(7))
  PRIVATE FOR_PAGA[5]
  FOR_PAGA[1]="24 horas"
  FOR_PAGA[2]="48 horas"
  FOR_PAGA[3]="S bado  "
  FOR_PAGA[4]="Especial"
  FOR_PAGA[5]="Teclado "
  @  5,17 SAY FOR_PAGA[FORMXPAGAM]
  @  5, 34  SAY  DATAXSAIDA
  @  5, 55  SAY  STRZERO(QTDEXDIAS,2)
  DATAXDEVOL=DATE()
  @  5, 70  SAY  DATAXPREVI
  DATAP=DATAXPREVI
  CF=0
  VLMULTA=0
  STOTAL=0
  PRIVATE NUMEFITA[10]
  SET ORDER TO 0
  DO WHILE A->NUME_COMPR=NUMEXCOMPR
     IF CF#0
        ATOV()
     ENDIF
     @ 09+CF, 8 SAY NUMEXFITA1 PICT"@! AA-9999"
     @ 09+CF,65 SAY VALOXFITA1 PICT"@E 999,999.99"
     CF=CF+1
     NUMEFITA[CF]=NUMEXFITA1
     STOTAL=STOTAL+VALOXFITA1
     @ 09+CF-1,20 SAY C->TITUL_FITA
     VLMULTA=VLMULTA+E->PRECO_MUL
     SELE A
     SKIP
  ENDDO
  SET ORDER TO 1
  MULTA=.T.
  STOTAL=IF(PAGOUX,0,STOTAL)
  DO WHILE MULTA
    SETCOLOR(__COR(1))
    @ 20,64 SAY STOTAL  PICTURE "@E 9999,999.99"
    IF DATE()>DATAP
       SETCOLOR(__COR(17))
       DIF=DATE()-DATAP
       TONE(300,3)
       @ 24,11 SAY " ATEN€AO !!! Fita(s) Devolvida(s) com Atrazo de ";
                   +LTRIM(STR(DIF,3))+" Dia(s)."
       SETCOLOR(__COR(7))
       VLMULTA=VLMULTA*DIF
       @ 21,64 GET VLMULTA PICTURE "@E 9999,999.99"
       SET CURSOR ON
       READ
       SET CURSOR OFF
    ELSE
       SETCOLOR(__COR(14))
       @ 24,11 CLEAR TO 24,79
       VLMULTA=0
    ENDIF
    TOTAL=STOTAL+VLMULTA
    SETCOLOR(__COR(1))
    @ 21,64 SAY VLMULTA PICTURE "@E 9999,999.99"
    @ 22,64 SAY TOTAL   PICTURE "@E 9999,999.99"
    DO WHILE .T.
       SETCOLOR(__COR(22))
       @ 24,11 CLEA TO 24,78
       @ 24,13 SAY 'Escolha a Op‡„o :'
       @ 24,COL()+2 PROMPT'Confirmar'
       @ 24,COL()+2 PROMPT'Imprimir'
       @ 24,COL()+2 PROMPT'Extornar'
       @ 24,COL()+2 PROMPT'Abandonar'
       MENU TO SAIC
       @ 24,11 CLEA TO 24,78
       DO CASE
       CASE SAIC=1
         SELE A
         SET ORDER TO 0
         GO REGINI
         FOR TF = 1 TO CF
            REPLACE C->COPIA_FORA WITH C->COPIA_FORA-1
            DELETE
            SKIP
         NEXT
         SET ORDER TO 1
         NUMEXCOMPR=0
         MULTA=.F.
         EXIT
       CASE SAIC=2
            IF MSG("Prepare a Impressora e aperte uma tecla para iniciar...",.t.,__cor(1))#27.AND.TESTA_IMP(__COR(24))
               CMPR_OLD=NUMEXCOMPR
               IMP_COMP()
            ENDIF
       CASE SAIC=3
         IF CONFIRMA("Deseja extornar este Comprovante ?",__cor(1),20)
           SELE A
           SET ORDER TO 0
           GO REGINI
           FOR TF = 1 TO CF
              SELE D
              IF ZTOD(DATA_ALUG)=A->DATA_SAIDA
                DELETE
              ENDIF
              SELE A
              REPLACE C->COPIA_FORA WITH C->COPIA_FORA-1
              DELETE
              SKIP
           NEXT
           SET ORDER TO 1
           NUMEXCOMPR=0
           MULTA=.F.
           EXIT
         ENDIF  
       CASE SAIC=4 .OR. SAIC=0
          MULTA=.F.
          EXIT
       ENDCASE
     ENDDO  
  ENDDO  
ENDDO
CLOSE DATA
RESTSCREEN(1,0,24,79,TELA)
SETCOLOR(COR)
SET KEY 18 TO
SET KEY 3  TO
SET CONFIRM ON
RETURN
****************
FUNCTION D_COMPR
****************
PARAM NC

CORF=SETCOLOR()

IF EMPTY(NC)
   SETCOLOR(__COR(14))
   @ 24,11
   @ 24,11 SAY " N£mero de Comprovante n„o pode ser Zero ."
   SETCOLOR(CORF)
   TONE(300,3)
   RETURN(.F.)
ENDIF   
   
SEEK NC
IF FOUND()
   SELE A
   SETCOLOR(__COR(14))
   @ 24,11
   SETCOLOR(CORF)
   RETURN(.T.)
ELSE
   SELE A
   SETCOLOR(__COR(14))
   @ 24,11
   @ 24,11 SAY " N£mero de Comprovante n„o existe no Cadastro ."
   SETCOLOR(CORF)
   TONE(300,3)
   RETURN(.F.)
ENDIF   
******************************>> FIM DO ARQUIVO <<*****************************
