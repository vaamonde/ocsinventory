#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 30/11/2020
# Versão: 0.26
# Testado e homologado para a versão do Ubuntu Server 16.04.x LTS x64
# Kernel >= 4.4.x
#
# Instalação do LAMP Server
# Instalação do Apache2
# Instalação do MySQL Server
# Instalação do PhpMyAdmin
# Instalação do PHP, Perl, Python
# Instalação das Dependências via Perl CPAN
# Instalação das Dependências do Netdata
#
# Nesse script está sendo instalado todas as dependências do OCS Inventory Server, OCS Inventory Agent, 
# FusionInventory, GLPI Help Desk e do Netdata;
# Nas linhas do apt-get install todas as dependências já estão sendo instaladas;
# Nas linhas do perl -e -MCPAN está sendo instalada as dependências do OCS Inventory Server e Agent.
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
# Script de instalação do LAMP-Server no GNU/Linux Ubuntu Server 16.04.x
# opção do comando: &>> (redirecionar a saída padrão)
# opção do comando echo: -e (enable interpretation of backslash escapes), \n (new line)
# opção do comando hostname: -I (all IP address)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
# opção do comando cut: -d (delimiter), -f (fields)
echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
clear
#
echo
echo -e "Instalação do LAMP-SERVER no GNU/Linux Ubuntu Server 16.04.x\n"
echo -e "APACHE (Apache HTTP Server) - Servidor de Hospedagem de Páginas Web - Porta 80/443"
echo -e "Após a instalação do Apache2 acessar a URL: http://`hostname -I | cut -d ' ' -f1`/\n"
echo -e "MYSQL (SGBD) - Sistemas de Gerenciamento de Banco de Dados - Porta 3306\n"
echo -e "PHP (Personal Home Page - PHP: Hypertext Preprocessor) - Linguagem de Programação Dinâmica para Web\n"
echo -e "Após a instalação do PHP acessar a URL: http://`hostname -I | cut -d ' ' -f1`/phpinfo.php\n"
echo -e "PERL - Linguagem de programação multi-plataforma\n"
echo -e "PYTHON - Linguagem de programação de alto nível\n"
echo -e "PhpMyAdmin - Aplicativo desenvolvido em PHP para administração do MySQL pela Internet"
echo -e "Após a instalação do PhpMyAdmin acessar a URL: http://`hostname -I | cut -d ' ' -f1`/phpmyadmin\n"
echo -e "Aguarde, esse processo demora um pouco dependendo do seu Link de Internet..."
sleep 5
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
echo -e "Instalando o LAMP Server (Linux, Apache2, MySQL, PHP7, Perl, Python), aguarde..."
sleep 5
echo
#
echo -e "Configurando as variáveis do Debconf do MySQL para o Apt-Get, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando | (piper): (Conecta a saída padrão com a entrada padrão de outro comando)
	echo "mysql-server-5.7 mysql-server/root_password password $PASSWORD" |  debconf-set-selections
	echo "mysql-server-5.7 mysql-server/root_password_again password $PASSWORD" |  debconf-set-selections
	debconf-show mysql-server-5.7 &>> $LOG
echo -e "Variáveis configuradas com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalando o LAMP-SERVER e suas dependências do OCS Inventory e GLPI, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt: -y (yes), \ (bar left) quebra de linha na opção do apt-get
	# opção do comando ^ (circunflexo): (expressão regular - Casa o começo da linha)
	apt-get -y install lamp-server^ gcc make autoconf autogen automake pkg-config uuid-dev net-tools pciutils smartmontools \
	read-edid nmap ipmitool dmidecode samba samba-common samba-testsuite snmp snmp-mibs-downloader snmpd unzip hwdata perl \
	perl-modules python python-dev python3-dev python-pip apache2-dev mysql-client python-pymssql python-mysqldb &>> $LOG
echo -e "Instalação do LAMP-SERVER feito com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalando as dependências do PHP7 para suportar o OCS Inventory e GLPI, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt: -y (yes), \ (bar left) quebra de linha na opção do apt-get
	apt-get -y install php7.0-snmp php-mysql php7.0-dev php-mbstring php-soap php-dev php-apcu php-xmlrpc php7.0-zip \
	php7.0-gd php7.0-mysql php-pclzip php7.0-json php7.0-mbstring php7.0-curl php7.0-imap php7.0-ldap zlib1g-dev \
	php-mbstring php-gettext php-cas php-curl &>> $LOG
