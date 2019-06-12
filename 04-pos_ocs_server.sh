#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 18/06/2017
# Data de atualização: 12/06/2019
# Versão: 0.3
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
#Pós instalação do OCS Inventory Server
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
					 
					 echo -e "Usuário é `whoami`, continuando a executar o $LOGSCRIPT"
					 #Exportando a variável do Debian Frontend Noninteractive para não solicitar interação com o usuário
					 export DEBIAN_FRONTEND=noninteractive
					 echo
					 echo  ============================================================ >> $LOG

 					 echo -e "Alterando a senha do usuário ocs do MySQL, pressione <Enter> para continuar"
					 read
					 
					 #Alterando a senha do usário ocs utilizando o mysql command line
					 mysql -u $USER -p$PASSWORD -e "$SETOCSPWD" mysql &>> $LOG
					 echo -e "Senha alterada com suceso!!!"
					 sleep 2
					 
					 mysql -u $USER -p$PASSWORD -e "$FLUSH" mysql &>> $LOG
					 echo -e "Permissão alterada com sucesso!!!"
					 sleep 2
					 
					 echo
					 
					 echo -e "Senha alterada com Sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

 					 echo -e "Removendo o arquivo install.php do OCS Reports, pressione <Enter> para continuar"
					 read
					 
					 #Fazendo o backup do arquivo install.php
					 mv -v /usr/share/ocsinventory-reports/ocsreports/install.php /usr/share/ocsinventory-reports/ocsreports/install.php.bkp &>> $LOG
					 echo -e "Backup feito com sucesso!!!!"
					 sleep 2
					 
					 echo
					 
					 echo -e "Arquivo removido com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo -e "Atualizando os arquivos de configuração do OCS Inventory Server"
					 echo
					 echo -e "Editando o arquivo do OCS Inventory Server z-ocsinventory-server.conf, pressione <Enter> para continuar"
					 read
					 
					 #Arquivo de configuração do Servidor do OCS Inventory que vai receber as atualização do Clientes
					 #Fazendo o backup do arquivo de configuração original
					 mv -v /etc/apache2/conf-available/z-ocsinventory-server.conf /etc/apache2/conf-available/z-ocsinventory-server.conf.bkp &>> $LOG
					 echo -e "Backup feito com sucesso!!!"
					 sleep 2
					 
					 #Atualizando para o novo arquivo de configuração
					 cp -v conf/z-ocsinventory-server.conf /etc/apache2/conf-available/ &>> $LOG
					 echo -e "Atualização feita com sucesso!!!"
					 sleep 2
					 
					 #Editando o arquivo de configuração
					 vim /etc/apache2/conf-available/z-ocsinventory-server.conf
					 
					 echo -e "Arquivo editado com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 #echo -e "Editando o arquivo do OCS Inventory RestApi zz-ocsinventory-restapi.conf, pressione <Enter> para continuar"
					 #read
					 
					 #Arquivo de configuração do Servidor do OCS Inventory que vai receber as atualização do Clientes
					 #Fazendo o backup do arquivo de configuração original
					 #mv -v /etc/apache2/conf-available/zz-ocsinventory-restapi.conf /etc/apache2/conf-available/zz-ocsinventory-restapi.conf.bkp &>> $LOG
					 #echo -e "Backup feito com sucesso!!!"
					 #sleep 2
					 
					 #Atualizando para o novo arquivo de configuração
					 #cp -v conf/zz-ocsinventory-restapi.conf /etc/apache2/conf-available/ &>> $LOG
					 #echo -e "Atualização feita com sucesso!!!"
					 #sleep 2
					 
					 #Editando o arquivo de configuração
					 #vim /etc/apache2/conf-available/zz-ocsinventory-restapi.conf
					 
					 #echo -e "Arquivo editado com sucesso!!!, pressione <Enter> para continuar"
					 #read
					 #sleep 2
					 #clear
					 
					 echo -e "Atualizando os arquivos de configuração do OCS Inventory Reports"
					 echo
					 echo -e "Editando o arquivo do OCS Inventory Reports ocsinventory-reports.conf, pressione <Enter> para continuar"
					 read
					 
					 #Arquivo de configuração do Servidor do OCS Inventory Reports responsável pelos relatórios e distribuição dos softwares
					 #Fazendo o backup do arquivo de configuração original
					 mv -v /etc/apache2/conf-available/ocsinventory-reports.conf /etc/apache2/conf-available/ocsinventory-reports.conf.bkp &>> $LOG
					 echo -e "Backup feito com sucesso!!!"
					 sleep 2
					 
					 #Atualizando para o novo arquivo de configuração
					 cp -v conf/ocsinventory-reports.conf /etc/apache2/conf-available/ &>> $LOG
					 echo -e "Atualização feita com sucesso!!!"
					 sleep 2
					 
					 #Editando o arquivo de configuração
					 vim /etc/apache2/conf-available/ocsinventory-reports.conf
					 
					 echo -e "Arquivo editado com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Editando o arquivo do OCS Inventory Server DBConfig dbconfig.inc.php, pressione <Enter> para continuar"
					 read
					 
					 #Arquivo de configuração para conexão com o Banco de Dados do MySQL
					 #Configuração das variáveis de usuário e senha do banco de dados: database name (ocsweb) e user (ocs)
					 #Esse arquivo será recriado novamente após a instalação via navegador
					 #Fazendo o backup do arquivo de configuração original
					 mv -v /usr/share/ocsinventory-reports/ocsreports/dbconfig.inc.php /usr/share/ocsinventory-reports/ocsreports/dbconfig.inc.php.bkp &>> $LOG
					 echo -e "Backup feito com sucesso!!!"
					 sleep 2
					 
					 #Atualizando para o novo arquivo de configuração
					 cp -v conf/dbconfig.inc.php /usr/share/ocsinventory-reports/ocsreports/ &>> $LOG
					 echo -e "Atualização feita com sucesso!!!"
					 sleep 2
					 
					 #Editando o arquivo de configuração
					 vim /usr/share/ocsinventory-reports/ocsreports/dbconfig.inc.php
					 
					 #Reinicializando o Apache2
					 sudo service apache2 restart
					 echo -e "Apache2 reinicializado com sucesso!!!"
					 sleep 2
					 
					 echo -e "Arquivo editado com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear

					 echo ============================================================ >> $LOG

					 echo -e "Fim do $LOGSCRIPT em: `date`" >> $LOG
					 echo -e "Finalização da Pós-Instalação do OCS Inventory Server Feito com Sucesso!!!!!"
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
