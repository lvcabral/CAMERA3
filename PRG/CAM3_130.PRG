*浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
*� SISTEMA   : CAMERA 3 - SISTEMA DE CONTROLE DE VIDEO LOCADORAS           �
*� VERS�O    : 1.0 - Copyright 1991                                        �
*� PROGRAMA  : CAM3_130.PRG                                                �
*� DESCRI��O : Programa de Controle de Fichas de Credito.                  �
*� AUTOR     : Marcelo Leal Limaverde Cabral                               �
*� DATA      : 08/09/92                                                    �
*藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�

SET KEY 18 TO NULO
SET KEY 3  TO NULO

DO WHILE .T.

SETCOLOR(__COR(29))
@ 21,0 SAY ' [ESC]  VOLTA AO MENU ANTERIOR   �  '+CHR(24)+CHR(25)+CHR(27)+;
           CHR(26)+'  MOVEM A BARRA  �  [ENTER]  SELECIONA '

SETCOLOR(__COR(18))

@ 23,11 CLEA TO 23,78

@ 6,28 TO 12,52 DOUBLE

@ 07,29  PROMPT' Aquisi��o de Cr�ditos ' MESSAGE'Registra a Compra de Fichas de Cr�dito'
@ 08,28  SAY '�                       �'
@ 08,29 TO 08,51
@ 09,29  PROMPT' Corre��o nos Cr�ditos ' MESSAGE'Corrige os dados dos Cr�ditos dos S�cios'
@ 10,28  SAY '�                       �'
@ 10,29 TO 10,51
@ 11,29  PROMPT'   Imprime as Fichas   ' MESSAGE'Imprime as Fichas de Cr�dito'

MENU TO AC

DO CASE
 CASE AC=0
    SET KEY 18 TO 
    SET KEY 3  TO 
    RETURN
 CASE AC=1
 CASE AC=2
 CASE AC=3
ENDCASE
ENDDO
*****************************>> FIM DO ARQUIVO <<***************************** 