echo -e "Instalação das dependências do PHP7 feita com sucesso!!!, continuando com o script."
sleep 5
echo
#
echo -e "Instalando as dependências do Perl específicas para o OCS Inventory, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt: -y (yes), \ (bar left) quebra de linha na opção do apt-get
	apt-get -y install libc6-dev libcompress-raw-zlib-perl libwww-perl libdigest-md5-file-perl libnet-ssleay-perl \
	libcrypt-ssleay-perl libnet-snmp-perl libproc-pid-file-perl libproc-daemon-perl libarchive-zip-perl \
	libnet-cups-perl libphp-pclzip libmysqlclient-dev libapache2-mod-perl2 libapache2-mod-php libnet-netmask-perl \
	libio-compress-perl libxml-simple-perl libdbi-perl libdbd-mysql-perl libapache-dbi-perl libsoap-lite-perl \
	libnet-ip-perl libmodule-build-perl libmodule-install-perl libfile-which-perl libfile-copy-recursive-perl \
	libuniversal-require-perl libtest-http-server-simple-perl libhttp-server-simple-authen-perl libhttp-proxy-perl \
	libio-capture-perl libipc-run-perl libnet-telnet-cisco-perl libtest-compile-perl libtest-deep-perl \
	libtest-exception-perl libtest-mockmodule-perl libtest-mockobject-perl libtest-nowarnings-perl \
	libxml-treepp-perl libparallel-forkmanager-perl libparse-edid-perl libdigest-sha-perl libtext-template-perl \
	libsocket-getaddrinfo-perl libcrypt-des-perl libnet-nbname-perl libyaml-perl libyaml-shell-perl \
	libyaml-libyaml-perl libdata-structure-util-perl liblwp-useragent-determined-perl libio-socket-ssl-perl \
	libdatetime-perl libthread-queue-any-perl libnet-write-perl libarchive-extract-perl libjson-pp-perl \
	liburi-escape-xs-perl liblwp-protocol-https-perl libnet-ping-external-perl libnmap-parser-perl \
	libmojolicious-perl libswitch-perl libplack-perl liblwp-useragent-determined-perl libsys-syslog-perl \
	libdigest-hmac-perl libossp-uuid-perl libperl-dev libsnmp-perl libsnmp-dev libsoap-lite-perl &>> $LOG
echo -e "Instalação das dependências do Perl feito com sucesso!!!, continuando com o script."
sleep 5
echo
#
echo -e "Configurando as variáveis do Debconf do PhpMyAdmin para o Apt, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando | (piper): (Conecta a saída padrão com a entrada padrão de outro comando)
	echo "phpmyadmin phpmyadmin/internal/skip-preseed boolean true" |  debconf-set-selections
	echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" |  debconf-set-selections
	echo "phpmyadmin phpmyadmin/app-password-confirm password $APP_PASSWORD" |  debconf-set-selections
	echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect $WEBSERVER" |  debconf-set-selections
	echo "phpmyadmin phpmyadmin/mysql/admin-user string $ADMINUSER" |  debconf-set-selections
	echo "phpmyadmin phpmyadmin/mysql/admin-pass password $ADMIN_PASS" |  debconf-set-selections
	echo "phpmyadmin phpmyadmin/mysql/app-pass password $APP_PASS" |  debconf-set-selections
	debconf-show phpmyadmin &>> $LOG
echo -e "Variáveis configuradas com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalando o PhpMyAdmin, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt: -y (yes)
	apt-get -y install phpmyadmin &>> $LOG
echo -e "Instalação do PhpMyAdmin feita com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Atualizando os módulos do PHP7 para o suporte do PhpMyAdmin, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	phpenmod mcrypt &>> $LOG
	phpenmod mbstring &>> $LOG
	echo -e "Atualização dos módulos feita com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalação das dependências do Perl XML::Entities via CPAN, aguarde..."
	# opção do comando perl: -e (single line command)
	# Mensagem: Would you like to configure as much as possible automatically? [Yes] <-- Pressione <Enter>
	echo -e "Yes" | perl -MCPAN -e 'install XML::Entities' &>> $LOG
echo -e "Instalação concluída com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalação das dependências do Perl SOAP::Lite via CPAN, aguarde..."
	# opção do comando perl: -e (single line command)
	# Mensagem: WARNING: Please tell me where I can find your apache src: <-- digite q Pressione <Enter>
	# Esse procedimento demora um pouco, não se preocupe com a mensagem de erro no final, essa mensagem está 
	# associada ao Source do Apache2 que não está disponível no servidor
	echo -e "q" | perl -MCPAN -e 'install SOAP::Lite' &>> $LOG
echo -e "Instalação concluída com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalação das dependências do Perl Linux::Ethtool via CPAN, aguarde..."
	# opção do comando perl: -e (single line command)
	perl -MCPAN -e 'install Linux::Ethtool' &>> $LOG
echo -e "Instalação concluída com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalação das dependências do Perl Apache2::SOAP via CPAN, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando perl: -e (single line command)
	# opção do comando if: [ ] = testa uma expressão, -d = testa se é diretório
	if [ -d /usr/include/apache2 ]; then
		echo -e "Diretório /usr/include/apache2 já existe, continuando com o script..."
		else
		echo -e "Diretório /usr/include/apache2 não existe, criando o diretório, aguarde..."
			mkdir -v /usr/include/apache2 &>> $LOG
		echo -e "Diretório criado com sucesso!!!, continuando o script..."
	fi
	perl -MCPAN -e 'install Apache2::SOAP' &>> $LOG
