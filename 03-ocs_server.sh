#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 04/01/2018
# Versão: 0.12
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Instalação do OCS Inventory Server
# Instalação do OCS Inventory Reports
#
# Utilizar o comando: sudo -i para executar o script
#

# Arquivo de configuração de parâmetros
source 00-parametros.sh
#

# Caminho para o Log do script
LOG=$VARLOGPATH/$LOGSCRIPT
#

if [ "$USUARIO" == "0" ]
then
	if [ "$UBUNTU" == "16.04" ]
		then
			if [ "$KERNEL" == "4.4" ]
				then
					 clear
					 
					 echo -e "Usuário é `whoami`, continuando a executar o ocs_server.sh"
					 
					 #Exportando a variável do Debian Frontend Noninteractive para não solicitar interação com o usuário
					 export DEBIAN_FRONTEND=noninteractive
					 echo
					 
					 echo  ============================================================ >> $LOG
					 
					 echo -e "Após a instalação, acessar a url: http://`hostname`/ocsreports e finalizar a instalação"
					 echo -e "Usuário padrão após a instalação: admin | Senha padrão: admin"
					 echo
					 
					 echo -e "Download do OCS Inventory Server do Github, pressione <Enter> para continuar"
					 read
					 sleep 2
					 echo -e "Aguarde, fazendo o download..."
					 
					 #Fazendo o download do código fonte do OCS Inventory Server
					 wget https://github.com/OCSInventory-NG/OCSInventory-ocsreports/releases/download/$OCSVERSION &>> $LOG
					 echo -e "Download feito com sucesso!!!!"
					 sleep 2
					 
					 #Descompactando o arquivos do OCS Inventory Server
					 tar -zxvf $OCSTAR &>> $LOG
					 echo -e "Arquivo descompactado com sucesso!!!!"
					 sleep 2
					 
					 #Acessando a pasta do OCS Inventory Server
					 cd $OCSINSTALL
					 echo -e "Pasta acessada com sucesso!!!!"
					 sleep 2
					 
					 echo
					 echo -e "CUIDADO!!! com as opções que serão solicitadas no decorrer da instalação."
					 echo -e "Download do OCS Inventory Server feito com Sucesso!!!, pressione <Enter> para instalar"
					 echo
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
					 #14. Do you  wish to setup Rest API server on this computer ([y]/n)?: y <-- digite y pressione <Enter>;
					 #15. Where do you want the API code to be store [/usr/local/share/perl/5.22.1]?: Deixe o padrão pressione <Enter>;
					 #16. Do you allow Setup renaming Communication Server Apache configuration file to 'z-ocsinventory-server.conf' ([y]/n)?: y <-- digite y pressione <Enter>;
					 #17. Do you wish to setup Administration Server (Web Administration Console) on this computer ([y]/n)?: y <-- digite y pressione <Enter>;
					 #18. Do you wish to continue ([y]/n)?: y <-- digite y pressione <Enter>;
					 #19. Where to copy Administration Server static files for PHP Web Console [/usr/share/ocsinventory-reports]?: Deixe o padrão pressione <Enter>;
					 #20. Where to create writable/cache directories for deployment packages administration console logs, IPDiscover and SNMP [/var/lib/ocsinventory-reports]?: Deixe o padrão pressione <Enter>;
					 #APÓS A INSTALAÇÃO VIA NAVEGADOR, REMOVER O ARQUIVO install
					 
					 echo
					 #Atualizando as informações do Apache2 para o suporte ao OCS Inventory Server e Reports
					 a2dissite 000-default
					 echo -e "Apache 2 atualizado com sucesso!!!"
					 sleep 2
					 
					 echo
					 #Habilitando o conf do OCS Inventory Reports no Apache2
					 a2enconf ocsinventory-reports
					 echo -e "Virtual host do OCS Inventory Reports habilitado com sucesso!!!"
					 sleep 2
					 
					 echo
					 #Habilitando o conf do OCS Inventory Server no Apache2
					 a2enconf z-ocsinventory-server
					 echo -e "Virtual host do OCS Inventory Server habilitado com sucesso!!!"
					 sleep 2
					 
					 echo
					 #Alterando as permissões do diretório /var/lib/ocsinventory-reports
					 chmod -Rv 775 /var/lib/ocsinventory-reports/ &>> $LOG
					 echo -e "Permissões do OCS Inventory Reports alteradas com sucesso!!!"
					 sleep 2
					 
					 echo
					 #Alterando o dono e grupo padrão do diretório /var/lib/ocsinventory-reports
					 chown -Rv www-data.www-data /var/lib/ocsinventory-reports/ &>> $LOG
					 echo -e "Dono/Grupo do OCS Inventory Reports alteradas com sucesso!!!"
					 sleep 2
					 
					 echo
					 #Reinicializando o Apache2
					 sudo service apache2 restart
					 echo -e "Apache 2 reinicializado com sucesso!!!"
					 sleep 2
					 
					 #Saindo do diretório do OCS Inventory Server
					 cd ..
					 
					 echo
					 echo -e "Instalação do OCS Inventory Server e Reports Service feito com Sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 				 
					 echo -e "Removendo aplicativos desnecessários, aguarde..."
					 
					 #Removendo arquivos que não são mais utilizados
					 apt-get autoremove &>> $LOG
					 
					 echo -e "Aplicativos removidos com Sucesso!!!, continuando com o script!!!"
					 echo
					 echo ============================================================ >> $LOG

					 echo -e "Limpando o Cache do Apt-Get, aguarde..."
					 
					 #Limpando o diretório de cache do apt-get
					 apt-get clean &>> $LOG
					 
					 echo -e "Cache Limpo com Sucesso!!!"
					 echo
					 echo ============================================================ >> $LOG

					 echo -e "Fim do ocs_server.sh em: `date`" >> $LOG
					 echo -e "Instalação do OCS Inventory Server Feito com Sucesso!!!!!"
					 echo -e "Após a reinicializar, acessar a url: http://ENDEREÇO_IP_DO_SERVIDOR/ocsreports e finalizar a instalação"
					 echo
					 # Script para calcular o tempo gasto para a execução do ocs_server.sh
						 DATAFINAL=`date +%s`
						 SOMA=`expr $DATAFINAL - $DATAINICIAL`
						 RESULTADO=`expr 10800 + $SOMA`
						 TEMPO=`date -d @$RESULTADO +%H:%M:%S`
					 echo -e "Tempo gasto para execução do ocs_server.sh: $TEMPO"
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
