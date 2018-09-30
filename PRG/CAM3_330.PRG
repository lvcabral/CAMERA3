******************************************************************************
* SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS              *
* VERSŽO    : 1.1 - Copyright 1992                                           *
* PROGRAMA  : CAM3_330.PRG                                                   *
* DESCRI€ŽO : Programa de Informa‡”es sobre o Cadastro de Fitas.             *
* AUTOR     : Marcelo Leal Limaverde Cabral                                  *
* DATA      : 08/09/92                                                       *
******************************************************************************

TELA=SAVESCREEN(3,0,24,79)
SET KEY 18 TO NULO
SET KEY 3  TO NULO
DO WHILE .T.

SETCOLOR(__COR(29))
@ 21,0 SAY ' [ESC]  VOLTA AO MENU ANTERIOR   º  '+CHR(24)+CHR(25)+CHR(27)+;
           CHR(26)+'  MOVEM A BARRA  º  [ENTER]  SELECIONA '

SETCOLOR(__COR(27))

JANELA(12,35,18,62)

SETCOLOR(__COR(18))

@ 23,11 CLEA TO 23,78

@ 13,36  PROMPT' A. Consulta por C¢digo   ' MESSAGE'Consulta o acervo de fitas organizado pelo C¢digo'
@ 14,36 TO 14,61
@ 15,36  PROMPT' B. Consulta por T¡tulo   ' MESSAGE'Trabalha o acervo de fitas organizado pelo T¡tulo'
@ 16,36 TO 16,61
@ 17,36  PROMPT' C. Gr fico Estat¡stico   ' MESSAGE'Desenha um gr fico de saidas por t¡tulos'

MENU TO CC

DO CASE
 CASE CC=0
    SET KEY 18 TO 
    SET KEY 3  TO 
    RESTSCREEN(3,0,24,79,TELA)
    RELEASE CONTDBF
    RETURN
 CASE CC<3
    SELE C
    USE PRECOS
    SET INDEX TO PRECOS

    SELE B
    USE GENERO_F
    SET INDEX TO GENERO_F

    SELE A
    USE FITAS
    SET INDEX TO FITAS01,FITAS02,FITAS03
    SET RELATION TO CODIGO_G INTO B , TO CODIGO_P INTO C

    DO CASE
    CASE CC=1
       SET ORDER TO 2
    CASE CC=2
       SET ORDER TO 1
    ENDCASE
    
    GO TOP
    
    DO CONSFIT

 CASE CC=3
    DO CAM3_333
ENDCASE
ENDDO

*****************
PROCEDURE CONSFIT
*****************
    T103=SAVESCREEN(4,0,21,79)
    C103=SETCOLOR()
    @ 23,11 CLEAR TO 23,78
    SETCOLOR(__COR(11))
    @ 20,0
    DECLARE CAMPOS[7],TITULOS[7],BARRAV[6]
    IF INDEXORD()=1
       NU=2
       NN=1
    ELSE
       NU=1
       NN=2
    ENDIF      
    CAMPOS[NU]="A->CODIGO_G+'-'+A->NUMER_FITA"
    CAMPOS[NN]="A->TITUL_FITA"
    CAMPOS[03]="IF(A->NUM_COPIAS>A->COPIA_FORA,STR(A->NUM_COPIAS-A->COPIA_FORA,2)+' Copias','<Nenhuma>')"
    CAMPOS[04]="C->TITULO_P"
    CAMPOS[05]="B->TITULO_G"
    CAMPOS[06]="A->DIRET_FITA"
    CAMPOS[07]="A->ELENC_FITA"
    TITULOS[NU]="COD.FITA"
    TITULOS[NN]="TITULO"
    TITULOS[03]="DISPONIBILIDADE"
    TITULOS[04]="CODIGO DE PRE€O"
    TITULOS[05]="GENERO"
    TITULOS[06]="DIRETOR(ES)"
    TITULOS[07]="ATORES PRINCIPAIS"
    Posi:=1

    *BarraV=ScrollBarNew(4,79,19,__Cor(1),Posi)
    
    SETCOLOR(__COR(9))
    SCROLL(4,0,19,79,0)
    @ 4,0 TO 19,79 DOUBLE
    CONSUL="ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ   C O N S U L T A   D E   F I T A S   ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
    @ 5,CENTRA(CONSUL) SAY CONSUL
    @ 6,0 SAY CHR(204)+REPL(CHR(205),78)+CHR(185)
    SETCOLOR(__COR(29))

    @ 21,0 SAY'  [ESC] VOLTA º  [F4] PROCURA  º  [ENTER] DETALHA  º  [I] INICIO  º  [F] FINAL  '

    SETCOLOR(__COR(7))
    @ 8,1 SAY REPL(CHR(205),78)
    
    SET KEY 18 TO 
    SET KEY 3  TO 
    
    *ScrollBarDisplay(BarraV)
    DBEDIT(7,2,18,77,CAMPOS,"INFIT","",TITULOS)
    
    SET KEY 18 TO NULO
    SET KEY 3  TO NULO

    CLOSE DATA 
    SETCOLOR(C103)
    RESTSCREEN(4,0,21,79,T103)
    RETURN

