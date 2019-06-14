#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 17/06/2017
# Data de atualização: 14/06/2019
# Versão: 0.9
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Parâmetros (variáveis de ambiente) utilizados nos scripts de instalação do OCS Inventory, GLPI, FusionInventory e Netdata
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
# Versão antiga utilizada no vídeo: 2.4/OCSNG_UNIX_SERVER_2.4.tar.gz
# Versão atualizada para 2.6 no dia 11/06/2019 - verificar arquivo CHANGELOG
OCSVERSION="2.6/OCSNG_UNIX_SERVER_2.6.tar.gz"
OCSTAR="OCSNG_UNIX_SERVER_2.6.tar.gz"
OCSINSTALL="OCSNG_UNIX_SERVER_2.6"
#

# Variáveis de download do OCS Inventory Agent
# Site: https://www.ocsinventory-ng.org/en/
# Versão antiga utilizada no vídeo: 2.3/Ocsinventory-Unix-Agent-2.3.tar.gz
# Versão atualizada para 2.4.2 no dia 13/06/2019 - verificar arquivo CHANGELOG
OCSAGENTVERSION="v2.4.2/Ocsinventory-Unix-Agent-2.4.2.tar.gz"
OCSAGENTTAR="Ocsinventory-Unix-Agent-2.4.2.tar.gz"
OCSAGENTINSTALL="Ocsinventory-Unix-Agent-2.4.2"
#

# Variáveis de download do GLPI Help Desk
# Site: http://glpi-project.org/spip.php?article41
# Versão antiga utilizada no vídeo: 9.2.1/glpi-9.2.1.tgz
# Versão atualizada para 9.4.2 no dia 13/06/2019 - verificar arquivo CHANGELOG
GLPIVERSION="9.4.2/glpi-9.4.2.tgz"
GLPITAR="glpi-9.4.2.tgz"
GLPIINSTALL="glpi"
#

# Variáveis de download do Plugin do OCS Inventory do GLPI
# Site: https://github.com/pluginsGLPI/ocsinventoryng/releases
# Versão antiga utilizada no vídeo: 1.4.2/glpi-ocsinventoryng-1.4.2.tar.gz
# Versão atualizada para 1.6.0 no dia 13/06/2019 - verificar arquivo CHANGELOG
GLPIOCSVERSION="1.6.0/glpi-ocsinventoryng-1.6.0.tar.gz"
GLPIOCSTAR="glpi-ocsinventoryng-1.6.0.tar.gz"
GLPIOCSINSTALL="ocsinventoryng"
#

# Variáveis de download do FusionInventory Server para GLPI
# Site: https://github.com/fusioninventory/fusioninventory-for-glpi/releases
# Versão antiga utilizada no vídeo: glpi9.2%2B1.0/glpi-fusioninventory-9.2.1.0.tar.bz2
# Versão atualizada para 9.4+1.1 no dia 14/06/2019 - verificar arquivo CHANGELOG
GLPIFISVERSION="glpi9.4%2B1.1/fusioninventory-9.4+1.1.tar.bz2"
GLPIFISTAR="fusioninventory-9.4+1.1.tar.bz2"
GLPIFISINSTALL="fusioninventory"
#

# Variáveis de download do FusionInventory Agent
# Site: https://github.com/fusioninventory/fusioninventory-agent/releases/
# Versão antiga utilizada no vídeo: 2.4/FusionInventory-Agent-2.4.tar.gz
# Versão atualizada para 2.5 no dia 14/06/2019 - verificar arquivo CHANGELOG
GLPIFIAVERSION="2.5/FusionInventory-Agent-2.5.tar.gz"
GLPIFIATAR="FFusionInventory-Agent-2.5.tar.gz"
GLPIFIAINSTALL="FusionInventory-Agent-2.5"
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
NVIDIA=`lshw -class display | grep NVIDIA | cut -d':' -f2 | cut -d' ' -f2`
#

# Variáveis de download do OCS Inventory Agent Microsoft, MacOS, Android e Ferramentas de Deploy
# Site: https://www.ocsinventory-ng.org/en/
# Versões antigas utilizada no vídeo: Win10-2.3.1.1, WinXP-2.1.1, Mac-2.3.1, Android-2.3.1, Tools-2.3 e Deploy-2.3
# Versões novas atualizadas no dia 14/06/2019 - verificar arquivo CHANGELOG
OCSAGENTWIN10="https://github.com/OCSInventory-NG/WindowsAgent/releases/download/2.4.0.0/OCSNG-Windows-Agent-2.4.0.0.zip"
OCSAGENTWINXP="https://github.com/OCSInventory-NG/WindowsAgent/releases/download/2.1.1.1/OCSNG-Windows-Agent-2.1.1.zip"
OCSAGENTMAC="https://github.com/OCSInventory-NG/UnixAgent/releases/download/v2.4.2/Ocsinventory_Agent_MacOSX-2.4.2.pkg.zip"
OCSAGENTANDROID="https://github.com/OCSInventory-NG/AndroidAgent/releases/download/2.3.1/OCSNG-Android-Agent-2.3.1.apk"
OCSAGENTTOOLS="https://github.com/OCSInventory-NG/Packager-for-Windows/releases/download/2.3/OCSNG-Windows-Packager-2.3.zip"
OCSAGENTDEPLOY="https://github.com/OCSInventory-NG/Agent-Deployment-Tool/releases/download/2.3/OCSNG-Agent-Deploy-Tool-2.3.zip"
OCSUNIXPACHAGER="https://github.com/OCSInventory-NG/Packager-for-Unix/releases/download/1.0/OCSNG-Unix-Packager-1.0.zip"
