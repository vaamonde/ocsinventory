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
# Instalação do Netdata
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
					 
					 echo -e "Instalação do sistema de monitoramente em tempo real Netdata"
					 echo -e "Após a instalação acessar a URL http://`hostname`:19999"
					 echo -e "Pressione <Enter> para instalar"
					 read
					 sleep 2
					 echo
					 
					 echo -e "Removendo o arquivo install do GLPI"
					 #Removendo o diretório install do GLPI
					 mv -v /var/www/html/glpi/install /var/www/html/glpi/install.bkp &>> $LOG
					 echo -e "Arquivo removido com sucesso!!!"
					 
					 echo -e "Clonando o Netdata"
					 #Clonando o site do GitHub do Netdata
					 git clone https://github.com/firehol/$NETDATAVERSION --depth=1 &>> $LOG
					 
					 echo -e "Clonagem do software do Netdata feito com sucesso!!!"
					 echo
					 
					 echo -e "Acessando o diretório do Netdata"
					 #Acessando o diretório do Netdata
					 cd $NETDATAINSTALL
					 
					 #Compilando e instalando o Netdata
					 echo -e "Pressione <Enter> para compilar o software do NetData"
					 echo
					 read
					 
					 #Executando o script de instalação do Netdata
					 ./netdata-installer.sh
					 
					 #MENSAGENS QUE SERÃO SOLICITADAS NA INSTALAÇÃO DO NETDATA
					 #Press ENTER to build and install netdata to your system? <-- pressione <Enter>
					 #Saindo do diretório do Netdata
					 cd ..
					 
					 echo
					 echo -e "Instalação do Netdata feita com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Instalação das dependências do PIP para o monitoramento do MySQL via Netdata, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Atualizando o PIP"
					 pip install --upgrade pip
					 
					 echo 
					 
					 echo -e "Instalando o MySQLCliente"
					 pip install mysqlclient
					 
					 echo
					 
					 echo -e "Instalando o PyMySQL"
					 pip install PyMySQL
					 
					 echo
					 echo -e "Instalação das dependências do PIP feita com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Atualizando o arquivo de configuração do MySQL para acesso as informações via Netdata, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Fazendo o backup das configurações"
					 #Fazendo o backup das configurações do arquivo do mysql.conf
					 mv -v /etc/netdata/python.d/mysql.conf /etc/netdata/python.d/mysql.conf.old &>> $LOG
					 echo -e "Backup feito com sucesso!!!"
					 
					 echo
					 
					 echo -e "Atualizando o arquivo de configuração"
					 #Fazendo a atualização do arquivo de configuração do MySQL
					 cp -v conf/mysql.conf /etc/netdata/python.d/ &>> $LOG
					 echo -e "Arquivo atualizado com sucesso!!!"
					 
					 echo
					 
					 echo -e "Alterando as permissões do arquivo Mysql.conf"
					 #Alterando o dono/grupo do arquivo
					 chown -v netdata.netdata /etc/netdata/python.d/mysql.conf &>> $LOG
					 #Alterando as permissões de acesso ao arquivo
					 chmod -v 660 /etc/netdata/python.d/mysql.conf &>> $LOG
					 echo -e "Permissões alteradas com sucesso!!!"
					 
					 echo
					 
					 echo -e "Editando o arquivo de configuração do MySQL"
					 sleep 2
					 #Editando o arquivo de configuração do mysqlconf
					 vim /etc/netdata/python.d/mysql.conf
					 
					 echo -e "Reinicializando o serviço do Netdata"
					 #Reinicializando o serviços do Netdata
					 sudo service netdata restart
					 
					 echo -e "Arquivo editado com sucesso!!!, pressione <Enter> para continuar."
					 read
					 sleep 2
					 clear
					 
					 echo -e "Fim do $LOGSCRIPT em: `date`" >> $LOG
					 echo -e "Instalação do Netdata feito com Sucesso!!!!!"
					 echo
					 # Script para calcular o tempo gasto para a execução do netdata.sh
						 DATAFINAL=`date +%s`
						 SOMA=`expr $DATAFINAL - $DATAINICIAL`
						 RESULTADO=`expr 10800 + $SOMA`
						 TEMPO=`date -d @$RESULTADO +%H:%M:%S`
					 echo -e "Tempo gasto para execução do netdata.sh: $TEMPO"
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
