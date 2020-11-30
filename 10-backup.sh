#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 09/01/2018
# Data de atualização: 10/11/2020
# Versão: 0.4
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Configuração do Agendamento do Backup do OCS Inventory Server, GLPI Help Desk e configuração do IPDiscovery
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
# Script de configuração do Backup do OCS Inventory e do GLPI no GNU/Linux Ubuntu Server 16.04.x
# opção do comando: &>> (redirecionar a saída padrão)
# opção do comando echo: -e (enable interpretation of backslash escapes), \n (new line)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
clear
echo
#
echo -e "Configuração do Agendamento do Backup do OCS Inventory Server e do GLPI Help Desk, aguarde..."
sleep 2
echo
#
echo -e "Copiando o script de Backup do OCS Inventory Server, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: v (verbose)
    cp -v conf/ocsbackup.sh /usr/sbin/ &>> $LOG
echo -e "Script de backup copiado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Copiando o script de Backup do GLPI Help Desk, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: v (verbose)
    cp -v conf/glpibackup.sh /usr/sbin/ &>> $LOG
echo -e "Script de backup copiado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Alterando as permissões dos scripts de backup, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando chmod: +x (add execute)
    chmod +x /usr/sbin/ocsbackup.sh /usr/sbin/glpibackup.sh &>> $LOG
echo -e "Permissões dos scripts alteradas com sucesso!!!, continuando o script..."
sleep 2
echo
#
echo -e "Copiando o arquivo de agendamento de Backup do OCS Inventory Server, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: v (verbose)
    cp -v conf/ocsinventory-backup-cron /etc/cron.d/ &>> $LOG
echo -e "Arquivo de agendamento copiado com sucesso!!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Copiando o arquivo de agendamento de Backup do GLPI, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: v (verbose)
    cp -v conf/glpi-backup-cron /etc/cron.d/ &>> $LOG
echo -e "Arquivo de agendamento copiado com sucesso!!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando o arquivo de Backup do OCS Inventory Server, pressione <Enter> para continuar"
read
sleep 2
    vim /usr/sbin/ocsbackup.sh
echo -e "Arquivo editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Executando o Backup da Base de Dados do OCS Inventory Server, aguarde..."
    # opção do comando ls: -l (list), -h (human)
    echo
    ocsbackup.sh &>> $LOG
    echo
    ls -lh /backup/ocsinventory
    echo
echo -e "Base de Dados do OCS Inventory Server Backupeada com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando o arquivo de Backup do GLPI Help Desk, pressione <Enter> para continuar"
read
sleep 2
    vim /usr/sbin/glpibackup.sh
echo -e "Arquivo editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Executando o Backup da Base de Dados do GLPI Help Desk, aguarde..."
    # opção do comando ls: -l (list), -h (human)
    echo
    glpibackup.sh &>> $LOG
    echo
    ls /backup/glpi
    echo
echo -e "Base de Dados do GLPI Help Desk Backupeada com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Copiando o script de agendamento do IPDiscovery do OCS Inventory, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: v (verbose)
    cp -v conf/ocsinventory-ipdiscover-cron /etc/cron.d/ &>> $LOG
echo -e "Script do agendamento copiado com sucesso!!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando o arquivo do IPDiscovery do OCS Inventory, pressione <Enter> para continuar"     
read
sleep 2
    vim /etc/cron.d/ocsinventory-ipdiscover-cron
echo -e "Arquivo editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Configuração do Agendamento do Backup do OCS Inventory e do GLPI Feito com Sucesso!!!!!"
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
echo -e "Pressione <Enter> para concluir a configuração do servidor: `hostname`"
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Fim do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
read
sleep 2