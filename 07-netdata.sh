#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 30/11/2020
# Versão: 0.15
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Instalação e configuração do sistema de monitoramento em Tempo Real do Netdata, instalação das dependências, configuração
# do monitoramento do MySQL
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
# Script de instalação do GLPI Help Desk e Plugin do OCS Inventory no GNU/Linux Ubuntu Server 16.04.x
# opção do comando: &>> (redirecionar a saída padrão)
# opção do comando echo: -e (enable interpretation of backslash escapes), \n (new line)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
clear
echo
#
echo -e "Após a instalação do Netdata acessar a url: http://`hostname -I | cut -d ' ' -f1`:19999/ para verificar se o serviço está OK"
echo
#
echo -e "Atualizando as listas do Apt, aguarde..."
	#opção do comando: &>> (redirecionar a saída padrão)
	apt-get update &>> $LOG
echo -e "Listas atualizadas com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Atualizando os pacotes instalados, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt-get: -o (options), -q (quiet), -y (yes)
	apt-get -o Dpkg::Options::="--force-confold" upgrade -q -y --force-yes &>> $LOG
echo -e "Pacotes atualizados com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Instalação das dependências do Netdata, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt-get: -o (options), -q (quiet), -y (yes)
	apt-get -y install uuid-dev libuuid1 zlib1g zlib1g-dev gcc make autoconf2.64 automake pkg-config cmake libuv1-dev &>> $LOG
echo -e "Instalação das dependências do Netdata feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Removendo o arquivo install do GLPI Help Desk da etapa 06-glpi.sh, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: v (verbose)
	mv -v /var/www/html/glpi/install /var/www/html/glpi/install.bkp &>> $LOG
echo -e "Arquivo de install do GLPI Help Desk removido com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Clonando o diretório do Netdata do Github, aguarde..."
	git clone https://github.com/firehol/$NETDATAVERSION --depth=1 &>> $LOG
echo -e "Clonagem do diretório do Netdata feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Acessando o diretório do Netdata e fazendo a sua compilação, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando echo |: faz a função de Enter no Script
	cd $NETDATAINSTALL
	echo | ./netdata-installer.sh &>> $LOG
	cd ..
	echo
echo -e "Instalação do Netdata feita com sucesso!!!, continuando com o script"
sleep 5
echo
#
echo -e "Atualizando o arquivo de configuração do MySQL para acessar as informações via Netdata, pressione <Enter> para continuar"
read
sleep 2
echo
#
echo -e "Fazendo o backup das configurações do arquivo do MySQL do Netdata, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: v (verbose)
	mv -v /usr/lib/netdata/conf.d/python.d/mysql.conf /usr/lib/netdata/conf.d/python.d/mysql.conf.bkp &>> $LOG
echo -e "Backup das configurações do MySQL feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Atualizando o arquivo de configuração do MySQL do Netdata, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: v (verbose)
	cp -v conf/mysql.conf /usr/lib/netdata/conf.d/python.d/ &>> $LOG
echo -e "Arquivo de configuração do MySQL atualizado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Alterando as permissões do arquivo Mysql.conf do Netdata, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando chown: -R (recursive), -v (verbose), netdata.netdata (user and group)
	# opção do comando chmod: -R (recursive), -v (verbose), 660 (User=RW-, Group=RW-, Other=---)
	chown -v netdata.netdata /usr/lib/netdata/conf.d/python.d/mysql.conf &>> $LOG
	chmod -v 660 /usr/lib/netdata/conf.d/python.d/mysql.conf &>> $LOG
echo -e "Permissões do arquivo de configuração do MySQL atualizado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando o arquivo de configuração do MySQL do Netdata, aguarde..."
sleep 2
	# opção do comando vim: +163 (open line number)
	# adicionar o usuário: root e senha: 123456 do MySQL
	vim /usr/lib/netdata/conf.d/python.d/mysql.conf +163
echo -e "Arquivo do MySQL editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Reinicializando o Serviço do Netdata, aguarde..."
	sudo service netdata restart
echo -e "Serviço do Netdata reinicializado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Remoção dos aplicativos desnecessários, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt-get: -y (yes)
	apt-get -y autoremove &>> $LOG
	apt-get -y autoclean &>> $LOG
echo -e "Remoção dos aplicativos desnecessários concluída com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Limpando o cache do Apt-Get, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt-get: -y (yes)
	apt-get clean &>> $LOG
echo -e "Cache limpo com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Verificando a porta de conexão do Netdata, aguarde..."
	# opção do comando netstat: -a (all), -n (numeric)
	netstat -an | grep 19999
echo -e "Porta de conexão verificada com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Instalação do Netdata Feito com Sucesso!!!!!"
echo -e "Após a instalação do Netdata acessar a URL: http://`hostname -I | cut -d ' ' -f1`:19999/ para finalizar a configuração."
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