#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 04/02/2018
# Data de atualização: 10/11/2020
# Versão: 0.8
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Download dos Agents do OCS Inventory para Microsoft Windows, MacOS, Android, Unix/Linux, ferramentas de suporte, arquivos
# de configurações dos agentes, certificado, scripts de automatização da instalação dos agentes no pfSense, UCS Univention e
# GNU/Linux e script de instalação silenciosa do Agent no Microsoft Windows
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
# Script de download dos Agentes do OCS Inventory no GNU/Linux Ubuntu Server 16.04.x
# opção do comando: &>> (redirecionar a saída padrão)
# opção do comando echo: -e (enable interpretation of backslash escapes), \n (new line)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
clear
echo
#
echo -e "Download dos Agentes do OCS Inventory e Ferramentas de Automação do OCS, aguarde..."
sleep 2
echo
#
echo -e "Limpando o conteúdo do diretório: $PATHDOWNLOAD, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando rm: -R (recurse), -f (force), -v (verbose)
    # opção do comando cd: - (return back to directory)
    cd $PATHDOWNLOAD
    rm -Rfv * &>> $LOG
    cd - &>> $LOG
echo -e "Diretório limpo com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Download dos agentes do OCS Inventory e ferramentas de suporte, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando wget: -O (file)
    wget $OCSAGENTWIN10 -O $PATHDOWNLOAD/OCSAgentWin10.zip &>> $LOG
    wget $OCSAGENTWINXP -O $PATHDOWNLOAD/OCSAgentWinXP.zip &>> $LOG
    wget $OCSAGENTMAC -O $PATHDOWNLOAD/OCSAgentMAC.zip &>> $LOG
    wget $OCSAGENTTOOLS -O $PATHDOWNLOAD/OCSAgentTools.zip &>> $LOG
    wget $OCSAGENTDEPLOY -O $PATHDOWNLOAD/OCSAgentDeploy.zip &>> $LOG
    wget $OCSAGENTANDROID -O $PATHDOWNLOAD/OCSAgentAndroid.apk &>> $LOG
    wget $OCSUNIXPACKAGER -O $PATHDOWNLOAD/OCSAgentUnix.zip &>> $LOG
echo -e "Download dos agentes do OCS Inventory e ferramentas de suporte feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Descompactando todos os arquivos Zipados dos Agentes e Ferramentas do OCS Inventory, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
    # opção do comando cd: - (return back to directory)
    cd $PATHDOWNLOAD
    for i in $(ls *.zip);do unzip $i; done &>> $LOG
    cd - &>> $LOG
echo -e "Arquivos descompactados com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Copiando o Certificado do OCS Inventory para o diretório de Download, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
    cp -v ocs.crt $PATHDOWNLOAD/ &>> $LOG
echo -e "Certificado copiado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Copiando os Arquivos de Configurações do OCS Inventory Agent, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: -v (verbose)
    cp -v /etc/ocsinventory-agent/ocsinventory-agent.cfg $PATHDOWNLOAD/ &>> $LOG
    cp -v conf/ocsinventory.ini $PATHDOWNLOAD/ &>> $LOG
    cp -v conf/ocsinstall.bat $PATHDOWNLOAD/ &>> $LOG
    cp -v conf/linuxinstall.sh $PATHDOWNLOAD/ &>> $LOG
    cp -v conf/ucsinstall.sh $PATHDOWNLOAD/ &>> $LOG
    cp -v conf/pfsenseinstall.sh $PATHDOWNLOAD/ &>> $LOG
echo -e "Arquivos de Configurações copiados com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Listando o conteúdo do diretório $PATHDOWNLOAD, aguarde..."
	# opção do comando ls: -l (list), -h (human)
    echo
    ls -lh $PATHDOWNLOAD
    echo
echo -e "Arquivos listados com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Download dos Agentes do OCS Inventory Feito com Sucesso!!!!!"
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