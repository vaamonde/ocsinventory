#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 30/11/2020
# Versão: 0.16
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Instalação do OCS Inventory Server e OCS Inventory Reports, configuração dos Hosts Virtual no Apache2, alteração 
# de permissão dos diretórios e arquivos do OCS Inventory
#
# Arquivo de configuração dos parâmetros
source 00-parametros.sh
#
# Caminho do arquivo para o Log do script
LOG=$VARLOGPATH/$LOGSCRIPT
#
# Exportando o recurso de Noninteractive do Debconf para não solicitar telas de configuração
export DEBIAN_FRONTEND="noninteractive"
#
# Verificando se o usuário é Root, Distribuição é >=16.04 e o Kernel é >=4.4 <IF MELHORADO)
# opção do comando if: [ ] = teste de expressão, && = operador lógico AND, == comparação de string, exit 1 = 
# A maioria dos erros comuns na execução
clear
if [ "$USUARIO" == "0" ] && [ "$UBUNTU" == "16.04" ] && [ "$KERNEL" == "4.4" ]
	then
		echo -e "O usuário é Root, continuando com o script..."
		echo -e "Distribuição é >=16.04.x, continuando com o script..."
		echo -e "Kernel é >= 4.4, continuando com o script..."
		sleep 5
	else
		echo -e "Usuário não é Root ($USUARIO) ou Distribuição não é >=16.04.x ($UBUNTU) ou Kernel não é >=4.4 ($KERNEL)"
		echo -e "Caso você não tenha executado o script com o comando: sudo -i"
		echo -e "Execute novamente o script para verificar o ambiente."
		exit 1
fi
#
# Script de instalação do OCS Inventory Server e Reports no GNU/Linux Ubuntu Server 16.04.x
# opção do comando: &>> (redirecionar a saída padrão)
# opção do comando echo: -e (enable interpretation of backslash escapes), \n (new line)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
clear
#
echo
echo -e "Após a instalação do OCS Inventory acessar a url: http://`hostname -I | cut -d ' ' -f1`/ocsreports e concluir a configuração\n"
echo -e "Usuário padrão após a instalação do OCS Inventory Reports: admin | Senha padrão: admin"
echo
#
echo -e "Atualizando as listas do Apt, aguarde..."
	#opção do comando: &>> (redirecionar a saída padrão)
	apt-get update &>> $LOG
echo -e "Listas atualizadas com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Atualizando os pacotes instalados, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt-get: -o (options), -q (quiet), -y (yes)
	apt-get -o Dpkg::Options::="--force-confold" upgrade -q -y --force-yes &>> $LOG
echo -e "Pacotes atualizados com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Download do OCS Inventory Server do Github, aguarde..."
sleep 5
echo
echo -e "Fazendo o download do OCS Inventory, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	wget https://github.com/OCSInventory-NG/OCSInventory-ocsreports/releases/download/$OCSVERSION &>> $LOG
echo -e "Download do OCS Inventory feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Descompactando o arquivo OCS Inventory, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando: tar z (gzip), x (extract), v (verbose) e f (file)
	tar -zxvf $OCSTAR &>> $LOG
echo -e "Arquivo do OCS Inventory descompactado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Acessando a diretório de instalação do OCS Inventory, aguarde..."
	cd $OCSINSTALL
