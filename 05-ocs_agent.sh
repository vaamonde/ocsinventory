#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 06/12/2020
# Versão: 0.14
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Instalação do OCS Inventory Agent, configuração dos arquivos: ocsinventory-agent.cfg (arquivo de configuração do agent
# do ocs inventory), ocsinventory-agent (arquivo de configuração do agendamento do agente do ocs inventory que oferece 
# suporte ao IPDiscovery e SNMP), ocsinventory-cve-cron (arquivo de atualização da base de dados do CVE Search e Reports),
# modules.conf (arquivo de configuração do módulos do agente do ocs inventory), 
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
# Script de instalação do OCS Inventory Agent no GNU/Linux Ubuntu Server 16.04.x
# opção do comando: &>> (redirecionar a saída padrão)
# opção do comando echo: -e (enable interpretation of backslash escapes), \n (new line)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
clear
#
echo
echo -e "Após a instalação do Agente, acessar a url: http://`hostname -I | cut -d ' ' -f1`/ocsreports e verificar o inventário"
echo
#
echo -e "Atualizando as listas do Apt, aguarde..."
	#opção do comando: &>> (redirecionar a saída padrão)
	apt-get update &>> $LOG
echo -e "Listas atualizadas com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Atualizando os pacotes instalados, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt-get: -o (options), -q (quiet), -y (yes)
	apt-get -o Dpkg::Options::="--force-confold" upgrade -q -y --force-yes &>> $LOG
echo -e "Pacotes atualizados com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Download do OCS Inventory Agent do Github, aguarde..."
sleep 5

echo -e "Fazendo o download do OCS Inventory Agent, aguarde..."
	wget https://github.com/OCSInventory-NG/UnixAgent/releases/download/$OCSAGENTVERSION &>> $LOG
echo -e "Download do OCS Inventory Agent feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Descompactando o arquivo OCS Inventory Agent, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando: tar z (gzip), x (extract), v (verbose) e f (file)
	tar -zxvf $OCSAGENTTAR &>> $LOG
echo -e "Arquivo descompactado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Acessando a diretório de instalação do OCS Inventory, aguarde..."
	cd $OCSAGENTINSTALL
echo -e "Diretório de instalação do OCS Inventory Agent acessado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Criando o Diretório de Log do OCS Inventory Agent, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mkdir: -v (verbose)
	mkdir -v /var/log/ocsinventory-agent/ &>> $LOG
echo -e "Diretório de Log do OCS Inventory Agent criado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Criando o Arquivo de Log do OCS Inventory Agent, aguarde..."
	touch /var/log/ocsinventory-agent/activity.log
echo -e "Arquivo de Logo do OCS Inventory Agent criado com sucesso!!!, continuando o script..."
sleep 2
echo
#
echo -e "CUIDADO!!! com as opções que serão solicitadas no decorrer da instalação do OCS Inventory Agent."
echo -e "Veja a documentação das opções de instalação a partir da linha: 124 do arquivo $0"
echo -e "Download do OCS Inventory Agent feito com Sucesso!!!, pressione <Enter> para instalar"
echo
read
sleep 2
clear
#
#Configurando o arquivo Makefile.PL do OCS Inventory Agent
	perl Makefile.PL &>> $LOG
#
#Compilando o OCS Inventory Agent
	make &>> $LOG
#
#Instalando o OCS Inventory Agent
	make install
#
#MENSAGENS QUE SERÃO SOLICITADAS NA INSTALAÇÃO DO OCS INVENTORY AGENT:
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
#11: Do you want to create the? <-- pressione <Enter>
#11: Should I remove the old linux_agent? <-- pressione <Enter>
#12: Do you want to activate debug configuration option? <-- pressione <Enter>
#13: Do you want to use OCS Inventory NG Unix Unified agent log file? <-- pressione <Enter>
#14: Specify log file path you want to use?> digite: /var/log/ocsinventory-agent/activity.log, pressione <Enter>
#15: Do you want disable SSL CA verification configuration option (not recommended)? digite: y, pressione <Enter>
#16: Do you want to set CA certificate chain file path? digite: n, pressione <Enter>
#17: Do you want to use OCS-Inventory software deployment feature? <-- pressione <Enter>
#18: Do you want to use OCS-Inventory SNMP scans features? <-- pressione <Enter>
#19: Do you want to send an inventory of this machine? n, <-- pressione <Enter>
#
#Saindo do diretório do OCS Inventory Agent
cd ..
#
echo
echo -e "Instalação do OCS Inventory Agent feito com sucesso, pressione <Enter> para continuar"
read
sleep 2
clear
#
echo -e "Atualizando os arquivos de configuração do OCS Inventory Agent"
echo
echo -e "Editando o arquivo do OCS Inventory Agent ocsinventory-agent.cfg, pressione <Enter> para continuar"
read
sleep 2
echo
#
echo -e "Fazendo o backup do arquivo de configuração do OCS Inventory Agent, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: -v (verbose)
	mv -v /etc/ocsinventory-agent/ocsinventory-agent.cfg /etc/ocsinventory-agent/ocsinventory-agent.cfg.bkp &>> $LOG
echo -e "Backup do arquivo de configuração do OCS Inventory Agent feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Atualizando do arquivo de configuração do OCS Inventory Agent, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
	cp -v conf/ocsinventory-agent.cfg /etc/ocsinventory-agent/ &>> $LOG
echo -e "Atualização do arquivo de configuração do OCS Inventory Agent feita com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando do arquivo de configuração do OCS Inventory Agent, aguarde..."
sleep 2
	vim /etc/ocsinventory-agent/ocsinventory-agent.cfg
echo -e "Arquivo de configuração do OCS Inventory Agent editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando o arquivo do OCS Inventory Agent modules.conf, pressione <Enter> para continuar"
read
sleep 2
echo
#
echo -e "Fazendo o backup do arquivo de módulos do OCS Inventory Agent, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: -v (verbose)
	mv -v /etc/ocsinventory-agent/modules.conf /etc/ocsinventory-agent/modules.conf.bkp &>> $LOG
echo -e "Backup do arquivo de módulos do OCS Inventory Agent feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Atualizando do arquivo de módulos do OCS Inventory Agent, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
	cp -v conf/modules.conf /etc/ocsinventory-agent/ &>> $LOG
echo -e "Atualização do arquivo de módulos do OCS Inventory Agent feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando do arquivo de módulos do OCS Inventory Agent, aguarde..."
sleep 2
	vim /etc/ocsinventory-agent/modules.conf
echo -e "Arquivo de módulos do OCS Inventory Agent editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Aplicando os PATCHs de correções do OCS Inventory Agent versão 2.6.1, aguarde..."
sleep 2
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
	cp -v patch/Deb.pm /usr/local/share/perl/5.22.1/Ocsinventory/Agent/Backend/OS/Generic/Packaging/ &>> $LOG
    cp -v patch/Snmp.pm /usr/local/share/perl/5.22.1/Ocsinventory/Agent/Modules/ &>> $LOG
echo -e "Aplicação dos PATCHs de correções do OCS Inventory Agent feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando o arquivo do Agendamento do OCS Inventory Agent ocsinventory-agent, pressione <Enter> para continuar"
read
sleep 2
echo
#
echo -e "Atualizando do arquivo de agendamento do OCS Inventory Agent, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
	cp -v conf/ocsinventory-agent-cron /etc/cron.d/ocsinventory-agent &>> $LOG
echo -e "Atualização do arquivo de agendamento do OCS Inventory Agent feita com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando do arquivo de configuração do OCS Inventory Agent, aguarde..."
sleep 2	
	vim /etc/cron.d/ocsinventory-agent
echo -e "Arquivo de configuração do OCS Inventory Agent editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Forçando o inventário do OCS Inventory Agent com as novas configurações, aguarde..."
sleep 2
	# opção do comando: &>> (redirecionar a saída padrão)
	ocsinventory-agent --debug --info &>> $LOG
echo -e "Inventário do OCS Inventory Agent feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando o arquivo do Agendamento do CVE Search Reports ocsinventory-cve-cron, pressione <Enter> para continuar"
read
sleep 2
echo
#
echo -e "Atualizando do arquivo de agendamento do CVE Search Reports, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
	cp -v conf/ocsinventory-cve-cron /etc/cron.d/ocsinventory-cve-cron &>> $LOG
echo -e "Atualização do arquivo de agendamento do OCS Inventory Agent feita com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando do arquivo de configuração do CVE Search Reports, aguarde..."
sleep 2	
	vim /etc/cron.d/ocsinventory-cve-cron
echo -e "Arquivo de configuração do CVE Search Reports editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Forçando a atualização da Base de Dados do CVE Search Reports, aguarde esse processo demora um pouco..."
sleep 2
	# opção do comando: &>> (redirecionar a saída padrão)
    # opção do comando cd: - (retorne to path)
	cd /usr/share/ocsinventory-reports/ocsreports/crontab/ && php cron_cve.php &>> /var/log/ocsinventory-server/cveupdate.log
    cd -
echo -e "Atualização da Base de Dados do CVE Search Reports feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Instalação e Configuração do OCS Inventory Agent Feito com Sucesso!!!!!\n"
echo -e "Após a configuração acessar a URL: http://`hostname -I | cut -d ' ' -f1`/ocsreports para verificar o inventário do servidor\n"
echo -e "Verificar o arquivo de Log do OCS Inventory Agent com o comando: less /var/log/ocsinventory-agent/activity.log"
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