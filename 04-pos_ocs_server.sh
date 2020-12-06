#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 18/06/2017
# Data de atualização: 30/11/2020
# Versão: 0.6
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Pós-Instalação do OCS Inventory Server e OCS Inventory Reports, configuração dos arquivos: z-ocsinventory-server.conf 
# (Arquivo de configuração do Servidor do OCS Inventory que vai receber as atualização do Clientes), zz-ocsinventory-restapi.conf 
# (Novo arquivo de configuração do Servidor do OCS Inventory que vai receber as atualização do Clientes), ocsinventory-reports.conf
# (Arquivo de configuração do Servidor do OCS Inventory Reports responsável pelos relatórios e distribuição dos softwares), 
# dbconfig.inc.php (Arquivo de configuração para conexão com o Banco de Dados do MySQL - Configuração das variáveis de usuário
# e senha do banco de dados: database name (ocsweb) e user (ocs)), 
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
# Script de instalação do OCS Inventory Server e Reports no GNU/Linux Ubuntu Server 16.04.x
# opção do comando: &>> (redirecionar a saída padrão)
# opção do comando echo: -e (enable interpretation of backslash escapes), \n (new line)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
clear
#
echo -e "Alterando a senha e permissões do usuário ocs do MySQL, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mysql: -u (user), -p (password), -e (execute)
	mysql -u $USER -p$PASSWORD -e "$SETOCSPWD" mysql &>> $LOG
	mysql -u $USER -p$PASSWORD -e "$FLUSH" mysql &>> $LOG
echo -e "Senha e permissões do usuário ocs alteradas com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Removendo o arquivo install.php do OCS Reports, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: -v (verbose)
	mv -v /usr/share/ocsinventory-reports/ocsreports/install.php /usr/share/ocsinventory-reports/ocsreports/install.php.bkp &>> $LOG
echo -e "Arquivo removido com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Atualizando os arquivos de configuração do OCS Inventory Server"
echo
echo -e "Editando o arquivo do OCS Inventory Server z-ocsinventory-server.conf, pressione <Enter> para continuar"
read
sleep 2
#
echo -e "Fazendo o backup do arquivo de configuração do OCS Inventory Server, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: -v (verbose)
	mv -v /etc/apache2/conf-available/z-ocsinventory-server.conf /etc/apache2/conf-available/z-ocsinventory-server.conf.bkp &>> $LOG
echo -e "Backup do arquivo de configuração do OCS Inventory Server feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Atualizando do arquivo de configuração do OCS Inventory Server, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
	cp -v conf/z-ocsinventory-server.conf /etc/apache2/conf-available/ &>> $LOG
echo -e "Atualização do arquivo de configuração do OCS Inventory Server feita com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando do arquivo de configuração do OCS Inventory Server, aguarde..."
	sleep 2
	vim /etc/apache2/conf-available/z-ocsinventory-server.conf
echo -e "Arquivo de configuração do OCS Inventory Server editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando o arquivo do OCS Inventory RestApti zz-ocsinventory-restapi.conf, pressione <Enter> para continuar"
read
sleep 2
#
echo -e "Fazendo o backup do arquivo de configuração do OCS Inventory RestApi, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: -v (verbose)
	mv -v /etc/apache2/conf-available/zz-ocsinventory-restapi.conf /etc/apache2/conf-available/zz-ocsinventory-restapi.conf.bkp &>> $LOG
echo -e "Backup do arquivo de configuração do OCS Inventory RestApi feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Atualizando do arquivo de configuração do OCS Inventory RestApi, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
	cp -v conf/zz-ocsinventory-restapi.conf /etc/apache2/conf-available/ &>> $LOG
echo -e "Atualização do arquivo de configuração do OCS Inventory RestApi feita com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando do arquivo de configuração do OCS Inventory RestApi, aguarde..."
	sleep 2
	vim /etc/apache2/conf-available/zz-ocsinventory-restapi.conf
echo -e "Arquivo de configuração do OCS Inventory RestApi editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando o arquivo do OCS Inventory Reports ocsinventory-reports.conf, pressione <Enter> para continuar"
read
sleep 2
#
echo -e "Fazendo o backup do arquivo de configuração do OCS Inventory Reports, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: -v (verbose)
	mv -v /etc/apache2/conf-available/ocsinventory-reports.conf /etc/apache2/conf-available/ocsinventory-reports.conf.bkp &>> $LOG
echo -e "Backup do arquivo de configuração do OCS Inventory Reports feito com sucesso!!!, continuando com o script.."
sleep 2
echo
#
echo -e "Atualizando do arquivo de configuração do OCS Inventory Reports, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
	cp -v conf/ocsinventory-reports.conf /etc/apache2/conf-available/ &>> $LOG
echo -e "Atualização do arquivo de configuração do OCS Inventory Reports feita com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando do arquivo de configuração do OCS Inventory Reports, aguarde..."
	sleep 2
	vim /etc/apache2/conf-available/ocsinventory-reports.conf
echo -e "Arquivo de configuração do OCS Inventory Reports editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando o arquivo do OCS Inventory Server DBConfig dbconfig.inc.php, pressione <Enter> para continuar"
read
sleep 2
#
echo -e "Fazendo o backup do arquivo de configuração do OCS Inventory Reports DBConfig, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: -v (verbose)
	mv -v /usr/share/ocsinventory-reports/ocsreports/dbconfig.inc.php /usr/share/ocsinventory-reports/ocsreports/dbconfig.inc.php.bkp &>> $LOG