**************
FUNCTION INFIT
**************

PARAM MODO,I

PRIVA CAMPO,NREG

CAMPO=CAMPOS[I]
if Lastkey()=31.or.Upper(Chr(Lastkey()))="I".or.modo=1
  Posi=1
elseif Lastkey()=30.or.Upper(Chr(Lastkey()))="F".or.modo=2
  Posi=Lastrec()
elseif Lastkey()=5.and.Posi>1
  Posi--
elseif Lastkey()=24.and.Posi<LastRec()
  Posi++
elseif Lastkey()=18
  Posi-=10
  Posi=Max(1,Posi)
elseif Lastkey()=3
  Posi+=10
  Posi=Min(Lastrec(),Posi)       
endif
*ScrollBarUpdate(BarraV,Posi,LastRec(),.t.)
DO CASE
   CASE MODO<4
        IF MODO=2.OR.MODO=1
          TONE(400,2)
          RETURN(1)
        ELSEIF MODO=3
          RETURN(0)
         ENDIF
       RETURN(1)
   CASE LASTKEY()=27
       RETURN(0)
   CASE LASTKEY() = -3
       IF INDEXORD()=2
        CCOR=SETCOLOR()
        SETCOLOR(__COR(21))
        VAI=SPACE(07)
        REF=CENTRA(REPL("X",22))
        @ 23,REF SAY 'Cod. da Fita :'GET VAI PICT"@! AA-9999"
        SET CURSOR ON
        READ
        SET CURSOR OFF
        @ 23,11 CLEAR TO 23,70
        IF LASTKEY()#27
           NREG=RECNO()
           SEEK ALLTRIM(LEFT(VAI,2)+RIGHT(VAI,4))
           IF ! FOUND()
              TONE(300,3)
              GO NREG
           ENDIF
        ENDIF   
        SETCOLOR(CCOR)
       ELSE 
        CCOR=SETCOLOR()
        SETCOLOR(__COR(21))
        VAI=SPACE(40)
        REF=CENTRA(REPL("X",56))
        @ 23,REF SAY 'T¡tulo da Fita :'GET VAI PICT"@!"
        SET CURSOR ON
        READ
        SET CURSOR OFF
        @ 23,11 CLEAR TO 23,70
        IF LASTKEY()#27
           NREG=RECNO()
           VAI=ALLTRIM(EAC(VAI))
           DBSEEK(VAI,.T.)
           IF EOF()
              TONE(300,3)
              GO NREG
           ENDIF
        ENDIF   
        SETCOLOR(CCOR)
       ENDIF 
       RETURN(1)
   CASE LASTKEY() = 13
        PRIVATE DETELA
        CCOR=SETCOLOR()
        SAVE SCREEN TO DETELA
        ATOV()
        SETCOLOR(__COR(9))
        CAIXOUT(12,39,13,40)
        DO CAM3_311
        CLEAR GETS
        MENS="Aperte uma Tecla para Continuar ...."
        SETCOLOR(__COR(21))
        @ 23,CENTRA(MENS) SAY MENS
        INKEY(0)
        RESTORE SCREEN FROM DETELA
        SETCOLOR(CCOR)
        RETURN(2)
   CASE UPPER(CHR(LASTKEY())) = "I"
        GO TOP
        RETURN(1)
   CASE UPPER(CHR(LASTKEY())) = "F"
        IF DBFILTER()=""
           KEYBOARD CHR(30)
        ELSE   
           GO BOTTOM        
        ENDIF   
        RETURN(1)
   OTHER
       RETURN(1)
ENDCASE
******************************>> FIM DO ARQUIVO <<*****************************
