#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 09/01/2018
# Data de atualização: 29/01/2018
# Versão: 0.2
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Configuração do Agendamento do Backup do OCS Inventory e GLPI
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
					 echo  ============================================================ &>> $LOG
					 
					 echo -e "Configuração do Agendamento do Backup do OCS Inventory e do GLPI"
					 echo -e "Pressione <Enter> para instalar"
					 read
					 sleep 2
					 echo
					 
					 echo -e "Copiando o script de Backup do OCS Inventory Server, aguarde..."
					 cp -v conf/ocsbackup.sh /usr/sbin/ &>> $LOG
					 echo -e "Arquivo copiado com sucesso!!!, continuando o script"
					 
					 echo -e "Copiando o script de Backup do GLPI, aguarde..."
					 cp -v conf/glpibackup.sh /usr/sbin/ &>> $LOG
					 echo -e "Arquivo copiado com sucesso!!!, continuando o script"
					 
					 echo -e "Alterando as permissões dos arquivos, aguarde..."
					 chmod +x /usr/sbin/ocsbackup.sh /usr/sbin/glpibackup.sh &>> $LOG
					 echo -e "Permissões alteradas com sucesso!!!, continuando o script"
					 
					 echo -e "Copiando o agendamento de Backup do OCS Inventory Server, aguarde..."
					 cp -v conf/ocsinventory-backup-cron /etc/cron.d/ &>> $LOG
					 echo -e "Arquivo de agendamento copiado com sucesso!!!!, continuando o script"
					 
					 echo -e "Copiando o agendamento de Backup do GLPI, aguarde..."
					 cp -v conf/glpi-backup-cron /etc/cron.d/ &>> $LOG
					 echo -e "Arquivo de agendamento copiado com sucesso!!!!, continuando o script"
					 echo
					 
					 echo -e "Arquivos copiados com sucesso!!!, pressione <Enter> para continuar com o script"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Editando o arquivo de Backup do OCS Inventory Server, pressione <Enter> para continuar"
					 read
					 sleep 2
					 vim /usr/sbin/ocsbackup.sh
					 echo -e "Arquivo editado com sucesso!!!, continuando o script"
					 echo
					 
					 echo -e "Executando o Backup da Base de Dados do OCS Inventory, aguarde..."
					 ocsbackup.sh
					 ls -lh /backup/ocsinventory
					 echo -e "Base de Dados do OCS Inventory Backupeada com sucesso!!!, continuando o script"
					 read
					 sleep 3
					 clear
					 
					 echo -e "Editando o arquivo de Backup do GLPI, pressione <Enter> para continuar"
					 read
					 sleep 2
					 vim /usr/sbin/glpibackup.sh
					 echo -e "Arquivo editado com sucesso!!!, continuando o script"
					 echo
					 
					 echo -e "Executando o Backup da Base de Dados do GLPI, aguarde..."
					 glpibackup.sh
					 ls /backup/glpi
					 echo -e "Base de Dados do GLPI Backupeada com sucesso!!!, continuando o script"
					 read
					 sleep 3
					 clear
					 
           				 echo  ============================================================ >> $LOG
                     
					 echo -e "Fim do $LOGSCRIPT em: `date`" &>> $LOG
					 echo -e "Finalização do Agendamento feito com Sucesso!!!!!"
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
