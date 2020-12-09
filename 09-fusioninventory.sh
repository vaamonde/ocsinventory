#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 07/01/2018
# Data de atualização: 08/11/2020
# Versão: 0.4
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Instalação e Configuração do FusionInventory Server e Agent com integração com GLPI Help Desk, atualização dos 
# arquivos de configuração dos serviços.
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
# Script de instalação do FusionInventory no GNU/Linux Ubuntu Server 16.04.x
# opção do comando: &>> (redirecionar a saída padrão)
# opção do comando echo: -e (enable interpretation of backslash escapes), \n (new line)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
clear
echo
#
echo -e "Instalação do sistema de Inventário de Rede FusionInventory integrado com o GLPI Help Desk, aguarde..."
sleep 2
echo
#
echo -e "Fazendo o download do FusionInventory Server, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	wget https://github.com/fusioninventory/fusioninventory-for-glpi/releases/download/$GLPIFISVERSION &>> $LOG
echo -e "Download do FusionInventory Server feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Fazendo o download do FusionInventory Agent, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	wget https://github.com/fusioninventory/fusioninventory-agent/releases/download/$GLPIFIAVERSION &>> $LOG
echo -e "Download do FusionInventory Agent feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Descompactando o arquivo do FusionInventory Server, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando: tar z (gzip), x (extract), v (verbose) e f (file)
	tar -jxvf $GLPIFISTAR &>> $LOG
echo -e "Arquivos do FusionInventory Server descompactados com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Descompactando o arquivo do FusionInventory Agent, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando: tar z (gzip), x (extract), v (verbose) e f (file)
	tar -zxvf $GLPIFIATAR &>> $LOG
echo -e "Arquivos do FusionInventory Agent descompactados com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Movendo o diretório do FusionInventory Server para o diretório de Plugin do GLPI Help Desk, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: v (verbose)
	mv -v $GLPIFISINSTALL /var/www/html/glpi/plugins/ &>> $LOG
echo -e "Diretório do FusionInventory Server movido com sucesso!!!, continuando o script..."
echo
#			
echo -e "Alterando o dono e grupo padrão do diretório do FusionInventory Server, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando chown: -R (recursive), -v (verbose), www-data.www-data (user and group)
	chown -Rv www-data.www-data /var/www/html/glpi/plugins/$GLPIFISINSTALL &>> $LOG
echo -e "Permissões do dono e grupo do FusionInventory Server alteradas com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Compilação e Instalação FusionInventory Agent, aguarde."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando perl: -I (specify @INC/#include directory (several -I's allowed))
	cd $GLPIFIAINSTALL
	perl -I. Makefile.PL &>> $LOG
	make &>> $LOG
	make install &>> $LOG
	cd ..
echo -e "FusionInventory Agent instalado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Backup do arquivo de configuração do FusionInventory Agent, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	cp -v /usr/local/etc/fusioninventory/agent.cfg /usr/local/etc/fusioninventory/agent.cfg.bkp &>> $LOG
echo -e "Backup do arquivo de configuração feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Atualizando o arquivo de configuração do FusionInventory Agent, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	cp conf/agent.cfg /usr/local/etc/fusioninventory/agent.cfg &>> $LOG
echo -e "Arquivo de configuração atualizado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando o arquivo de configuração do FusionInventory Agent, aguarde..."
	sleep 5
	vim /usr/local/etc/fusioninventory/agent.cfg
echo -e "Arquivo de configuração editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Executando o inventário pela primeira vez do FusionInventory, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	fusioninventory-agent --debug &>> $LOG
echo -e "Inventário do FusionInventory feito com sucesso!!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Instalação do FusionInventory Feito com Sucesso!!!!!\n"
echo -e "Após a instalação do FusionInventory acessar a URL do GLPI: http://`hostname -I | cut -d ' ' -f1`/glpi para finalizar a configuração."
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