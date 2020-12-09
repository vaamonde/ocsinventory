#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 30/11/2020
# Versão: 0.16
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Instalação e Configuração do GLPI Help Desk, plugin do OCS Inventory, alteração das permissões do diretório do GLPI
# e instalação das dependência do GLPI
#
#MENSAGENS QUE SERÃO SOLICITADAS NA INSTALAÇÃO DO GLPI HELP DESK VIA NAVEGADOR:
#01. Select your language.: Português do Brasil <OK>;
#02. Licença: Eu li e ACEITO os termos de licença acima.: <Continuar>;
#03. Escolha "Instalar" para uma nova instalação do GLPI.: <Instalar>;
#04. Etapa 0: <Continuar>;
#05. Etapa 1: Servidor: localhost, Usuário: root, Senha: 123456 <Continuar>;
#06. Etapa 2: Criar um novo banco de dados ou utilizar um existente: glpi <Continuar>;
#07. Etapa 3: <Continuar>;
#08. Etapa 4: <Usar o GLPI>.
#
#USUÁRIOS QUE SERÃO UTILIZADOS NO GLPI HELP DESK
#glpi/glpi para a conta do usuário administrador
#tech/tech para a conta do usuário técnico
#normal/normal para a conta do usuário normal
#post-only/postonly para a conta do usuário postonly
#
#APÓS A INSTALAÇÃO VIA NAVEGADOR, REMOVER A PASTA glpi/install
#cd /var/www/html/glpi/
#rm -Rf install
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
echo -e "Após a instalação, acessar a url: http://`hostname -I | cut -d ' ' -f1`/glpi e finalizar a instalação"
echo -e "Usuário padrão após a instalação do GLPI Help Desk: glpi | Senha padrão: glpi"
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
echo -e "Download do GLPI Help Desk do Github, aguarde..."
sleep 5
echo
#
echo -e "Fazendo o download do GLPI Help Desk, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	wget https://github.com/glpi-project/glpi/releases/download/$GLPIVERSION &>> $LOG
echo -e "Download do GLPI Help Desk feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Descompactando o arquivo GLPI Help Desk, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando: tar z (gzip), x (extract), v (verbose) e f (file)
	tar -zxvf $GLPITAR &>> $LOG
echo -e "Arquivo do GLPI Help Desk descompactado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Movendo o diretório GLPI Help Desk, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: v (verbose)	
	mv -v $GLPIINSTALL /var/www/html/ &>> $LOG
echo -e "Diretório do GLPI Help Desk movido com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Fazendo o download do Plugin do OCS Inventory do GLPI Help Desk aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	wget https://github.com/pluginsGLPI/ocsinventoryng/releases/download/$GLPIOCSVERSION &>> $LOG
echo -e "Download do Plugin do OCS Inventory feito com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Descompactando o arquivo do Plugin do OCS Inventory do GLPI Help Desk, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando: tar z (gzip), x (extract), v (verbose) e f (file)
	tar -zxvf $GLPIOCSTAR &>> $LOG
echo -e "Arquivo do Plugin do OCS Inventory descompactado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Movendo o diretório do Plugin do OCS Inventory do GLPI Help Desk, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: v (verbose)
	mv -v $GLPIOCSINSTALL /var/www/html/glpi/plugins/ &>> $LOG
echo -e "Diretório do Plugin do OCS Inventory movido com sucesso!!!, continuando com o script..."
sleep 2
echo
#			
echo -e "Alterando o dono e grupo padrão do diretório do GLPI Help Desk, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando chown: -R (recursive), -v (verbose), www-data.www-data (user and group)
	chown -Rv www-data.www-data /var/www/html/glpi/ &>> $LOG
echo -e "Alteração do dono e grupo do OCS Inventory Reports alteradas com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Instalação das Dependências do APCU do GLPI Help Desl via Pecl, aguarde..."
		#Enable internal debbugging in APcu [no] <-- pressione <Enter>
	echo -e "no" | pecl install apcu_bc-beta &>> $LOG
echo -e "APCU instalado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Habilitando o módulo APCU no PHP"
	# opção do comando: &>> (redirecionar a saída padrão)
	phpenmod apcu &>> $LOG
echo -e "Modulo APCU habilitado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Copiando o arquivo de configuração do GLPI para o Apache2, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: v (verbose)
	cp -v conf/glpi.conf /etc/apache2/conf-available/ &>> $LOG
echo -e "Arquivo do GLPI atualizado com sucesso!!!, continuado com o script..."
sleep 2
echo
#
echo -e "Habilitando o arquivo de configuração do GLPI Help Desk no Apache2, aguarde..."
	a2enconf glpi &>> $LOG
echo -e "Arquivo de configuração do GLPI Help Desk habilitado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Habilitando o arquivo de agendamento de Atualizações do GLPI Help Desk, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: v (verbose)
	cp -v conf/glpi-cron /etc/cron.d/ &>> $LOG
echo -e "Agendamento do GLPI Help Desk habilitado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Reinicializando o Serviço do Apache2, aguarde..."
	sudo service apache2 restart
echo -e "Serviço do Apache 2 reinicializado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Instalação do GLPI Help Desk e Plugin do OCS Inventory feito com sucesso!!!, continuando com o script..."
sleep 5
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
echo -e "Instalação do GLPI Help Desk e Plugin do FusionInventory Feito com Sucesso!!!!!\n"
echo -e "Após a instalação do GLPI Help Desk acessar a URL: http://`hostname -I | cut -d ' ' -f1`/glpi para finalizar a configuração."
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