echo -e "Diretório de instalação do OCS Inventory acessado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "CUIDADO!!! com as opções que serão solicitadas no decorrer da instalação do OCS Inventory."
echo -e "Veja a documentação das opções de instalação a partir da linha: 104 do arquivo $0"
echo -e "Download do OCS Inventory Server feito com Sucesso!!!, pressione <Enter> para instalar"
echo
read
sleep 2
clear
#
#Executando a instalação do OCS Inventory Server e Reports
./setup.sh
#
#MENSAGENS QUE SERÃO SOLICITADAS NA INSTALAÇÃO DO OCS INVENTORY SERVER:
#01. Do you wish to continue ([y]/n): y <-- digite y pressione <Enter>;
#02. Which host is running database server [localhost]?: Deixe o padrão pressione <Enter>;
#03. On which port is running database server [3306]?: Deixe o padrão pressione <Enter>;
#04. Where is Apache daemon binary [/usr/sbin/apache2ctl]?: Deixe o padrão pressione <Enter>;
#05. Where is Apache main configuration file [/etc/apache2/apache2.conf]?: Deixe o padrão pressione <Enter>;
#06. Which user account is running Apache Web Server [www-data]?: Deixe o padrão pressione <Enter>;
#07. Which user group is running Apache web server [www-data]?: Deixe o padrão pressione <Enter>;
#08. Where is Apache Include configuration directory [/etc/apache2/conf-available]?: Deixe o padrão pressione <Enter>;
#09. Where is PERL Interpreter binary [/usr/bin/perl]?: Deixe o padrão pressione <Enter>;
#10. Do you wish to setup Communication Server on this computer ([y]/n)? y <-- digite y pressione <Enter>;
#11. Where to put Communication server log directory [/var/log/ocsinventory-server]? Deixe o padrão pressione <Enter>;
#12. Where to put Communication server plugins configuration files [/etc/ocsinventory-server/plugins]? Deixe o padrão pressione <Enter>;
#13. Where to put Communication server plugins Perl modules files [/etc/ocsinventory-server/perl]? Deixe o padrão pressione <Enter>;
#14. Do you wish to setup Rest API server on this computer ([y]/n)? y <-- digite y pressione <Enter>;
#15. Where do you want the API code to be store [/usr/local/share/perl/5.22.1]? Deixe o padrão pressione <Enter>;
#16. Do you allow Setup renaming Communication Server Apache configuration file to 'z-ocsinventory-server.conf' ([y]/n)?: y <-- digite y pressione <Enter>;
#17. Do you wish to setup Administration Server (Web Administration Console) on this computer ([y]/n)?: y <-- digite y pressione <Enter>;
#18. Do you wish to continue ([y]/n)?: y <-- digite y pressione <Enter>;
#15. Where to copy Administration Server static files for PHP Web Console [/usr/share/ocsinventory-reports]?: Deixe o padrão pressione <Enter>;
#16. Where to create writable/cache directories for deployment packages administration console logs, IPDiscover and SNMP [/var/lib/ocsinventory-reports]?: Deixe o padrão pressione <Enter>;
#
#INFORMAÇÕES QUE SERÃO SOLICITADAS VIA WEB (NAVEGADOR) DO OCS INVENTORY SERVER:
#01. MySQL login: root (usuário padrão do MySQL)
#02. MySQL password: 123456 (senha criada no arquivo 00-parametros.sh)
#03. Name of Database: ocsweb (base de dados padrão do OCS Inventory, não mudar)
#04. MySQL HostName: localhost (servidor local do MySQL)
#05. MySQL Port: 3306 (porta padrão do MySQL)
#06. Enable SSL: no
#OBS: opções: SSL mode, SSL key path, SSL certificate path e CA certificate path será configurada futuramente.
#
#USUÁRIO E SENHA PADRÃO DO OCS INVENTORY SERVER: USER=admin | PASSWORD=admin
#
#APÓS A INSTALAÇÃO VIA NAVEGADOR DO OCS INVENTORY, REMOVER O ARQUIVO INSTALL, ELE SERÁ REMOVIDO AUTOMÁTICAMENTE NO SCRIPT 04-pos_ocs_server.sh
#
echo
echo -e "OCS Inventory instalado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Alterando as informações do Site Padrão do Apache2, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	a2dissite 000-default &>> $LOG
echo -e "Apache 2 atualizado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Configurando o Host Virtual do OCS Inventory Reports no Apache2, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	a2enconf ocsinventory-reports &>> $LOG
echo -e "Virtual host do OCS Inventory Reports habilitado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Configurando o Host Virtual do OCS Inventory Server no Apache2, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	a2enconf z-ocsinventory-server &>> $LOG
echo -e "Virtual host do OCS Inventory Server habilitado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Alterando as permissões de acesso do diretório do OCS Inventory Reports, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando chmod: -R (recursive), -v (verbose), 755 (User=RWX, Group=R-X, Other=R-X)
	chmod -Rv 775 /var/lib/ocsinventory-reports/ &>> $LOG
echo -e "Permissões do OCS Inventory Reports alteradas com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Alterando o dono e grupo padrão do diretório do OCS Inventory Reports, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando chown: -R (recursive), -v (verbose), www-data.www-data (user and group)
	chown -Rv www-data.www-data /var/lib/ocsinventory-reports/ &>> $LOG
echo -e "Alteração do dono e grupo do OCS Inventory Reports alteradas com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Reinicializando o Serviço do Apache2, aguarde..."
	sudo service apache2 restart
echo -e "Serviço do Apache 2 reinicializado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Fazendo o backup do arquivo de Log da Instalação do OCS Inventory, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
	cp -v *.log $VARLOGPATH/ &>> $LOG
	cd ..
echo -e "Backup do arquivo de Log de Instalação do OCS Inventory feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Instalação do OCS Inventory Server e Reports Service feito com sucesso!!!, continuando com o script..."
sleep 5
clear
#			
echo -e "Remoção dos aplicativos desnecessários, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt-get: -y (yes)
	apt-get -y autoremove &>> $LOG
	apt-get -y autoclean &>> $LOG
echo -e "Remoção dos aplicativos desnecessários concluída com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Limpando o cache do Apt-Get, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt-get: -y (yes)
	apt-get clean &>> $LOG
echo -e "Cache limpo com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalação do OCS Inventory Server Feito com Sucesso!!!!!\n"
echo -e "Após a instalação do OCS Inventory acessar a URL: http://`hostname -I | cut -d ' ' -f1`/ocsreports para finalizar a configuração."
echo
	# script para calcular o tempo gasto (SCRIPT MELHORADO, CORRIGIDO FALHA DE HORA:MINUTO:SEGUNDOS)
	# opção do comando date: +%T (Time)
	HORAFINAL=`date +%T`
	# opção do comando date: -u (utc), -d (date), +%s (second since 1970)
	HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
	HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
	# opção do comando date: -u (utc), -d (date), 0 (string command), sec (force second), +%H (hour), %M (minute), %S (second), 
	TEMPO=`date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S"`
	# $0 (variável de ambiente do nome do comando)
	echo -e "Tempo gasto para execução do script $0: $TEMPO"
echo -e "Pressione <Enter> para concluir a instalação do servidor: `hostname`"
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Fim do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
read
sleep 2