*ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
*บ SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS          บ 
*บ VERSAO    : 1.1 - Copyright 1992                                       บ 
*บ PROGRAMA  : CAM3_430.PRG                                               บ 
*บ DESCRI€O : Programa de Listagem do Acervo de Fitas.                   บ 
*บ AUTOR     : Marcelo Leal Limaverde Cabral                              บ 
*บ DATA      : 08/09/92                                                   บ
*ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
PRIVATE COR,TIPO,CONF,TELA1,TELA2,PARFIL
COR=SETCOLOR()
PRIVATE SEL1[10],SEL2[10],ORG1[2],NSEL,NVIAS,NSEL1,FILTRO,NORG,NORG1
SEL1[01]="Relatขrio Geral"
SEL1[02]="Gnero         "
SEL1[03]="Cขdigo da Fita " && array[99]
SEL1[04]="Tกtulo da Fita " && = "xx"
SEL1[05]="Tกtulo Original" && = "xx"
SEL1[06]="Diretor(es)    " && = "xx"
SEL1[07]="Atores Princip." 
SEL1[08]="Paกs de Origem "
SEL1[09]="Cขdigo de Preo"
SEL1[10]="Fornecedor     "
ORG1[01]="Tกtulo da Fita "
ORG1[02]="Cขdigo da Fita "
STORE 1 TO NSEL,NORG,NSAI,NVIAS,CONF430
AFILL(SEL2,.F.)
STORE .T. TO SEL2[1],SEL2[2],SEL2[4],SEL2[9]
DO WHILE .T.
   TIPO=MENURELAT()
   IF TIPO=0
      SETCOLOR(COR)
      RETURN
   ENDIF
   TELA1=SAVESCREEN(06,30,12,78)
   DO WHILE .T.
      MENUSELEC()
      IF CONF=0
         EXIT
      ENDIF
      IF CONF=4
         TELA2=SAVESCREEN(11,2,17,70)
         DO CASE
         CASE NSEL=1 && GERAL
            FILTRO=" "
         CASE NSEL=2 && GENERO
            PARFIL=SPACE(2)
            SCROLL(15,02,17,60,0)
            JANELA(15,02,17,60)
            @ 16,04 SAY "Imprimir Todas as Fitas do Gnero:" GET PARFIL PICT "@!";
                        VALID IMPGEN(PARFIL)
            SET CURSOR ON
            READ
            SET CURSOR OFF      
            IF LASTKEY()=27
               RESTSCREEN(11,02,17,70,TELA2)
               LOOP
            ENDIF   
            FILTRO="CODIGO_G=PARFIL"
         CASE NSEL=4 && TITULO DAS FITAS
            PARFIL=SPACE(40)
            SCROLL(15,02,17,46,0)
            JANELA(15,02,17,46)
            @ 15,05 SAY " Tกtulo(s) da(s) Fita(s) Inicia(m) com: " 
            @ 16,04 GET PARFIL PICT "@!"
            SET CURSOR ON
            READ
            SET CURSOR OFF      
            IF LASTKEY()=27
               RESTSCREEN(11,02,17,70,TELA2)
               LOOP
            ENDIF   
            PARFIL=ALLTRIM(PARFIL)
            FILTRO="TITUL_FITA=PARFIL"
         CASE NSEL=9 && CODIGO DE PRECO
            PARFIL=SPACE(2)
            SCROLL(15,02,17,66,0)
            JANELA(15,02,17,66)
            @ 16,04 SAY "Imprimir as Fitas do Cขdigo de Preo:" GET PARFIL PICT "@! AA";
                        VALID IMPPRE(PARFIL)
            SET CURSOR ON
            READ
            SET CURSOR OFF      
            IF LASTKEY()=27
               RESTSCREEN(11,02,17,70,TELA2)
               LOOP
            ENDIF   
            FILTRO="CODIGO_P=PARFIL"
         OTHER
            FILTRO=" "
         ENDCASE   
         IF MSG("Prepare a Impressora e Aperte uma Tecla ....",.T.,__COR(1))=27
            RESTSCREEN(11,02,17,70,TELA2)
            LOOP
         ENDIF       
         IF TESTA_IMP(__cor(24))
            MSG("  ****  IMPRIMINDO ......... [ESC] - Pausa na Impresso",.F.,__COR(1))
            DO CASE
            CASE TIPO=1
               DO CAM3_431 WITH NVIAS,NORG,FILTRO
            CASE TIPO=4
               DO CAM3_434 WITH NVIAS,NORG,FILTRO
            ENDCASE
         ENDIF   
         RESTSCREEN(11,02,17,70,TELA2)
         LOOP
      ENDIF   
   ENDDO
ENDDO
SETCOLOR(COR)
RETURN
***********
FUNC IMPGEN
***********
PARAM GEN
USE GENERO_F INDEX GENERO_F
SEEK GEN
IF FOUND()
   @ 16,43 SAY "- "+TITULO_G
   USE
   RETURN(.T.)
ELSE
   USE
   TONE(300,3)
   RETURN(.F.)
ENDIF
***********
FUNC IMPPRE
***********
PARAM PRE
USE PRECOS INDEX PRECOS
SEEK PRE
IF FOUND()
   @ 16,44 SAY "- "+TITULO_P
   USE
   RETURN(.T.)
ELSE
   USE
   TONE(300,3)
   RETURN(.F.)
ENDIF
