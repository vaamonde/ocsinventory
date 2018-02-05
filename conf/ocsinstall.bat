@echo off
rem Autor: Robson Vaamonde
rem Site: www.procedimentosemti.com.br
rem Facebook: facebook.com/ProcedimentosEmTI
rem Facebook: facebook.com/BoraParaPratica
rem YouTube: youtube.com/BoraParaPratica
rem Data de criação: 05/01/2018
rem Data de atualização: 05/01/2018
rem Versão: 0.1
cls

echo Script de Instalacao do OCS Inventory Agent
echo Utilizacao do agent de forma automatizada
echo Data/hora de inicio do processo de instalacao: %date% - %time%
echo ==============================================================

rem Parametros de utilização do OCS Inventory Agent
rem /server=https://ocs.pti.intra/ocsinventory - Caminho do Servidor OCS Inventory
rem /ssl=1 - Habilitar o SSL
rem /ca="ocs.crt" - Caminho e nome do arquivo de Certificado
rem /tag="Desktop" - Nome da TAG
rem /debug=1 - Habilitar o Modo de Debug (Detalhado)
rem /s - Instalação em modo silencioso
rem /nosplash - Não mostrar a tela de Splash do OCS Inventory
rem 

echo Iniciando do processo de Instalacao do OCS Inventory Agent
OCS-NG-Windows-Agent-Setup.exe /server=https://ocs.pti.intra/ocsinventory /ssl=1 /ca="ocs.crt" /tag="Desktop" /debug=1 /s /nosplash
echo ==============================================================

echo Copiando o Arquivo de Certificado SSL
copy ocs.crt "c:\ProgramData\OCS Inventory NG\Agent"
echo ==============================================================

echo Executando o OCS SysTray
start "C:\Program Files (x86)\OCS Inventory Agent\OcsSystray.exe"
echo ==============================================================

echo Fim do processo de Instalacao do OCS Inventory Agent:
echo Data: %date% - hora: %time%
pause