echo -e "Instalação concluída com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalação das dependências do Perl nvidia::ml via CPAN, aguarde..."
	# opção do comando perl: -e (single line command)
	# opção do comando if: [ ] = testa uma expressão, == comparação de string 
	if [ "$NVIDIA" == "NVIDIA" ]; then
	echo -e "Você tem o Chip Gráfico da NVIDIA, instalando o Módulo Perl, aguarde..."
		perl -MCPAN -e 'install nvidia::ml' &>> $LOG
		echo -e "Instalação concluída com sucesso!!!, continuando com o script..."
		sleep 5
	else
	echo -e "Você não tem o Chip Gráfico da NVIDIA, continuando com o script..."
		sleep 5
		echo
	fi
#
echo -e "Instalação das dependências do Perl Net::Ping via CPAN, aguarde..."
	# opção do comando perl: -e (single line command)
	perl -MCPAN -e 'install Net::Ping' &>> $LOG
echo -e "Instalação concluída com sucesso!!!, continuando com o script..."
sleep 5
echo
#			
echo -e "Instalação das dependências do LWP::UserAgent::Cached via CPAN, aguarde..."
	# opção do comando perl: -e (single line command)
	# Mensagem: Append this modules to installation queue? [y] <-- Pressione <Enter>
	perl -MCPAN -e 'install LWP::UserAgent::Cached' &>> $LOG
echo -e "Instalação concluída com sucesso!!!, continuando com o script..."
sleep 5
echo
#				
echo -e "Instalação das dependências do Mac::SysProfile via CPAN, aguarde..."
	# opção do comando perl: -e (single line command)
	perl -MCPAN -e 'install Mac::SysProfile' &>> $LOG
echo -e "Instalação concluída com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalação das dependências do Mojolicious::Lite via CPAN, aguarde..."
	# opção do comando perl: -e (single line command)
	perl -MCPAN -e 'install Mojolicious::Lite' &>> $LOG
echo -e "Instalação concluída com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalação das dependências do NetSNMP::OID via CPAN, aguarde..."
	# opção do comando perl: -e (single line command)
	perl -MCPAN -e 'install NetSNMP::OID' &>> $LOG
echo -e "Instalação concluída com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Editando o arquivo do Apache2, pressione <Enter> para continuar"
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: -v (verbose)
	# opção do comando cp: -v (verbose)
	read
	mv -v /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bkp &>> $LOG
	echo -e "Backup feito com sucesso!!!, continuando com o script..."
	sleep 5
	cp -v conf/apache2.conf /etc/apache2/apache2.conf &>> $LOG
	echo -e "Atualização feita com sucesso!!!, continuando com o script..."
	sleep 5
	vim /etc/apache2/apache2.conf
	sudo service apache2 restart &>> $LOG
	echo -e "Servidor reinicializado com sucesso!!!, continuando com o script..."
echo -e "Arquivo editado com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Editando o arquivo do MySQL Server, pressione <Enter> para continuar"
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: -v (verbose)
	# opção do comando cp: -v (verbose)
	read
	mv -v /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.bkp &>> $LOG
	echo -e "Backup feito com sucesso!!!continuando com o script..."
	sleep 5
	cp -v conf/mysqld.cnf /etc/mysql/mysql.conf.d/ &>> $LOG
	echo -e "Atualização feita com sucesso!!!, continuando com o script..."
	sleep 5
	vim /etc/mysql/mysql.conf.d/mysqld.cnf
	sudo service mysql restart &>> $LOG
	echo -e "Servidor reinicializado com sucesso!!!, continuando com o script..."
echo -e "Arquivo editado com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Editando o arquivo do PHP7, pressione <Enter> para continuar"
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: -v (verbose)
	# opção do comando cp: -v (verbose
	read
	mv -v /etc/php/7.0/apache2/php.ini /etc/php/7.0/apache2/php.ini.bkp &>> $LOG
	echo -e "Backup feito com sucesso!!!, continuando com o script..."
	sleep 5
	cp -v conf/php.ini /etc/php/7.0/apache2/ &>> $LOG
	echo -e "Atualização feita com sucesso!!!, continuando com o script..."
	sleep 5
	vim /etc/php/7.0/apache2/php.ini
	sudo service apache2 restart &>> $LOG
	echo -e "Servidor reinicializado com sucesso!!!, continuando com o script..."
echo -e "Arquivo editado com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Criando o arquivo de verificação do PHP, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
	cp -v conf/phpinfo.php /var/www/html &>> $LOG
echo -e "Arquivo criado com sucesso!!!, continuando com o script..."
sleep 5
echo
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
echo -e "Verificando as portas de conexões do Apache2 e MySQL, aguarde..."
	# opção do comando netstat: -a (all), -n (numeric)
	# opção do comando grep: \| (função OU)
	netstat -an | grep ':80\|:3306'
echo -e "Portas de conexões verificadas com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalação do LAMP Server Feito com Sucesso!!!"
echo -e "Após a instalação acessar a URL: http://`hostname -I | cut -d ' ' -f1`/ para verificar se o Apache2 está OK"
echo -e "Após a instalação acessar a URL: http://`hostname -I | cut -d ' ' -f1`/phpinfo.php para verificar se o PHP7 está OK"
echo -e "Após a instalação acessar a URL: http://`hostname -I | cut -d ' ' -f1`/phpmyadmin para verificar se o PhpMyAdmin está OK"
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