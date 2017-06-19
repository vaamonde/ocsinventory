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
# Instalação do OCS Inventory Agent
#
# Utilizar o comando: sudo -i para executar o script
#
# Caminho para o Log do ocs_agent.sh
LOG="/var/log/ocs_agent.log"
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
					 
					 echo -e "Usuário é `whoami`, continuando a executar o ocs_agent.sh"
					 #Exportando a variável do Debian Frontend Noninteractive para não solicitar interação com o usuário
					 export DEBIAN_FRONTEND=noninteractive
					 echo
					 echo  ============================================================ >> $LOG
					 
					 
					 echo -e "Download do OCS Inventory Agent do Github, pressione <Enter> para continuar"
					 read
					 sleep 2
					 
					 #Fazendo o download do código fonte do OCS Inventory Agent
					 wget https://github.com/OCSInventory-NG/UnixAgent/releases/download/$OCSAGENTVERSION &>> $LOG
					 echo -e "Download feito com sucesso!!!"
					 sleep 2
					 
					 #Descompactando o arquivos do OCS Inventory Agent
					 tar -zxvf $OCSAGENTTAR &>> $LOG
					 echo -e "Descompactação feita com sucesso!!!"
					 sleep 2
					 
					 #Acessando a pasta do OCS Inventory Agent
					 cd $OCSAGENTINSTALL
					 echo -e "Acessando a pasta do OCS Inventory Agent"
					 sleep 2
					 
					 #Criando o diretório de Log do OCS Inventory Agent
					 mkdir -v /var/log/ocsinventory-agent/ &>> $LOG
					 echo -e "Criação do diretório de log feito com sucesso!!!"
					 sleep 2
					 
					 #Criando o arquivo de Log do OCS Inventory Agent
					 touch /var/log/ocsinventory-agent/activity.log
					 echo -e "Criação do arquivo de log feito com sucesso!!!"
					 sleep 2
					 
					 echo -e "Download do OCS Inventory Agent feito com Sucesso!!!, pressione <Enter> para continuar."
					 echo
					 echo -e "CUIDADO!!! com as opções que serão solicitadas no decorrer da instalação."
					 read
					 clear
					 
					 #Configurando o arquivo Makefile.PL do OCS Inventory Agent
					 perl Makefile.PL &>> $LOG
					 
					 #Compilando o OCS Inventory Agent
					 make &>> $LOG
					 
					 #Instalando o OCS Inventory Agent
					 make install
					 
					 #MENSAGENS QUE SERÃO SOLICIDATAS NA INSTALAÇÃO DO OCS INVENTORY AGENT:
					 #
					 #01: Please enter 'y' or 'n'?> [y] <-- pressione <Enter>
					 #02: Where do you want to write the configuration file? <-- digite 2 pressione <Enter>
					 #03: Do you want to create the directory /etc/ocsinventory-agent? <-- pressione <Enter>
					 #04: Should the ond linux_agent settings be imported? <-- pressione <Enter>
					 #05: What is the address of your ocs server? digite: http://localhost/ocsinventory, pressione <Enter>
					 #06: Do you need credential for the server? (You probably don't) <-- pressione <Enter>
					 #07: Do you want to apply an administrative tag on this machine? <-- pressione <Enter>
					 #08: tag?> digite: server, pressione <Enter>
					 #09: Do yo want to install the cron task in /etc/cron.d? <-- pressione <Enter>
					 #10: Where do you want the agent to store its files? <-- pressione <Enter>
					 #11: Should I remove the old linux_agent? <-- pressione <Enter>
					 #12: Do you want to activate debug configuration option? <-- pressione <Enter>
					 #13: Do you want to use OCS Inventory NG Unix Unified agent log file? <-- pressione <Enter>
					 #14: Specify log file path you want to use?> digite: /var/log/ocsinventory-agent/activity.log, pressione <Enter>
					 #15: Do you want disable SSL CA verification configuration option (not recommended)? digite: y, pressione <Enter>
					 #16: Do you want to set CA certificate chain file path? digite: n, pressione <Enter>
					 #17: Do you want to use OCS-Inventory software deployment feature? <-- pressione <Enter>
					 #18: Do you want to use OCS-Inventory SNMP scans features? <-- pressione <Enter>
					 #19: Do you want to send an inventory of this machine? <-- pressione <Enter>
					 
					 #Saindo do diretório do OCS Inventory Agent
					 cd ..
					 
					 echo
					 echo -e "Instalação do OCS Inventory Agent feito com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Editando o arquivo do OCS Inventory Agent, pressione <Enter> para continuar"
					 read
					 
					 #Arquivo de configuração do OCS Agent (Cliente)
					 #Fazendo o backup do arquivo de configuração original
					 mv -v /etc/ocsinventory-agent/ocsinventory-agent.cfg /etc/ocsinventory-agent/ocsinventory-agent.cfg.bkp &>> $LOG
					 echo -e "Backup feito com sucesso!!!"
					 sleep 2
					 
					 #Atualizando para o novo arquivo de configuração
					 cp -v conf/ocsinventory-agent.cfg /etc/ocsinventory-agent/ &>> $LOG
					 echo -e "Atualização feita com sucesso!!!"
					 sleep 2
					 
					 #Editando o arquivo de configuração
					 vim /etc/ocsinventory-agent/ocsinventory-agent.cfg
					 
					 #Forçando a atualização do ocsinventory-agent
					 ocsinventory-agent
					 echo -e "Agent tualizado feita com sucesso!!!"
					 sleep 2
					 
					 echo -e "Arquivo editado com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Fim do ocs_agent.sh em: `date`" >> $LOG
					 echo -e "Instalação do OCS Inventory Agent Feito com Sucesso!!!!!"
					 echo
					 # Script para calcular o tempo gasto para a execução do ocs_agent.sh
						 DATAFINAL=`date +%s`
						 SOMA=`expr $DATAFINAL - $DATAINICIAL`
						 RESULTADO=`expr 10800 + $SOMA`
						 TEMPO=`date -d @$RESULTADO +%H:%M:%S`
					 echo -e "Tempo gasto para execução do ocs_agent.sh: $TEMPO"
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
