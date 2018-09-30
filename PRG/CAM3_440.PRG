*ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
*บ SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS          บ 
*บ VERSAO    : 1.1 - Copyright 1992                                       บ 
*บ PROGRAMA  : CAM3_440.PRG                                               บ 
*บ DESCRI€O : Programa de Listagem do Cadastro de Socios.                บ 
*บ AUTOR     : Marcelo Leal Limaverde Cabral                              บ 
*บ DATA      : 16/06/92                                                   บ
*ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
PRIVATE COR,TIPO,CONF,TELA1,TELA2,PARFIL
COR=SETCOLOR()
PRIVATE SEL1[4],SEL2[4],ORG1[2],NSEL,NVIAS,NSEL1,FILTRO,NORG,NORG1
SEL1[01]="Relatขrio Geral"
SEL1[02]="Nome do Sขcio  "
SEL1[03]="Nง do Sขcio    "
SEL1[04]="Aniversariantes"
ORG1[01]="Nome do Sขcio  "
ORG1[02]="Nง do Sขcio    "
STORE 1 TO NSEL,NORG,NSAI,NVIAS,CONF440
AFILL(SEL2,.F.)
STORE .T. TO SEL2[1],SEL2[2],SEL2[4]
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
         CASE NSEL=1 && ---------------->> GERAL
            FILTRO=" "
         CASE NSEL=2 && ---------------->> NOME DO SOCIO
            PARFIL=SPACE(33)
            SCROLL(15,02,17,46,0)
            JANELA(15,02,17,46)
            @ 15,05 SAY " Nome(s) do(s) Sขcio(s) Inicia(m) com: " 
            @ 16,07 GET PARFIL PICT "@!"
            SET CURSOR ON
            READ
            SET CURSOR OFF      
            IF LASTKEY()=27
               RESTSCREEN(11,02,17,70,TELA2)
               LOOP
            ENDIF   
            PARFIL=ALLTRIM(PARFIL)
            FILTRO="EAC(NOME_SOCIO)=EAC(PARFIL)"
         CASE NSEL=4 && ---------------->> ANIVERSARIANTES
            PARFIL=MONTH(DATE())
            SCROLL(15,02,17,43,0)
            JANELA(15,02,17,43)
            @ 16,04 SAY "Imprimir Sขcios Nascidos no Ms de:" GET PARFIL PICT "99";
                    RANGE 1,12
            SET CURSOR ON
            READ
            SET CURSOR OFF      
            IF LASTKEY()=27
               RESTSCREEN(11,02,17,70,TELA2)
               LOOP
            ENDIF   
            FILTRO="MONTH(ANIV_SOCIO)=PARFIL"
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
               DO CAM3_441 WITH NVIAS,NORG,NSEL,FILTRO
            CASE TIPO=4
*              DO CAM3_444 WITH NVIAS,NORG,NSEL,FILTRO
            ENDCASE
         ENDIF   
         RESTSCREEN(11,02,17,70,TELA2)
         LOOP
      ENDIF   
   ENDDO
ENDDO
SETCOLOR(COR)
RETURN
