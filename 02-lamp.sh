#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 29/09/2016
# Versão: 0.10
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
					 # Variáveis de configuração da senha do MySQL Server
					 PASSWORD="123456"
 					 
 					 # Variáveis de configuração do PhpMyAdmin
					 APP_PASSWORD="123456"
					 ADMIN_PASS="123456"
					 APP_PASS="123456"
					 WEBSERVER="apache2"
					 ADMINUSER="root"
					 
					 # Variáveis de configuração do OCS Inventory Server
					 OCSVERSION="2.2.1/OCSNG_UNIX_SERVER-2.2.1.tar.gz"
					 OCSTAR="OCSNG_UNIX_SERVER-2.2.1.tar.gz"
					 OCSINSTALL="OCSNG_UNIX_SERVER-2.2.1"
					 
 					 # Variáveis de configuração do GLPI Help Desk
					 GLPIVERSION="9.1/glpi-9.1.tar.gz"
					 GLPITAR="glpi-9.1.tar.gz"
					 GLPIINSTALL="glpi"
					 
					 #Variaǘeis de configuração do Plugin do OCS Inventory do GLPI
					 GLPIOCSVERSION="1.2.3/glpi-ocsinventoryng-1.2.3.tar.gz"
					 GLPIOCSTAR="glpi-ocsinventoryng-1.2.3.tar.gz"
					 GLPIOCSINSTALL="ocsinventoryng"

					 #Exportando a variável do Debian Frontend Noninteractive para não solicitar interação com o usuário
					 export DEBIAN_FRONTEND=noninteractive
					 
					 echo -e "Usuário é `whoami`, continuando a executar o Install.sh"
					 echo
					 echo  ============================================================ >> $LOG
					 
					 echo -e "Atualizando as Listas do Apt-Get, aguarde..."
					 #Atualizando as listas do apt-get
					 apt-get update &>> $LOG
					 echo -e "Listas Atualizadas com Sucesso!!!, continuando com o script."
					 echo
					 echo  ============================================================ >> $LOG

					 echo -e "Instalando os principais pacotes para o OCS Inventory - LAMP Server, aguarde..."
					 #Instalação dos principais pacotes do OCS Inventory integrado com o Apache2 e MySQL
					 #Configurando as variáveis do Debconf para a instalação do MySQL em modo Noninteractive
					 echo "mysql-server-5.7 mysql-server/root_password password $PASSWORD" |  debconf-set-selections
					 echo "mysql-server-5.7 mysql-server/root_password_again password $PASSWORD" |  debconf-set-selections
					 #Instalando o LAMP Server completo e todas as dependêncais do OCS Inventory
					 apt-get -y install lamp-server^ perl python make libapache2-mod-perl2 libapache2-mod-php snmp libio-compress-perl libxml-simple-perl libdbi-perl libdbd-mysql-perl libapache-dbi-perl libsoap-lite-perl libnet-ip-perl php-mysql php7.0-dev php-mbstring php-soap php7.0-zip php7.0-gd php7.0-mysql dmidecode libxml-simple-perl libcompress-raw-zlib-perl libnet-ip-perl libwww-perl libdigest-md5-file-perl libnet-ssleay-perl libcrypt-ssleay-perl libnet-snmp-perl libproc-pid-file-perl libproc-daemon-perl net-tools pciutils smartmontools read-edid nmap libc6-dev php-pclzip gcc libarchive-zip-perl php7.0-json php7.0-mbstring php7.0-mysql php7.0-curl php7.0-gd php7.0-imap php7.0-ldap &>> $LOG
					 echo -e "Instalação dos principais pacotes do OCS Inventory feito com sucesso!!!, continuando com o script."
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
					 #Atualização o arquivo de configuração do Apache2
					 #Fazendo o backup do arquivo original
					 cp -v /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bkp >> $LOG
					 #Adicionando no final do arquivo a opção de ServerName
					 echo "ServerName localhost" >> /etc/apache2/apache2.conf
					 #Reinicializando o serviço do Apache2 Server
					 sudo service apache2 restart
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
					 #Mensagem: WARNING: Please tell me where I can find your apache src: q <-- digite q pressione <Enter>
					 #Mensagem: Do you want to install 'xml_pp' (XML pretty printer)?: y <-- digite y pressione <Enter>
					 #Mensagem: Do you want to install 'xml_grep' (XML grep - grep XML files using XML::Twig's subset of XPath)?: y <-- digite y pressione <Enter>
					 #Mensagem: Do you want to install 'xml_split' (split big XML files)?: y <-- digite y pressione <Enter>
					 #Mensagem: Do you want to install 'xml_merge' (merge back files created by xml_split)?: y <-- digite y pressione <Enter>
					 #Mensagem: Do you want to install 'xml_spellcheck' (spellcheck XML files skipping tags)?: y <-- digite y pressione <Enter>
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
					 
					 echo -e "Download do OCS Inventory Server do Github, pressione <Enter> para continuar"
					 read
					 sleep 2
					 #Fazendo o download do código fonte do OCS Inventory Server
					 wget https://github.com/OCSInventory-NG/OCSInventory-ocsreports/releases/download/$OCSVERSION &>> $LOG
					 #Descompactando o arquivos do OCS Inventory Server
					 tar -zxvf $OCSTAR &>> $LOG
					 #Acessando a pasta do OCS Inventory
					 cd $OCSINSTALL
					 echo -e "Download do OCS Inventory feito com sucesso, pressione <Enter> para instalar o OCS Inventory Server"
					 echo
					 echo -e "CUIDADO com as opções que serão solicitadas no decorrer da instalação."
					 read
					 clear
					 #Executando a instalação do OCS Inventory Server e Reports
					 ./setup.sh
					 #MENSAGENS QUE SERÃO SOLICIDATAS NA INSTALAÇÃO DO OCS INVENTORY SERVER:
					 #01. Do you wish to continue ([y]/n): y <-- digite y pressione <Enter>;
					 #02. Which host is running database server [localhost]?: Deixe o padrão pressione <Enter>;
					 #03. On which port is running database server [3306]?: Deixe o padrão pressione <Enter>;
					 #04. Where is Apache daemon binary [/usr/sbin/apache2ctl]?: Deixe o padrão pressione <Enter>;
					 #05. Where is Apache main configuration file [/etc/apache2/apache2.conf]?: Deixe o padrão pressione <Enter>;
					 #06. Which user account is running Apache Web Server [www-data]?: Deixe o padrão pressione <Enter>;
					 #07. Which user group is running Apache web server [www-data]?: Deixe o padrão pressione <Enter>;
					 #08. Where is Apache Include configuration directory [/etc/apache2/conf-available]?: Deixe o padrão pressione <Enter>;
					 #09. Where is PERL Intrepreter binary [/usr/bin/perl]?: Deixe o padrão pressione <Enter>;
					 #10. Do you wish to setup Communication server on this computer ([y]/n)?: y <-- digite y pressione <Enter>;
					 #11. Where to put Communication server log directory [/var/log/ocsinventory-server]?: Deixe o padrão pressione <Enter>;
					 #12. Where to put Communication server plugins configuration files [/etc/ocsinventory-server/plugins]?: Deixe o padrão pressione <Enter>;
					 #13. Where to put Communication server plugins Perl module files [/etc/ocsinventory-server/perl]?: Deixe o padrão pressione <Enter>;
					 #MENSAGEM: NÃO SE PREOCUPE COM A MENSAGEM DE ERRO DO Apache2::SOAP PERL module..
					 #14. Do you wish to continue ([y]/n)?: y <-- digite y pressione <Enter>;
					 #15. Do you allow Setup renaming Communication Server Apache configuration file to 'z-ocsinventory-server.conf' ([y]/n)?: y <-- digite y pressione <Enter>;
					 #16. Do you wish to setup Administration Server (Web Administration Console) on this computer ([y]/n)?: y <-- digite y pressione <Enter>;
					 #17. Do you wish to continue ([y]/n)?: y <-- digite y pressione <Enter>;
					 #18. Where to copy Administration Server static files for PHP Web Console [/usr/share/ocsinventory-reports]?: Deixe o padrão pressione <Enter>;
					 #19. Where to create writable/cache directories for deployment packages administration console logs, IPDiscover and SNMP [/var/lib/ocsinventory-reports]?: Deixe o padrão pressione <Enter>;
					 #APÓS A INSTALAÇÃO VIA NAVEGADOR, REMOVER O ARQUIVO install
					 #Atualizando as informações do Apache2 para o suporte ao OCS Inventory Server e Reports
					 a2dissite 000-default
					 #Habilitando o conf do OCS Inventory Reports no Apache2
					 a2enconf ocsinventory-reports
					 #Habilitando o conf do OCS Inventory Server no Apache2
					 a2enconf z-ocsinventory-server
					 #Reinicializando o Apache2
					 sudo service apache2 restart
					 #Saindo do diretório do OCS Iventory
					 cd ..
					 echo
					 echo -e "Instalação do OCS Inventory Server e Reports feito com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Atualizando os arquivos de configuração do OCS Inventory"
					 echo
					 echo -e "Editando o arquivo do OCS Inventory Server, pressione <Enter> para continuar"
					 #Arquivo de configuração do Servidor do OCS Inventory que vai receber as atualização do Clientes
					 read
					 #Fazendo o backup do arquivo de configuração original
					 cp -v /etc/apache2/conf-available/z-ocsinventory-server.conf /etc/apache2/conf-available/z-ocsinventory-server.conf.bkp &>> $LOG
					 #Atualizando para o novo arquivo de configuração
					 cp -v conf/z-ocsinventory-server.conf /etc/apache2/conf-available/ &>> $LOG
					 #Editando o arquivo de configuração
					 vim /etc/apache2/conf-available/z-ocsinventory-server.conf
					 echo -e "Arquivo editado com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Editando o arquivo do OCS Inventory Server DBConfig, pressione <Enter> para continuar"
					 #Arquivo de configuração para conexão com o Banco de Dados do MySQL
					 #Configuração das variáveis de usuário e senha do banco de dados: database name (ocsweb) e user (ocs)
					 read
					 #Fazendo o backup do arquivo de configuração original
					 cp -v /usr/share/ocsinventory-reports/ocsreports/dbconfig.inc.php /usr/share/ocsinventory-reports/ocsreports/dbconfig.inc.php.bkp &>> $LOG
					 #Atualizando para o novo arquivo de configuração
					 cp -v conf/dbconfig.inc.php /usr/share/ocsinventory-reports/ocsreports/ &>> $LOG
					 #Editando o arquivo de configuração
					 vim /usr/share/ocsinventory-reports/ocsreports/dbconfig.inc.php
					 echo -e "Arquivo editado com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Editando o arquivo do MySQL Server, pressione <Enter> para continuar"
					 #Arquivo de configuração do Banco de Dados do MySQL Server
					 #Permitir acesso aremoto ao MySQL comentando a linha: bind-address
					 read
					 #Fazendo o backup do arquivo de configuração original
					 cp -v /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.bkp &>> $LOG
					 #Atualizando para o novo arquivo de configuração
					 cp -v conf/mysqld.cnf /etc/mysql/mysql.conf.d/ &>> $LOG
					 #Editando o arquivo de configuração
					 vim /etc/mysql/mysql.conf.d/mysqld.cnf
					 #Reinicializando o serviço do MySQL Server
					 sudo service mysql restart
					 echo -e "Arquivo editado com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Editando o arquivo do PHP, pressione <Enter> para continuar"
					 #Arquivo de configuração do PHP que será utilizado pelo Apache2
					 #Aumentar os valores das váriaveis: post_max_size e upload_max_filesize para: 250MB
					 read
					 #Fazendo o backup do arquivo de configuração original
					 cp -v /etc/php/7.0/apache2/php.ini /etc/php/7.0/apache2/php.ini.bkp &>> $LOG
					 #Atualizando para o novo arquivos de configuração
					 cp -v conf/php.ini /etc/php/7.0/apache2/ &>> $LOG
					 #Editando o arquivo de configuração
					 vim /etc/php/7.0/apache2/php.ini
					 #Reinicializando o serviço do Apache2
					 sudo service apache2 restart
					 echo -e "Arquivo editado com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Instalando o Cliente do OCS Inventory Agent, pressione <Enter> para continuar"
					 read
					 sleep 2
					 echo
					 apt-get -y install ocsinventory-agent &>> $LOG
					 echo -e "Instalação feita com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Editando o arquivo do OCS Inventory Agent, pressione <Enter> para continuar"
					 #Arquivo de configuração do OCS Agent (Cliente)
					 read
					 #Fazendo o backup do arquivo de configuração original
					 cp -v /etc/ocsinventory/ocsinventory-agent.cfg /etc/ocsinventory/ocsinventory-agent.cfg.bkp &>> $LOG
					 #Atualizando para o novo arquivo de configuração
					 cp -v conf/ocsinventory-agent.cfg /etc/ocsinventory/ &>> $LOG
					 #Editando o arquivo de configuração
					 vim /etc/ocsinventory/ocsinventory-agent.cfg
					 echo -e "Arquivo editado com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Download do GLPI Help Desk do Github, pressione <Enter> para continuar"
					 read
					 sleep 2
					 #Fazendo o download do código fonte do GLPI Help Desk
					 wget https://github.com/glpi-project/glpi/releases/download/$GLPIVERSION &>> $LOG
					 #Descompactando o arquivos do GLPI Help Desk
					 tar -zxvf $GLPITAR &>> $LOG
					 #Movendo a pasta do GLPI Help Desk para /var/www/html/
					 mv -v $GLPIINSTALL /var/www/html/ &>> $LOG
					 #Fazendo o download do código fonte do Plugin do OCS Inventory
					 wget https://github.com/pluginsGLPI/ocsinventoryng/releases/download/$GLPIOCSVERSION &>> $LOG
					 #Descompactando o arquivo do Plugin do OCS Inventory
					 tar -zxvf $GLPIOCSTAR &>> $LOG
					 #Movendo a pasta do Plugin do OCS Inventory para o GLPI
					 mv -v $GLPIOCSINSTALL /var/www/html/glpi/plugins/ &>> $LOG
					 #Alterando as permissões de Dono e Grupo da pasta do GLPI Help Desk
					 chown -Rf www-data.www-data /var/www/html/glpi/ &>> $LOG
					 #MENSAGENS QUE SERÃO SOLICIDATAS NA INSTALAÇÃO DO GLPI HELP DESK VIA NAVEGADOR:
					 #01. Selecione a linguage: Português do Brasil <OK>;
					 #02. Licença: Eu li e ACEITO os termons de licença acima: <Continuar>;
					 #03. Início da Instalação: <Instalar>;
					 #04. Etapa 0: <Continuar>;
					 #05. Etapa 1: localhost, root, 123456 <Continuar>;
					 #06. Etapa 2: Selecione o banco de dados: glpi <Continuar>;
					 #07. Etapa 3: <Continuar>;
					 #08. Etapa 4: <Usar o GLPI>.
					 #USUÁRIOS QUE SERÃO UTILIZADOS NO GLPI HELP DESK
					 #glpi/glpi para a conta do usuário administrador
    					 #tech/tech para a conta do usuário técnico
    					 #normal/normal para a conta do usuário normal
    					 #post-only/postonly para a conta do usuário postonly
					 #APÓS A INSTALAÇÃO VIA NAVEGADOR, REMOVER A PASTA glpi/install
					 echo -e "Download do GLPI feito com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Removendo aplicativos desnecessários"
					 #Limpando o diretório de cache do apt-get
					 apt-get autoremove &>> $LOG
					 echo -e "Aplicativos removidos com Sucesso!!!"
					 echo
					 echo ============================================================ >> $LOG

					 echo -e "Limpando o Cache do Apt-Get"
					 #Limpando o diretório de cache do apt-get
					 apt-get clean &>> $LOG
					 echo -e "Cache Limpo com Sucesso!!!"
					 echo
					 echo ============================================================ >> $LOG

					 echo -e "Fim do Install.sh em: `date`" >> $LOG
					 echo -e "Instalação do OCS Inventory Server Feito com Sucesso!!!!!"
					 echo
					 # Script para calcular o tempo gasto para a execução do Install.sh
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
