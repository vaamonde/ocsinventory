#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 17/06/2017
# Data de atualização: 04/01/2018
# Versão: 0.3
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Parâmetros (variáveis de ambiente) utilizados nos scripts de instalação do OCS Inventory, GLPI e Netdata
#

# Variável do caminho do Log dos Script utilizado nesse curso
VARLOGPATH="/var/log/ocsinstall"
#

# Variável para criação do arquivo de Log dos Script
LOGSCRIPT=`echo $0 | cut -d'/' -f2`
#

# Variável da Data Inicial para calcular o tempo de execução dos Scripts
DATAINICIAL=`date +%s`
#

# Variáveis de Validação do ambiente, verificando se o usuário e "root", versão do "ubuntu" e versão do "kernel"
USUARIO=`id -u`
UBUNTU=`lsb_release -rs`
KERNEL=`uname -r | cut -d'.' -f1,2`
#

# Variáveis de configuração da instalação MySQL Server
PASSWORD="123456"
USER="root"
#

# Variáveis de configuração da instalação do PhpMyAdmin
APP_PASSWORD="123456"
ADMIN_PASS="123456"
APP_PASS="123456"
WEBSERVER="apache2"
ADMINUSER="root"
#

# Variáveis de download do OCS Inventory Server e Reports
# Site: https://www.ocsinventory-ng.org/en/
OCSVERSION="2.4/OCSNG_UNIX_SERVER_2.4.tar.gz"
OCSTAR="OCSNG_UNIX_SERVER_2.4.tar.gz"
OCSINSTALL="OCSNG_UNIX_SERVER_2.4"
#

# Variáveis de download do OCS Inventory Agent
# Site: https://www.ocsinventory-ng.org/en/
OCSAGENTVERSION="2.3/Ocsinventory-Unix-Agent-2.3.tar.gz"
OCSAGENTTAR="Ocsinventory-Unix-Agent-2.3.tar.gz"
OCSAGENTINSTALL="Ocsinventory-Unix-Agent-2.3"
#

# Variáveis de download do GLPI Help Desk
# Site: http://glpi-project.org/spip.php?article41
GLPIVERSION="9.2.1/glpi-9.2.1.tgz"
GLPITAR="glpi-9.2.1.tgz"
GLPIINSTALL="glpi"
#

# Variáveis de download do Plugin do OCS Inventory do GLPI
# Site: https://github.com/pluginsGLPI/ocsinventoryng/releases
GLPIOCSVERSION="1.4.2/glpi-ocsinventoryng-1.4.2.tar.gz"
GLPIOCSTAR="glpi-ocsinventoryng-1.4.2.tar.gz"
GLPIOCSINSTALL="ocsinventoryng"
#

# Variáveis de download do Netdata
# Site: https://github.com/firehol/netdata
NETDATAVERSION="netdata.git"
NETDATAINSTALL="netdata"
#

# Variáveis de alteração de senha do OCS Inventory Reports
SETOCSPWD="SET PASSWORD FOR 'ocs'@'localhost' = PASSWORD('123456');"
FLUSH="FLUSH PRIVILEGES;"
#

# Variáveis de verificação do Chip Gráfico da NVIDIA
NVIDIA=`lspci | grep -i GeForce | cut -d' ' -f4`
#
