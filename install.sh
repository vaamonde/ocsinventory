#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 31/08/2016
# Versão: 0.8
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Instalação do OCS Inventory Server
#
# Utilizar o comando: sudo -i para executar o script
#
# Caminho para o Log do install.sh
LOG="/var/log/install.log"
#
# Variável da Data Inicial para calcular tempo de execução do Script
DATAINICIAL=`date +%s`
#
# Validando o ambiente, verificando se o usuário e "root"
USUARIO=`id -u`
UBUNTU=`lsb_release -rs`
KERNEL=`uname -r | cut -d'.' -f1,2`

if [ "$USUARIO" == "0" ]
then
	if [ "$UBUNTU" == "16.04" ]
		then
			if [ "$KERNEL" == "4.4" ]
				then
					 clear
					 # Variáveis de configuração da senha do MySQL
					 PASSWORD="123456"
 					 
 					 # Variáveis de configuração do PhpMyAdmin
					 APP_PASSWORD="123456"
					 ADMIN_PASS="123456"
					 APP_PASS="123456"
					 WEBSERVER="apache2"
					 ADMINUSER="root"
					 
					 # Variáveis do OCS Inventory Server
					 OCSVERSION="2.2.1/OCSNG_UNIX_SERVER-2.2.1.tar.gz"
					 OCSTAR="OCSNG_UNIX_SERVER-2.2.1.tar.gz"
					 OCSINSTALL="OCSNG_UNIX_SERVER-2.2.1"

					 #Exportando a variavel do Debian Frontend Noninteractive para não solicitar interação com o usuário
					 export DEBIAN_FRONTEND=noninteractive
					 
					 echo -e "Usuário é `whoami`, continuando a executar o Install.sh"
					 echo  ============================================================ >> $LOG
					 
					 echo -e "Atualizando as Listas do Apt-Get, aguarde..."
					 #Atualizando as listas do apt-get
					 apt-get update &>> $LOG
					 echo -e "Listas Atualizadas com Sucesso!!!"
					 echo  ============================================================ >> $LOG

					 echo -e "Instalando os principais pacotes do OCS Inventory, aguarde..."
					 #Instalação do principais pacotes do OCS Inventory integrado com o Apache2 e MySQL
					 #Configurando as variaveis do Debconf para a instalação do MySQL em modo Noninteractive
					 echo "mysql-server-5.7 mysql-server/root_password password $PASSWORD" |  debconf-set-selections
					 echo "mysql-server-5.7 mysql-server/root_password_again password $PASSWORD" |  debconf-set-selections
					 #Instalando o LAMP Server completo e as dependêncais do OCS Inventory
					 apt-get -y install lamp-server^ perl python make libapache2-mod-perl2 libapache2-mod-php snmp libio-compress-perl libxml-simple-perl libdbi-perl libdbd-mysql-perl libapache-dbi-perl libsoap-lite-perl libnet-ip-perl php-mysql php7.0-dev php-mbstring php-soap php7.0-zip php7.0-gd php7.0-mysql dmidecode libxml-simple-perl libcompress-raw-zlib-perl libnet-ip-perl libwww-perl libdigest-md5-file-perl libnet-ssleay-perl libcrypt-ssleay-perl libnet-snmp-perl libproc-pid-file-perl libproc-daemon-perl net-tools pciutils smartmontools read-edid nmap libc6-dev &>> $LOG
					 echo -e "Instalação dos principais pacotes do OCS Invetory feito com sucesso!!!"
					 echo  ============================================================ >> $LOG

					 echo -e "Instalando o PhpMyAdmin, aguarde..."
					 #Configurando as variaveis do Debconf para a instalação do PhpMyAdmin em modo Noninteractive
					 echo "phpmyadmin phpmyadmin/internal/skip-preseed boolean true" |  debconf-set-selections
					 echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" |  debconf-set-selections
					 echo "phpmyadmin phpmyadmin/app-password-confirm password $APP_PASSWORD" |  debconf-set-selections
					 echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect $WEBSERVER" |  debconf-set-selections
					 echo "phpmyadmin phpmyadmin/mysql/admin-user string $ADMINUSER" |  debconf-set-selections
					 echo "phpmyadmin phpmyadmin/mysql/admin-pass password $ADMIN_PASS" |  debconf-set-selections
					 echo "phpmyadmin phpmyadmin/mysql/app-pass password $APP_PASS" |  debconf-set-selections
					 #Instalando o PhpMyAdmin
					 apt-get -y install phpmyadmin php-mbstring php-gettext &>> $LOG
					 #Atualizando as dependências do PhpMyAdmin, ativando os recursos de módulos do PHP no Apache2
					 phpenmod mcrypt
					 phpenmod mbstring
					 #Reinicializando o serviço do Apache2 Server
					 sudo service apache2 restart
					 echo -e "Instalação do PhpMyAdmin Feito com Sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 echo ============================================================ >> $LOG

					 echo -e "Instalação das Dependências do Perl XML::Entities via CPAN, pressione <Enter> para continuar"
					 read
					 #Instalação do XML::Entities					 
					 perl -MCPAN -e 'install XML::Entities'
					 echo -e "Instalação concluida com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Instalação das Dependências do Perl SOAP::Lite via CPAN, pressione <Enter> para continuar"
					 read
					 #Instalação do SOAP::Lite					 
					 perl -MCPAN -e 'install SOAP::Lite'
					 echo -e "Instalação concluida com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl XML::Simple via CPAN, pressione <Enter> para continuar"
					 read
					 #Instalação do XML::Simple					 
					 perl -MCPAN -e 'install XML::Simple'
					 echo -e "Instalação concluida com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Compress::Zlib via CPAN, pressione <Enter> para continuar"
					 read
					 #Instalação do Compress::Zlib					 
					 perl -MCPAN -e 'install Compress::Zlib'
					 echo -e "Instalação concluida com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl DBD::Mysql via CPAN, pressione <Enter> para continuar"
					 read
					 #Instalação do DBD::Mysql					 
					 perl -MCPAN -e 'install DBD::Mysql'
					 echo -e "Instalação concluida com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Apache::DBI via CPAN, pressione <Enter> para continuar"
					 read
					 #Instalação do Apache::DBI					 
					 perl -MCPAN -e 'install Apache::DBI'
					 echo -e "Instalação concluida com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Net::IP via CPAN, pressione <Enter> para continuar"
					 read
					 #Instalação do Net::IP					 
					 perl -MCPAN -e 'install Net::IP'
					 echo -e "Instalação concluida com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Instalação das Dependências do Perl Linux::Ethtool via CPAN, pressione <Enter> para continuar"
					 read
					 #Instalação do Linux::Ethtool					 
					 perl -MCPAN -e 'install Linux::Ethtool'
					 echo -e "Instalação concluida com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Download do OCS Inventory Server do Github, pressione <Enter> para continuar"
					 read
					 sleep 2
					 #Fazendo o download do código fonte do OCS Inventory Server
					 wget https://github.com/OCSInventory-NG/OCSInventory-ocsreports/releases/download/$OCSVERSION &>> $LOG
					 #Descompactando o OCS Inventory
					 tar -zxvf $OCSTAR &>> $LOG
					 #Acessando a pasta do OCS Inventory
					 cd $OCSINSTALL
					 echo -e "Download do OCS Inventory feito com sucesso, pressione <Enter> para instalar o OCS Inventory Server"
					 echo -e "Cuidado com as opções que serão solicitadas no decorrer da instalação"
					 read
					 clear
					 #Executando a instalação do OCS Inventory Server e Reports
					 ./setup.sh
					 #Atualizando as informações do Apache2 para o suporte do OCS Inventory
					 a2dissite 000-default
					 #Habilitando o conf do OCS Inventory Reports
					 a2enconf ocsinventory-reports
					 #Habilitando o conf do OCS Inventory Server
					 a2enconf z-ocsinventory-server
					 #Reinicializando o Apache2
					 sudo service apache2 restart
					 echo -e "Instalação do OCS Inventory Server e Reports feito com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Atualizando os arquivos de configuração do OCS Inventory"
					 echo -e "Editando o arquivo do OCS Inventory Server, pressione <Enter> para continuar"
					 read
					 cp conf/z-ocsinventory-server.conf /etc/apache2/conf-available/
					 vim /etc/apache2/conf-available/z-ocsinventory-server.conf
					 echo -e "Arquivo editado com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Editando o arquivo do OCS Inventory Server DBConfig, pressione <Enter> para continuar"
					 read
					 cp conf/dbconfig.inc.php /usr/share/ocsinventory-reports/ocsreports/
					 vim /usr/share/ocsinventory-reports/ocsreports/dbconfig.inc.php
					 echo -e "Arquivo editado com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Editando o arquivo do MySQL Server, pressione <Enter> para continuar"
					 read
					 cp conf/mysqld.cnf /etc/mysql/mysql.conf.d/
					 vim /etc/mysql/mysql.conf.d/mysqld.cnf
					 sudo service mysql restart
					 echo -e "Arquivo editado com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Editando o arquivo do PHP, pressione <Enter> para continuar"
					 read
					 cp conf/php.ini /etc/php/7.0/apache2/
					 vim /etc/php/7.0/apache2/php.ini
					 sudo service apache2 restart
					 echo -e "Arquivo editado com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 

	
					 echo -e "Limpando o Cache do Apt-Get"
					 #Limpando o diretório de cache do apt-get
					 apt-get clean &>> $LOG
					 echo -e "Cache Limpo com Sucesso!!!"
					 echo ============================================================ >> $LOG
					 
					 echo >> $LOG
					 echo -e "Fim do Install.sh em: `date`" >> $LOG
					 echo
					 echo -e "Instalação do OCS Inventory Feito com Sucesso!!!!!"
					 echo
					 # Script para calcular o tempo gasto para a execução do script-00.sh
						 DATAFINAL=`date +%s`
						 SOMA=`expr $DATAFINAL - $DATAINICIAL`
						 RESULTADO=`expr 10800 + $SOMA`
						 TEMPO=`date -d @$RESULTADO +%H:%M:%S`
					 echo -e "Tempo gasto para execução do Install.sh: $TEMPO"
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
