#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 17/06/2017
# Data de atualização: 06/12/2020
# Versão: 0.15
# Testado e homologado para a versão do Ubuntu Server 16.04.x LTS x64
# Kernel >= 4.4.x
#
# Parâmetros (variáveis de ambiente) utilizadas nos scripts de instalação do OCS Inventory, GLPI, FusionInventory e Netdata
# Customizar as variáveis antes de rodar os scripts de instalação do Servidor e Agent do OCS Inventory, GLPI, FusionInventory
# e Netdata, antes de modificar esse arquivo, veja os arquivos: BUGS, CHANGELOG e NEWS para mais informações.
#
# Variável do caminho dos Logs dos Scripts utilizado nesse curso
VARLOGPATH="/var/log/ocsinstall"
#
# Variável para criação do arquivo de Log dos Scripts
# opção do comando cut: -d (delimiter), -f (fields)
# $0 (variável de ambiente do nome do comando)
LOGSCRIPT=`echo $0 | cut -d'/' -f2`
#
# Variável da Data Inicial para calcular o tempo de execução dos Scripts
# opção do comando date: +%T (Time), +%s (seconds)
DATAINICIAL=`date +%s`
HORAINICIAL=`date +%T`
#
# Variáveis para validar o ambiente, verificando se o usuário é "root", versão do ubuntu e kernel
# opções do comando id: -u (user)
# opções do comando: lsb_release: -r (release), -s (short), 
# opões do comando uname: -r (kernel release)
# opções do comando cut: -d (delimiter), -f (fields)
USUARIO=`id -u`
UBUNTU=`lsb_release -rs`
KERNEL=`uname -r | cut -d'.' -f1,2`
#
# Variáveis de configuração da instalação MySQL Server (USER usuário root do MySQL | PASSWORD senha do usuário Root)
# CUIDADO!!!!: essa senha será utilizada nos arquivos de configuração do PhpMyAdmin e no arquivo: mysql.conf do Netdata
USER="root"
PASSWORD="123456"
#
# Variáveis de instalação e configuração do PhpMyAdmin
# ADMINUSER usuário de administração do MySQL | WEBSERVER servidor Web para configuração do PhpMyAmin | ADMIN_PASS senha
# do usuário de administração do MySQL | APP_PASSWORD e APP_PASS senha de administração do PhpMyAdmin
ADMINUSER="root"
WEBSERVER="apache2"
ADMIN_PASS="123456"
APP_PASSWORD="123456"
APP_PASS="123456"
#
# Variáveis de download do OCS Inventory Server e Reports
# Site: https://www.ocsinventory-ng.org/en/
# Github: https://github.com/OCSInventory-NG/OCSInventory-ocsreports/releases
# Versão antiga utilizada no vídeo: 2.4/OCSNG_UNIX_SERVER_2.4.tar.gz
# Voltado para a versão 2.7 no dia 30/11/2020 - verificar arquivo CHANGELOG
OCSVERSION="2.7/OCSNG_UNIX_SERVER_2.7.tar.gz"
OCSTAR="OCSNG_UNIX_SERVER_2.7.tar.gz"
OCSINSTALL="OCSNG_UNIX_SERVER_2.7"
#
# Variáveis de download do OCS Inventory Agent
# Site: https://www.ocsinventory-ng.org/en/
# Github: https://github.com/OCSInventory-NG/UnixAgent/releases
# Versão antiga utilizada no vídeo: 2.3/Ocsinventory-Unix-Agent-2.3.tar.gz
# Atualização para a versão 2.6.1 no dia 30/11/2020 - verificar arquivo CHANGELOG
OCSAGENTVERSION="v2.6.1/Ocsinventory-Unix-Agent-2.6.1.tar.gz"
OCSAGENTTAR="Ocsinventory-Unix-Agent-2.6.1.tar.gz"
OCSAGENTINSTALL="Ocsinventory-Unix-Agent-2.6.1"
#
# Variáveis de download do GLPI Help Desk
# Site: http://glpi-project.org/spip.php?article41
# Github: https://github.com/glpi-project/glpi/releases
# Versão antiga utilizada no vídeo: 9.2.1/glpi-9.2.1.tgz
# Atualização para a versão 9.4.6 no dia 08/11/2020 - verificar arquivo CHANGELOG
# OBSERVAÇÃO: a versão 9.4.6 do GLPI é a última com suporte ao PHP 7.0, a partir da versão 9.5.x o suporte é para 
# versões >= 7.2 do PHP, nesse curso não será mais atualizado as versões do GLPI e do Plugin do OCS Inventory
GLPIVERSION="9.4.6/glpi-9.4.6.tgz"
GLPITAR="glpi-9.4.6.tgz"
GLPIINSTALL="glpi"
#
# Variáveis de download do Plugin do OCS Inventory do GLPI
# Site: https://github.com/pluginsGLPI/ocsinventoryng/releases
# Versão antiga utilizada no vídeo: 1.4.2/glpi-ocsinventoryng-1.4.2.tar.gz
# Atualização para a versão 1.6.1 no dia 08/11/2020 - verificar arquivo CHANGELOG
# OBSERVAÇÃO: a versão 9.4.6 do GLPI é a última com suporte ao PHP 7.0 e suporte a versão 1.6.1 do Plugin do OCS 
# Inventory, nesse curso não será mais atualizado as versões do GLPI e do Plugin do OCS Inventory
GLPIOCSVERSION="1.6.1/glpi-ocsinventoryng-1.6.1.tar.gz"
GLPIOCSTAR="glpi-ocsinventoryng-1.6.1.tar.gz"
GLPIOCSINSTALL="ocsinventoryng"
#
# Variáveis de download do FusionInventory Server do GLPI
# Site: https://github.com/fusioninventory/fusioninventory-for-glpi/releases
# Versão antiga utilizada no vídeo: glpi9.2%2B1.0/glpi-fusioninventory-9.2.1.0.tar.bz2
# Atualização para a versão 9.4+2.4 no dia 08/11/2020 - verificar arquivo CHANGELOG
# OBSERVAÇÃO: a versão 9.4.6 do GLPI é a última com suporte ao PHP 7.0 e suporte a versão 9.4+2.4 do Plugin do 
# FusionInventory, nesse curso não será mais atualizado as versões do GLPI e do Plugin do FusionInventory
GLPIFISVERSION="glpi9.4%2B2.4/fusioninventory-9.4+2.4.tar.bz2"
GLPIFISTAR="fusioninventory-9.4+2.4.tar.bz2"
GLPIFISINSTALL="fusioninventory"
#
# Variáveis de download do FusionInventory Agent
# Site: https://github.com/fusioninventory/fusioninventory-agent/releases/
# Versão antiga utilizada no vídeo: 2.4/FusionInventory-Agent-2.4.tar.gz
# Atualização para a versão 2.6 no dia 08/11/2020 - verificar arquivo CHANGELOG
GLPIFIAVERSION="2.6/FusionInventory-Agent-2.6.tar.gz"
GLPIFIATAR="FusionInventory-Agent-2.6.tar.gz"
GLPIFIAINSTALL="FusionInventory-Agent-2.6"
#
# Variáveis de download do Netdata
# Site: https://github.com/firehol/netdata
NETDATAVERSION="netdata.git"
NETDATAINSTALL="netdata"
#
# Variáveis de alteração de senha do OCS Inventory Reports no Banco de Dados do MySQL
# 'ocs'@'localhost' usuário de administração do banco de dados do OCS Inventory | PASSWORD('123456') nova senha 
# do usuário ocs, CUIDADO!!!!: essa senha será utilizada nos arquivos de configuração do OCS Inventory: dbconfig.inc.php, 
# z-ocsinventory-server.conf e zz-ocsinventory-restapi.conf
SETOCSPWD="SET PASSWORD FOR 'ocs'@'localhost' = PASSWORD('123456');"
FLUSH="FLUSH PRIVILEGES;"
#
# Variáveis de verificação do Chip Gráfico da NVIDIA
# lshw -class display lista as informações da placa de vídeo | grep NVIDIA filtra as linhas que contém a palavra 
# NVIDIA cut -d':' delimitador -f2 mostrar segunda coluna
NVIDIA=`lshw -class display | grep NVIDIA | cut -d':' -f2 | cut -d' ' -f2`
#
# Variável da localização do diretório de CRONTAB do CVE Search do OCS Inventory Reports
CVE="/usr/share/ocsinventory-reports/ocsreports/crontab/ "
#
# Variável da localização do diretório de download dos Agentes do OCS Inventory Reports
PATHDOWNLOAD="/var/lib/ocsinventory-reports/download"
#
# Variáveis de download do OCS Inventory MIBs para o suporte ao SNMP
# Site: http://www.circitor.fr/Mibs/Mibs.php
#
# Variável da localização do diretório dos arquivos de MIBs do SNMP do Ubuntu Server e do OCS Inventory Reports
# Utilizado na configuração das opções do SNMP do OCS Inventory Reports, ver arquivo 13-A-OCS-InventoryReports-ConfigWeb-2.7
# na linha: 103, para manter o diretório atualizado digite o comando: download-mibs
SNMP="/usr/share/snmp/mibs"
#
# Variável da localização do diretório dos arquivos de MIBs do SNMP do OCS Inventory Reports
MIBS="/var/lib/ocsinventory-reports/snmp"
#
# Variável de localização do diretório dos arquivos de MIBs Personalizados do OCS Inventory Agent
PM="/usr/local/share/perl/5.22.1/Ocsinventory/Agent/Modules/Snmp"
#
# Variável de localização do diretório dos arquivos de Modelos de MIBs XML Personalizados do OCS Inventory Agent
# OBSERVAÇÃO: alterar o endereço HTTPS para FQDN ou IP do seu servidor de OCS Inventory Reports
XMLLOCAL="/var/lib/ocsinventory-agent/https:__ocs.pti.intra/snmp/mibs/local"
XMLREMOTE="/var/lib/ocsinventory-agent/https:__ocs.pti.intra/snmp/mibs/remote"
#
# Variáveis de download do OCS Inventory Agent Microsoft, MacOS, Android e Ferramentas de Deploy
# Site Agent Windows: https://github.com/OCSInventory-NG/WindowsAgent/releases
# Site Agent Unix, Linux e Mac: https://github.com/OCSInventory-NG/UnixAgent/releases
# Site Agent Android: https://github.com/OCSInventory-NG/AndroidAgent/releases
# Site Package Windows: https://github.com/OCSInventory-NG/Packager-for-Windows/releases
# Site Agent Deployment Tool: https://github.com/OCSInventory-NG/Agent-Deployment-Tool/releases
# Versões antigas utilizada no vídeo: Win10-2.3.1.1, WinXP-2.1.1, Mac-2.3.1, Android-2.3.1, Tools-2.3 e Deploy-2.3
# Atualização para as versões: Win10-2.8.x, WinXP-2.1.1(Manteve a mesma versão), Mac-2.8.x, Android-2.7.x, Tools-2.8.x, Deploy-2.3
# (Manteve a mesma versão) e Unix-1.1.x no dia 08/11/2020 - verificar arquivo CHANGELOG
OCSAGENTWIN10="https://github.com/OCSInventory-NG/WindowsAgent/releases/download/2.8.0.0/OCS-Windows-Agent-2.8.0.0_x64.zip"
OCSAGENTWINXP="https://github.com/OCSInventory-NG/WindowsAgent/releases/download/2.1.1.1/OCSNG-Windows-Agent-2.1.1.zip"
OCSAGENTMAC="https://github.com/OCSInventory-NG/UnixAgent/releases/download/v2.8.0-MAC/Ocsinventory-Unix-Agent-2.8.0-MAC.tar.gz"
OCSAGENTANDROID="https://github.com/OCSInventory-NG/AndroidAgent/releases/download/2.7/OCSNG-Android-Agent.2.7.apk"
OCSAGENTTOOLS="https://github.com/OCSInventory-NG/Packager-for-Windows/releases/download/2.8/OCS-Windows-Packager-2.8.zip"
OCSAGENTDEPLOY="https://github.com/OCSInventory-NG/Agent-Deployment-Tool/releases/download/2.3/OCSNG-Agent-Deploy-Tool-2.3.zip"
OCSUNIXPACKAGER="https://github.com/OCSInventory-NG/Packager-for-Unix/releases/download/1.1/Packager-for-Unix-1.1.zip"
#
# Variáveis de download do OCS Inventory Plugins, adicionar os novos plugin e configurar os arquivo 12-plugins.sh para o
# download desse plugin, verificar o arquivo 13-A-OCS-InventoryReports-ConfigWeb-2.7 na linha: 1 para a instalação dos plugins
# Site: https://plugins.ocsinventory-ng.org/
#
# Variável da localização do diretório de plugins do OCS Inventory
PATHPLUGINS="/usr/share/ocsinventory-reports/ocsreports/extensions"
#
# Plugin01: Installed drivers (Retrieve list of installed drivers - Windows)
# Atualização para a versão 2.0 no dia 07/08/2020 - verificar arquivo CHANGELOG
DRIVERLIST="https://github.com/PluginsOCSInventory-NG/driverslist/releases/download/v2.0/driverslist.zip"
#
# Plugin02: Machine Uptime (Retrieve Machine Uptime - Windows e Linux)
# Atualização para a versão 2.0 no dia 07/08/2020 - verificar arquivo CHANGELOG
UPTIME="https://github.com/PluginsOCSInventory-NG/uptime/releases/download/2.0/uptime.zip"
#
# Plugin03: List printers (Retrieve connected printers - Windows e Linux)
# Atualização para a versão 2.0 no dia 07/08/2020 - verificar arquivo CHANGELOG
LISTPRINTERS="https://github.com/PluginsOCSInventory-NG/listprinters/releases/download/v2.0/listprinters.zip"
#