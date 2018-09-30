@echo off
CLS
clipper CAM3
IF ERRORLEVEL 1 GOTO ERRO
Blinker FI CAM3 SEARCH PROGRAPH,PDP,EXTEND,dbfcdx,_dbfcdx OUTPUT CAM3.EXE
echo ******  Final da Compila‡„o  ******
GOTO FIM
:ERRO
echo ****** Erro na Compila‡„o ******
:FIM
