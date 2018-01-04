#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 04/01/2017
# Versão: 0.12
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Instalação do GLPI Help Desk
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
					 echo  ============================================================ >> $LOG
					 
					 echo -e "Download do GLPI Help Desk do Github, pressione <Enter> para continuar"
					 echo -e "Após a instalação, acessar a url: http://`hostname`/glpi e finalizar a instalação"
					 read
					 sleep 2
					 
					 #Fazendo o download do código fonte do GLPI Help Desk
					 wget https://github.com/glpi-project/glpi/releases/download/$GLPIVERSION &>> $LOG
					 echo -e "Download feito com sucesso!!!"
					 sleep 2
					 
					 #Descompactando o arquivos do GLPI Help Desk
					 tar -zxvf $GLPITAR &>> $LOG
					 echo -e "Download descompactado com sucesso!!!"
					 sleep 2
					 
					 #Movendo a pasta do GLPI Help Desk para /var/www/html/
					 mv -v $GLPIINSTALL /var/www/html/ &>> $LOG
					 echo -e "Diretório movido com sucesso!!!"
					 sleep 2
					 
					 #Fazendo o download do código fonte do Plugin do OCS Inventory Server
					 wget https://github.com/pluginsGLPI/ocsinventoryng/releases/download/$GLPIOCSVERSION &>> $LOG
					 echo -e "Download do Plugin do OCS Inventory feito com sucesso!!!"
					 sleep 2
					 
					 #Descompactando o arquivo do Plugin do OCS Inventory Server para o GLPI
					 tar -zxvf $GLPIOCSTAR &>> $LOG
					 echo -e "Download descompactado com sucesso!!!"
					 sleep 2
					 
					 #Movendo a pasta do Plugin do OCS Inventory para o GLPI
					 mv -v $GLPIOCSINSTALL /var/www/html/glpi/plugins/ &>> $LOG
					 echo -e "Diretório movido com sucesso!!!"
					 sleep 2
					 					 
					 #Alterando as permissões de Dono e Grupo da pasta do GLPI Help Desk
					 chown -Rf www-data.www-data /var/www/html/glpi/ &>> $LOG
					 echo -e "Permissões aplicada com sucesso!!!"
					 sleep 2
					 
					 #MENSAGENS QUE SERÃO SOLICIDATAS NA INSTALAÇÃO DO GLPI HELP DESK VIA NAVEGADOR:
					 #01. Selecione a linguage: Português do Brasil <OK>;
					 #02. Licença: Eu li e ACEITO os termons de licença acima: <Continuar>;
					 #03. Início da Instalação: <Instalar>;
					 #04. Etapa 0: <Continuar>;
					 #05. Etapa 1: Servidor: localhost, Usuário: root, Senha: 123456 <Continuar>;
					 #06. Etapa 2: Criar um novo banco de dados ou utilizar um existente: glpi <Continuar>;
					 #07. Etapa 3: <Continuar>;
					 #08. Etapa 4: <Usar o GLPI>.
					 
					 #USUÁRIOS QUE SERÃO UTILIZADOS NO GLPI HELP DESK
					 #glpi/glpi para a conta do usuário administrador
    				 	 #tech/tech para a conta do usuário técnico
    				 	 #normal/normal para a conta do usuário normal
    				 	 #post-only/postonly para a conta do usuário postonly
					 
					 #APÓS A INSTALAÇÃO VIA NAVEGADOR, REMOVER A PASTA glpi/install
					 #cd /var/www/html/glpi/
					 #rm -Rf install
					 
					 echo -e "Download do GLPI feito com sucesso, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Instalação das Dependências do APCU do GLPI via Pecl, pressione <Enter> para continuar"
					 read
					 
					 #Instalação do apcu-bc
					 #Mensagem:  ? [no] <-- pressione <Enter>
					 pecl install apcu_bc-beta
					 echo -e "APCU instalado com sucesso!!!, continuando o script"
					 
					 echo
					 
					 echo -e "Habilitando o módulo no PHP"
					 #Habilitando o módulo do APCU no PHP
					 phpenmod apcu
					 echo -e "Modulo habilitado com sucesso!!!, continuando o script"
					 
					 echo
					 
					 echo -e "Copiando o arquivo de configuração do GLPI para o Apache2"
					 cp -v conf/glpi.conf /etc/apache2/conf-available/ &>> $LOG
					 echo -e "Arquivo atualizado com sucesso!!!, continuado o script"
					 
					 echo
					 
					 echo -e "Habilitando o Conf do GLPI no Apache2"
					 a2enconf glpi
					 echo -e "Conf habilitado com sucesso!!!, continuando o script"
					 
					 echo
					 
					 echo -e "Instalação concluída com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Removendo aplicativos desnecessários"
					 
					 #Limpando o diretório de cache do apt-get
					 apt-get autoremove &>> $LOG
					 apt-get autoclean &>> $LOG
					 
					 echo -e "Aplicativos removidos com Sucesso!!!"
					 echo
					 echo ============================================================ >> $LOG

					 echo -e "Limpando o Cache do Apt-Get"
					 
					 #Limpando o diretório de cache do apt-get
					 apt-get clean &>> $LOG
					 
					 echo -e "Cache Limpo com Sucesso!!!"
					 echo
					 echo ============================================================ >> $LOG

					 echo -e "Fim do $LOGSCRIPT em: `date`" >> $LOG
					 echo -e "Instalação do GLPI Help Desk feito com Sucesso!!!!!"
					 echo -e "Após a reinicialização, acessar a url: http://ENDEREÇO_IP_DO_SERVIDOR/glpi e finalizar a instalação"
					 echo
					 # Script para calcular o tempo gasto para a execução do glpi.sh
						 DATAFINAL=`date +%s`
						 SOMA=`expr $DATAFINAL - $DATAINICIAL`
						 RESULTADO=`expr 10800 + $SOMA`
						 TEMPO=`date -d @$RESULTADO +%H:%M:%S`
					 echo -e "Tempo gasto para execução do glpi.sh: $TEMPO"
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
