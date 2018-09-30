*ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
*บ SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS          บ 
*บ VERSAO    : 1.1 - Copyright 1992                                       บ 
*บ PROGRAMA  : CAM3_434.PRG                                               บ 
*บ DESCRI€O : Programa de Listagem de Etiquetas c/ codigo de Barras.     บ 
*บ AUTOR     : Marcelo Leal Limaverde Cabral                              บ 
*บ DATA      : 06/10/92                                                   บ
*ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
PARAMETERS NVIAS,NORG,FILTRO
SELE C
USE PRECOS INDEX PRECOS
SELE B
USE GENERO_F INDEX GENERO_F
SELE A
USE FITAS INDEX FITAS01,FITAS02
SET FILTER TO &FILTRO
SET ORDER TO NORG
SET RELATION TO CODIGO_G INTO B, TO CODIGO_P INTO C
RESTORE FROM CAM3.CFG ADDITIVE
SET PRINT ON
SET CONSOLE OFF
PRIVATE E[CF_EL],D[CF_EL],TIT[6*CF_EL],V
FOR V = 1 TO NVIAS
   GO TOP
   NCOP=0
   DO WHILE .NOT. EOF()
    CONT=0
    DDIF=0
    FOR TT = 1 TO CF_EL
       IF NCOP==A->NUM_COPIAS
          SKIP 1
          IF EOF()
             EXIT
          ENDIF
          NCOP=1
       ELSE
          NCOP++
       ENDIF   
       E[TT]=STR(ASC(LEFT(CODIGO_G,1)),2)+STR(ASC(RIGHT(CODIGO_G,1)),2)+"0"
       D[TT]=STRZERO(VAL(NUMER_FITA),5)
       TIT[1+DDIF]=PADR(EAC(LEFT(TITUL_FITA,30)),30)
       TIT[2+DDIF]=PADR(EAC(RIGHT(TITUL_FITA,10)),10)+SPACE(20)
       TIT[3+DDIF]=CODIGO_G+"-"+NUMER_FITA+"   - "+PADR(EAC(B->TITULO_G),15)
       TIT[4+DDIF]="ANO: "+ANO_LANC+" - PAIS: "+NACAO_FITA
       TIT[5+DDIF]=" "
       TIT[6+DDIF]=PADR(EAC(C->TITULO_P),15)+"   COPIA No. "+STRZERO(NCOP,2)
       CONT=CONT+1
       IMPRIME=PAUSA(__cor(24))
       IF .NOT. IMPRIME
          EXIT
       ENDIF
       DDIF=DDIF+6   
    NEXT   
    IF IMPRIME
       CODBARR(E,D,TIT,CONT)
    ELSE
       EXIT
    ENDIF   
   ENDDO
NEXT   
SET PRINT OFF
SET CONSOLE ON
SET DEVICE TO SCREEN
CLOSE DATA
RETURN   
