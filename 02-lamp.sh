#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 19/06/2017
# Versão: 0.11
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Instalação do LAMP Server
# Instalação do Apache2
# Instalação do MySQL Server
# Instalação do PhpMyAdmin
# Instalação do PHP, Perl, Python
# Instalação das Depedências via cpan
#
# Utilizar o comando: sudo -i para executar o script
#
# Caminho para o Log do lamp.sh
LOG="/var/log/lamp.log"
#
#Arquivo de configuração de parâmetros
source 00-parametros.sh

if [ "$USUARIO" == "0" ]
then
	if [ "$UBUNTU" == "16.04" ]
		then
			if [ "$KERNEL" == "4.4" ]
				then
					 clear
					 echo -e "Usuário é `whoami`, continuando a executar o 02-lamp.sh"
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

					 echo -e "Instalando o LAMP Server (Linux, Apache, MySQL, PHP, Perl, Python), aguarde..."
					 
					 #Instalação dos principais pacotes do OCS Inventory e do GLPI integrado com o Apache2 e MySQL
					 #Configurando as variáveis do Debconf para a instalação do MySQL em modo Noninteractive
					 echo "mysql-server-5.7 mysql-server/root_password password $PASSWORD" |  debconf-set-selections
					 echo "mysql-server-5.7 mysql-server/root_password_again password $PASSWORD" |  debconf-set-selections
					 
					 #Instalando o LAMP Server completo e todas as suas dependêncais do OCS Inventory Server, Agent, GLPI Help Desk e do Netdata
					 apt-get -y install lamp-server^ mysql-server perl python make libapache2-mod-perl2 libapache2-mod-php snmp libio-compress-perl libxml-simple-perl libdbi-perl libdbd-mysql-perl libapache-dbi-perl libsoap-lite-perl libnet-ip-perl php-mysql php7.0-dev php-mbstring php-soap php7.0-zip php7.0-gd php7.0-mysql dmidecode libxml-simple-perl libcompress-raw-zlib-perl libnet-ip-perl libwww-perl libdigest-md5-file-perl libnet-ssleay-perl libcrypt-ssleay-perl libnet-snmp-perl libproc-pid-file-perl libproc-daemon-perl net-tools pciutils smartmontools read-edid nmap libc6-dev php-pclzip gcc libarchive-zip-perl php7.0-json php7.0-mbstring php7.0-mysql php7.0-curl php7.0-gd php7.0-imap php7.0-ldap ipmitool nmap zlib1g-dev gcc autoconf autogen automake pkg-config uuid-dev cups &>> $LOG
					 
					 echo -e "Instalação do LAMP Server feito com sucesso!!!, continuando com o script."
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
					 apt-get -y install phpmyadmin php-mbstring php-gettext &>> $LOG
					 
					 #Atualizando as dependências do PhpMyAdmin, ativando os recursos dos módulos do PHP no Apache2
					 phpenmod mcrypt
					 phpenmod mbstring
					 
					 echo -e "Instalação do PhpMyAdmin Feito com Sucesso!!!"
					 echo
					 echo -e "Pressione <Enter> para continuar com o script."
					 read
					 sleep 2
					 clear
					 echo ============================================================ >> $LOG

					 echo -e "Instalação das Dependências do Perl XML::Entities via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do XML::Entities
					 #Mensagem: Would you like to configure as much as possible automatically? Yes <-- digite Yes pressione <Enter>
					 perl -MCPAN -e 'install XML::Entities'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Instalação das Dependências do Perl SOAP::Lite via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do SOAP::Lite
					 #Mensagem: Do you want to install 'xml_pp' (XML pretty printer)?: y <-- digite y pressione <Enter>
					 #Mensagem: Do you want to install 'xml_grep' (XML grep - grep XML files using XML::Twig's subset of XPath)?: y <-- digite y pressione <Enter>
					 #Mensagem: Do you want to install 'xml_split' (split big XML files)?: y <-- digite y pressione <Enter>
					 #Mensagem: Do you want to install 'xml_merge' (merge back files created by xml_split)?: y <-- digite y pressione <Enter>
					 #Mensagem: Do you want to install 'xml_spellcheck' (spellcheck XML files skipping tags)?: y <-- digite y pressione <Enter>
					 #Mensagem: WARNING: Please tell me where I can find your apache src: q <-- digite q pressione <Enter>
					 perl -MCPAN -e 'install SOAP::Lite'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl XML::Simple via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do XML::Simple
					 perl -MCPAN -e 'install XML::Simple'
					 
					 echo
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Bundle::Compress::Zlib via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Bundle::Compress::Zlib
					 perl -MCPAN -e 'install install Bundle::Compress::Zlib'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl DBD::Mysql via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do DBD::mysql					 
					 perl -MCPAN -e 'install DBD::mysql'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Apache::DBI via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Apache::DBI					 
					 perl -MCPAN -e 'install Apache::DBI'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Net::IP via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Net::IP					 
					 perl -MCPAN -e 'install Net::IP'
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
					 
					 #Instalação do Apache2::SOAP					 
					 perl -MCPAN -e 'install Apache2::SOAP'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Digest::MD5 via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Digest::MD5					 
					 perl -MCPAN -e 'install Digest::MD5'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Proc::Daemon via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Proc::Daemon					 
					 perl -MCPAN -e 'install Proc::Daemon'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Proc::PID::File via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Proc::PID::File					 
					 perl -MCPAN -e 'install Proc::PID::File'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Linux::Ethtool::Settings via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Linux::Ethtool::Settings					 
					 perl -MCPAN -e 'install Linux::Ethtool::Settings'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl nvidia::ml via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do nvidia::ml
					 #OBSERVAÇÃO: UTILIZADO SOMENTE EM COMPUTADORES QUE TEM O CHIP GRÁFICO DA NVIDIA
					 #SERÁ APRESENTADO UMA MENSAGEM DE ERRO NO FINAL DA INSTALAÇÃO, USADO MAIS EM DESKTOP
					 perl -MCPAN -e 'install nvidia::ml'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Crypt::SSLeay via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Crypt::SSLeay					 
					 perl -MCPAN -e 'install Crypt::SSLeay'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl LWP::Protocol::https via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do LWP::Protocol::https					 
					 perl -MCPAN -e 'install LWP::Protocol::https'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Net::CUPS via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Net::CUPS					 
					 perl -MCPAN -e 'install Net::CUPS'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Net::SNMP via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Net::SNMP					 
					 perl -MCPAN -e 'install Net::SNMP'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Net::Netmask via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Net::Netmask					 
					 perl -MCPAN -e 'install Net::Netmask'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Net::Ping via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Net::Ping					 
					 perl -MCPAN -e 'install Net::Ping'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Nmap::Parser via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Nmap::Parser					 
					 perl -MCPAN -e 'install Nmap::Parser'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Module::Install via CPAN, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do Module::Install
					 #Mensagem: Continue anyways ? [y] <-- digite y pressione <Enter>
					 perl -MCPAN -e 'install Module::Install'
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

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

					 echo -e "Fim do lamp.sh em: `date`" >> $LOG
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
