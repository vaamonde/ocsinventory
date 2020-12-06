#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 14/07/2019
# Data de atualização: 30/11/2020
# Versão: 0.4
# Testado e homologado para a versão do Ubuntu Server 16.04.x LTS x64
# Kernel >= 4.4.x
#
# Download dos Plugins do OCS Inventory: DriverList, UpTime, ListPrinters
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
# Script de download dos Plugins do OCS Inventory no GNU/Linux Ubuntu Server 16.04.x
# opção do comando: &>> (redirecionar a saída padrão)
# opção do comando echo: -e (enable interpretation of backslash escapes), \n (new line)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
clear
echo
#
echo -e "Download dos Plugins do OCS Inventory, aguarde..."
sleep 2
echo
#
echo -e "Download dos arquivos de plugins do OCS Inventory, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
    # opção do comando wget: -O (file)
    wget $DRIVERLIST -O $PATHPLUGINS/drivelist.zip &>> $LOG
    wget $UPTIME -O $PATHPLUGINS/uptime.zip &>> $LOG
	wget $LISTPRINTERS -O $PATHPLUGINS/listprinters.zip &>> $LOG
echo -e "Download dos arquivos de plugins concluído com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Descompactando todos os arquivos Zipados dos Plugins do OCS Inventory, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
    # opção do comando cd: - (return back to directory)
    cd $PATHPLUGINS
    for i in $(ls *.zip);do unzip $i; done &>> $LOG
    cd - &>> $LOG
echo -e "Arquivos descompactados com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Listando o conteúdo do diretório $PATHPLUGINS, aguarde..."
	# opção do comando ls: -l (list), -h (human)
    echo
    ls -lh $PATHPLUGINS
    echo
echo -e "Arquivos listados com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Download dos Plugins do OCS Inventory Feito com Sucesso!!!!!"
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