echo -e "Backup do arquivo de configuração do OCS Inventory Reports DBConfig feito com sucesso!!!, continuando com o script.."
sleep 2
echo
#
echo -e "Atualizando do arquivo de configuração do OCS Inventory Reports DBConfig, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
	cp -v conf/dbconfig.inc.php /usr/share/ocsinventory-reports/ocsreports/ &>> $LOG
echo -e "Atualização do arquivo de configuração do OCS Inventory Reports DBConfig feita com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando do arquivo de configuração do OCS Inventory Reports DBConfig, aguarde..."
	sleep 2
	vim /usr/share/ocsinventory-reports/ocsreports/dbconfig.inc.php
echo -e "Arquivo de configuração do OCS Inventory Reports DBConfig editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando o arquivo do OCS Inventory Server Logrotate ocsinventory-server, pressione <Enter> para continuar"
read
sleep 2
#
echo -e "Fazendo o backup do arquivo de configuração do OCS Inventory Reports Logrotate, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: -v (verbose)
	mv -v /etc/logrotate.d/ocsinventory-server /etc/logrotate.d/ocsinventory-server.bkp &>> $LOG
echo -e "Backup do arquivo de configuração do OCS Inventory Reports Logrotate feito com sucesso!!!, continuando com o script.."
sleep 2
echo
#
echo -e "Atualizando do arquivo de configuração do OCS Inventory Reports Logrotate, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
	cp -v conf/ocsinventory-server /etc/logrotate.d/ocsinventory-server &>> $LOG
echo -e "Atualização do arquivo de configuração do OCS Inventory Reports Logrotate feita com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando do arquivo de configuração do OCS Inventory Reports Logrotate, aguarde..."
	sleep 2
	vim /etc/logrotate.d/ocsinventory-server
echo -e "Arquivo de configuração do OCS Inventory Reports Logrotate editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Reinicializando o serviço do Apache2, aguarde..."
	sudo service apache2 restart
echo -e "Serviço do Apache2 reinicializado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando o arquivo do SNMP MIBs snmp.conf, pressione <Enter> para continuar"
read
sleep 2
#
echo -e "Fazendo o backup do arquivo de configuração do SNMP MIBs, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: -v (verbose)
	mv -v /etc/snmp/snmp.conf  /etc/snmp/snmp.conf.bkp &>> $LOG
echo -e "Backup do arquivo de configuração do SNMP MIBs feito com sucesso!!!, continuando com o script.."
sleep 2
echo
#
echo -e "Atualizando do arquivo de configuração do SNMP MIBs, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
	cp -v conf/snmp.conf /etc/snmp/snmp.conf &>> $LOG
echo -e "Atualização do arquivo de configuração do OCS Inventory Reports DBConfig feita com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando do arquivo de configuração do SNMP MIBs, aguarde..."
	sleep 2
	vim /etc/snmp/snmp.conf
echo -e "Arquivo de configuração do OCS Inventory Reports DBConfig editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
#
echo -e "Criando os Links Simbólicos das MIBs do SNMP da IANA e IETF, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando ln: -s (symbolic)
	ln -sv /var/lib/mibs/iana/ /usr/share/snmp/mibs/iana &>> $LOG
	ln -sv /var/lib/mibs/ietf/ /usr/share/snmp/mibs/ietf &>> $LOG
echo -e "Links simbólicos do SNMP MIBs criados com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Atualizando as MIBs genéricas do SNMP, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	download-mibs &>> $LOG
echo -e "MIBs genéricas do SNMP atualizadas com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Atualizando as MIBs customizadas do SNMP para o OCS Inventory Reports, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -R (recursive), -v (verbose)
	# opção do comando chmod: -R (recursive), -v (verbose), 664 (dono=rw-,group=rw-,other=r--)
	# opção do comando chown: -R (recursive), -v (verbose), www-data.www-data (dono=ww-data,group=ww-data)
	cp -Rv mbis/ $MIBS &>> $LOG
	chmod -Rv 664 $MIBS/mbis/ &>> $LOG
	chmod 775 $MIBS/mbis/ &>> $LOG
	chown -Rv www-data.www-data $MIBS/mbis/ &>> $LOG
	cp -v mbis/* $SNMP &>> $LOG
echo -e "MIBs customizadas do SNMP atualizadas com sucesso!!!, continuando com o script..."
sleep 2
echo
#
#echo -e "Reinicializando o serviço do SNMP, aguarde..."
#	sudo service snmp restart
#echo -e "Serviço do SNMP reinicializado com sucesso!!!, continuando com o script..."
#sleep 2
#echo
#
echo -e "Atualizando as MIBs genéricas do SNMP, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	download-mibs &>> $LOG
echo -e "MIBs genéricas do SNMP atualizadas com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Finalização da Pós-Instalação do OCS Inventory Server Feito com Sucesso!!!!!"
echo -e "Após a configuração acessar a URL: http://`hostname -I | cut -d ' ' -f1`/ocsreports para verificar as mudanças do OCS Inventory"
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