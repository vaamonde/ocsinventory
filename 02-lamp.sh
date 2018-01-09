#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 09/01/2018
# Versão: 0.17
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Instalação do LAMP Server
# Instalação do Apache2
# Instalação do MySQL Server
# Instalação do PhpMyAdmin
# Instalação do PHP, Perl, Python
# Instalação das Dependências via Perl CPAN
#
# Nesse script está sendo instalada todas as dependências do OCS Inventory Server, OCS Inventory Agent, Fusion Iventory, GLPI e do Netdata
# Nas linhas do apt-get install todas as dependências já estão sendo instaladas
# Nas linhas do perl -e -MCPAN está sendo instalada as dependências do OCS Server e Agent.
#
# Utilizar o comando: sudo -i para executar o script
#

# Arquivo de configuração de parâmetros
source 00-parametros.sh
#

# Caminho para o Log do script
LOG=$VARLOGPATH/$LOGSCRIPT
#h

if [ "$USUARIO" == "0" ]
then
	if [ "$UBUNTU" == "16.04" ]
		then
			if [ "$KERNEL" == "4.4" ]
				then
					 clear
					 echo -e "Usuário é `whoami`, continuando a executar o $LOGSCRIPT"
					 echo
					 echo  ============================================================ >> $LOG
					 
					 echo -e "Atualizando as Listas do Apt-Get, aguarde..."
					 
					 #Exportando a variável do Debian Frontend Noninteractive para não solicitar interação com o usuário
					 export DEBIAN_FRONTEND=noninteractive
					 
					 #Atualizando as listas do apt-get
					 apt-get update &>> $LOG 
					 
					 echo -e "Listas Atualizadas com Sucesso!!!, continuando com o script."
					 echo
					 echo  ============================================================ >> $LOG

					 echo -e "Instalando o LAMP Server (Linux, Apache2, MySQL, PHP7, Perl, Python), aguarde..."
					 
					 #Instalação dos principais pacotes do OCS Inventory e do GLPI integrado com o Apache2 e MySQL
					 #Configurando as variáveis do Debconf para a instalação do MySQL em modo Noninteractive
					 echo "mysql-server-5.7 mysql-server/root_password password $PASSWORD" |  debconf-set-selections
					 echo "mysql-server-5.7 mysql-server/root_password_again password $PASSWORD" |  debconf-set-selections
					 
					 #Instalando o LAMP Server completo e todas as suas dependêncais do OCS Inventory Server, Agent, GLPI Help Desk e do Netdata
					 apt-get -y install lamp-server^ gcc make autoconf autogen automake pkg-config uuid-dev net-tools pciutils smartmontools read-edid nmap ipmitool dmidecode samba samba-common samba-testsuite snmp snmp-mibs-downloader unzip hwdata perl perl-modules python python-dev python3-dev python-pip apache2-dev &>> $LOG
					 
					 echo -e "Instalação do LAMP Server feito com sucesso!!!, continuando com o script."
					 echo
					 echo  ============================================================ >> $LOG
					 
					 echo -e "Instalando as Dependências do PHP, aguarde..."
					 					 
					 #Instalando as dependências do PHP7 para dá suporte a recursos extras
					 apt-get -y install php7.0-snmp php-mysql php7.0-dev php-mbstring php-soap php-dev php-apcu php-xmlrpc php7.0-zip php7.0-gd php7.0-mysql php-pclzip php7.0-json php7.0-mbstring php7.0-curl php7.0-imap php7.0-ldap zlib1g-dev php-mbstring php-gettext &>> $LOG
					 
					 echo -e "Instalação das Dependências do PHP7 feito com sucesso!!!, continuando com o script."
					 echo
					 echo  ============================================================ >> $LOG
					 
					 echo -e "Instalando as Dependências do Perl, aguarde..."
					 					 
					 #Instalando as dependências do Perl e GCC para dá suporte a recursos extras
					 apt-get -y install libc6-dev libcompress-raw-zlib-perl libwww-perl libdigest-md5-file-perl libnet-ssleay-perl libcrypt-ssleay-perl libnet-snmp-perl libproc-pid-file-perl libproc-daemon-perl libarchive-zip-perl libnet-cups-perl libphp-pclzip libmysqlclient-dev libapache2-mod-perl2 libapache2-mod-php libnet-netmask-perl libio-compress-perl libxml-simple-perl libdbi-perl libdbd-mysql-perl libapache-dbi-perl libsoap-lite-perl libnet-ip-perl libmodule-build-perl libmodule-install-perl libfile-which-perl libfile-copy-recursive-perl libuniversal-require-perl libtest-http-server-simple-perl libhttp-server-simple-authen-perl  libhttp-proxy-perl libio-capture-perl libipc-run-perl libnet-telnet-cisco-perl libtest-compile-perl libtest-deep-perl libtest-exception-perl libtest-mockmodule-perl libtest-mockobject-perl libtest-nowarnings-perl libxml-treepp-perl libparallel-forkmanager-perl libparse-edid-perl libdigest-sha-perl libtext-template-perl libsocket-getaddrinfo-perl libcrypt-des-perl libnet-nbname-perl libyaml-perl libyaml-shell-perl libyaml-libyaml-perl libdata-structure-util-perl liblwp-useragent-determined-perl libio-socket-ssl-perl libdatetime-perl libthread-queue-any-perl libnet-write-perl libarchive-extract-perl libjson-pp-perl liburi-escape-xs-perl liblwp-protocol-https-perl libnet-ping-external-perl libnmap-parser-perl libmojolicious-perl libswitch-perl libplack-perl liblwp-useragent-determined-perl libsys-syslog-perl libdigest-hmac-perl libossp-uuid-perl &>> $LOG
					 
					 echo -e "Instalação das Dependências do Perl feito com sucesso!!!, continuando com o script."
					 echo
					 echo  ============================================================ >> $LOG

					 echo -e "Instalando o PhpMyAdmin, aguarde..."
					 
					 #Configurando as variáveis do Debconf para a instalação do PhpMyAdmin em modo Noninteractive
					 echo "phpmyadmin phpmyadmin/internal/skip-preseed boolean true" |  debconf-set-selections
					 echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" |  debconf-set-selections
					 echo "phpmyadmin phpmyadmin/app-password-confirm password $APP_PASSWORD" |  debconf-set-selections
					 echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect $WEBSERVER" |  debconf-set-selections
					 echo "phpmyadmin phpmyadmin/mysql/admin-user string $ADMINUSER" |  debconf-set-selections
					 echo "phpmyadmin phpmyadmin/mysql/admin-pass password $ADMIN_PASS" |  debconf-set-selections
					 echo "phpmyadmin phpmyadmin/mysql/app-pass password $APP_PASS" |  debconf-set-selections
					 
					 #Instalando o PhpMyAdmin
					 apt-get -y install phpmyadmin &>> $LOG
					 
					 #Atualizando as dependências do PhpMyAdmin, ativando os recursos dos módulos do PHP no Apache2
					 phpenmod mcrypt
					 phpenmod mbstring
					 
					 echo -e "Instalação do PhpMyAdmin Feito com Sucesso!!!"
					 echo
					 
					 echo -e "Após a reinicialização, testar o servidor Apache2 na URL: http://`hostname`"
					 echo -e "Após a reinicialização, testar o PhpMyAdmin na URL: http://`hostname`/phpmyadmin"
					 echo
					 
					 echo -e "Pressione <Enter> para continuar com o script."
					 read
					 sleep 2
					 clear
					 echo ============================================================ >> $LOG

					 echo -e "Instalação das Dependências do Perl XML::Entities via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do XML::Entities
					 #Mensagem: Would you like to configure as much as possible automatically? [Yes] <-- Pressione <Enter>
					 perl -MCPAN -e 'install XML::Entities'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Instalação das Dependências do Perl SOAP::Lite via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do SOAP::Lite
					 #Mensagem: WARNING: Please tell me where I can find your apache src: <-- digite q Pressione <Enter>
					 #Esse procedimento demora um pouco, não se preocupe com a mensagem de erro no final, está associado ao Source do Apache
					 perl -MCPAN -e 'install SOAP::Lite'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Linux::Ethtool via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Linux::Ethtool
					 perl -MCPAN -e 'install Linux::Ethtool'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Apache2::SOAP via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Validando a existencia do diretório do Apache2
					 if [ -d /usr/include/apache2 ]; then
					 	echo -e "Diretório /usr/include/apache2 já existe, continuando com o script"
					 else
					 	echo -e "Diretório /usr/include/apache2 não existe, criando o diretório"
					 	
							#Criando o diretório do SOAP para o Apache2
					 		mkdir -v /usr/include/apache2 &>> $LOG
					 	
						echo -e "Diretório criado com sucesso!!!, continuando o script"
						echo
					 fi
					 
					 #Instalação do Apache2::SOAP				 
					 perl -MCPAN -e 'install Apache2::SOAP'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl nvidia::ml via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Validando a existencia do Chip Gráfico da NVIDIA
					 if [ "$NVIDIA" == "NVIDIA" ]; then
					 	echo -e "Você tem o Chip Gráfico da NVIDIA, instalando o Módulo Perl, pressione <Enter> para continuar"
							read
					 		
							#Instalação do nvidia::ml
					 		perl -MCPAN -e 'install nvidia::ml'
							
							echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 		read
					 		sleep 2
					 		clear
					 else
					 	echo -e "Você não tem o Chip Gráfico da NIVIDIA, pressione <Enter> para continuar"
							read
					 		sleep 2
					 		clear
					 fi

					 echo -e "Instalação das Dependências do Perl Net::Ping via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Net::Ping					 
					 perl -MCPAN -e 'install Net::Ping'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 					 
					 echo -e "Instalação das Dependências do LWP::UserAgent::Cached via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do LWP::UserAgent::Cached
					 #Menssagem: Append this modules to installaation queue? [y] <-- Pressione <Enter>
					 perl -MCPAN -e 'install LWP::UserAgent::Cached'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 					 
					 echo -e "Instalação das Dependências do Mac::SysProfile via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Mac::SysProfile
					 perl -MCPAN -e 'install Mac::SysProfile'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo ============================================================ >> $LOG

					 echo -e "Editando o arquivo do Apache2, pressione <Enter> para continuar"
					 read
					 
					 #Fazendo o backup do arquivo original
					 mv -v /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bkp >> $LOG
					 echo -e "Backup feito com sucesso!!!"
					 sleep 2
					 
					 #Atualização o arquivo de configuração do Apache2
					 cp -v conf/apache2.conf /etc/apache2/apache2.conf >> $LOG
					 echo -e "Atualização feita com sucesso!!!"
					 sleep 2
					 
					 #Editando o arquivo de configuração
					 vim /etc/apache2/apache2.conf
					 
					 #Reinicializando o serviço do Apache2 Server
					 sudo service apache2 restart
					 echo -e "Servidor reinicializado com sucesso!!!"
					 sleep 2
					 
					 echo -e "Arquivo editado com Sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Editando o arquivo do MySQL Server, pressione <Enter> para continuar"
					 read
					 
					 #Arquivo de configuração do Banco de Dados do MySQL Server
					 #Permitir acesso aremoto ao MySQL comentando a linha: bind-address
					 #Fazendo o backup do arquivo de configuração original
					 mv -v /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.bkp &>> $LOG
					 echo -e "Backup feito com sucesso!!!"
					 sleep 2
					 
					 #Atualizando para o novo arquivo de configuração
					 cp -v conf/mysqld.cnf /etc/mysql/mysql.conf.d/ &>> $LOG
					 echo -e "Atualização feita com sucesso!!!"
					 sleep 2
					 
					 #Editando o arquivo de configuração
					 vim /etc/mysql/mysql.conf.d/mysqld.cnf
					 
					 #Reinicializando o serviço do MySQL Server
					 sudo service mysql restart
					 echo -e "Servidor reinicializado com sucesso!!!"
					 sleep 2
					 
					 echo -e "Arquivo editado com Sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Editando o arquivo do PHP, pressione <Enter> para continuar"
					 read
					 
					 #Arquivo de configuração do PHP que será utilizado pelo Apache2
					 #Aumentar os valores das váriaveis: post_max_size e upload_max_filesize para: 250MB
					 #Fazendo o backup do arquivo de configuração original
					 mv -v /etc/php/7.0/apache2/php.ini /etc/php/7.0/apache2/php.ini.bkp &>> $LOG
					 echo -e "Backup feito com sucesso!!!"
					 sleep 2
					 
					 #Atualizando para o novo arquivos de configuração
					 cp -v conf/php.ini /etc/php/7.0/apache2/ &>> $LOG
					 echo -e "Atualização feita com sucesso!!!"
					 sleep 2
					 
					 #Editando o arquivo de configuração
					 vim /etc/php/7.0/apache2/php.ini
					 
					 #Reinicializando o serviço do Apache2
					 sudo service apache2 restart
					 echo -e "Servidor reinicializado com sucesso!!!"
					 sleep 2
					 
					 echo -e "Arquivo editado com Sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Removendo aplicativos desnecessários, aguarde..."
					 
					 #Limpando o diretório de cache do apt-get
					 apt-get autoremove &>> $LOG
					 apt-get autoclean &>> $LOG
					 
					 echo -e "Aplicativos removidos com Sucesso!!!, continuando com o script"
					 echo
					 echo ============================================================ >> $LOG

					 echo -e "Limpando o Cache do Apt-Get, aguarde..."
					 
					 #Limpando o diretório de cache do apt-get
					 apt-get clean &>> $LOG
					 
					 echo -e "Cache Limpo com Sucesso!!!"
					 echo
					 echo ============================================================ >> $LOG

					 echo -e "Fim do $LOGSCRIPT em: `date`" >> $LOG
					 echo -e "Instalação do LAMP Server Feito com Sucesso!!!!!"
					 echo
					 # Script para calcular o tempo gasto para a execução do lamp.sh
						 DATAFINAL=`date +%s`
						 SOMA=`expr $DATAFINAL - $DATAINICIAL`
						 RESULTADO=`expr 10800 + $SOMA`
						 TEMPO=`date -d @$RESULTADO +%H:%M:%S`
					 echo -e "Tempo gasto para execução do lamp.sh: $TEMPO"
					 echo -e "Pressione <Enter> para reinicializar o servidor: `hostname`"
					 read
					 sleep 2
					 reboot
					 else
						 echo -e "Versão do Kernel: $KERNEL não homologada para esse script, versão: >= 4.4 "
						 echo -e "Pressione <Enter> para finalizar o script"
						 read
			fi
	 	 else
			 echo -e "Distribuição GNU/Linux: `lsb_release -is` não homologada para esse script, versão: $UBUNTU"
			 echo -e "Pressione <Enter> para finalizar o script"
			 read
	fi
else
	 echo -e "Usuário não é ROOT, execute o comando com a opção: sudo -i <Enter> depois digite a senha do usuário `whoami`"
	 echo -e "Pressione <Enter> para finalizar o script"
	read
fi
