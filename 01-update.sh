#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 04/01/2018
# Versão: 0.12
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Instalação dos pacotes principais para a primeira etapa, indicado para a distribuição GNU/Linux Ubuntu Server 16.04 LTS x64
#
# Atualização das listas do Apt-Get
# Atualização dos Aplicativos Instalados
# Atualização da Distribuição Ubuntu Server (Kernel)
# Auto-Limpeza do Apt-Get
# Limpando o repositório Local do Apt-Get
# Reiniciando o Servidor
#
# Utilizar o comando: sudo -i para executar o script
#

# Arquivo de configuração de parâmetros
source 00-parametros.sh
#

# Caminho para o Log do script
LOG=$VARLOGPATH/$LOGSCRIPT
#

if [ -e "$VARLOGPATH"]; then
	echo -e "Diretório: $VARLOGPATH já existe, continuando com o script"
	sleep 3
else
	echo -e "Diretório: $VARLOGPATH não existe, criando o diretório"
	mkdir $VARLOGPATH
	echo -e "Diretório criado com sucesso!!!, continuando o script"
	sleep 3
fi


if [ "$USUARIO" == "0" ]
then
	if [ "$UBUNTU" == "16.04" ]
		then
			if [ "$KERNEL" == "4.4" ]
				then
					 clear
					 echo -e "Usuário é `whoami`, continuando a executar o $LOGSCRIPT"
					 echo
					 echo -e "Atualização das Listas do Apt-Get"
					 echo -e "Atualização dos Aplicativos Instalados"
					 echo -e "Atualização da Distribuição Ubuntu Server (Kernel)"
					 echo -e "Remoção de aplicativas desnecessários"
					 echo -e "Limpando o repositório Local do Apt-Get (Cache)"
					 echo
					 echo -e "Após o término o Servidor será reinicializado"
					 echo
					 echo  ============================================================ >> $LOG
					 
					 echo -e "Atualizando as Listas do Apt-Get, aguarde..."
					 
					 #Exportando a variável do Debian Frontend Noninteractive para não solicitar interação com o usuário
					 export DEBIAN_FRONTEND=noninteractive
					 
					 #Atualizando as listas do apt-get
					 apt-get update &>> $LOG
					 
					 echo -e "Listas Atualizadas com Sucesso!!!, continuando com o script"
					 echo
					 echo  ============================================================ >> $LOG

					 echo -e "Atualizando os pacotes instalados, aguarde..."
					 
					 #Fazendo a atualização de todos os pacotes instalados no servidor
					 apt-get -o Dpkg::Options::="--force-confold" upgrade -q -y --force-yes &>> $LOG
					 
					 echo -e "Pacotes atualizados com Sucesso!!!, continuando com o script"
					 echo
					 echo  ============================================================ >> $LOG

					 echo -e "Atualizando a distribuição é o Kernel instalado, aguarde..."
					 echo -e "Kernel atual: `uname -r`"
					 
					 #Fazendo a atualização da distribuição e do Kernel
					 apt-get -o Dpkg::Options::="--force-confold" dist-upgrade -q -y --force-yes &>> $LOG
					 
					 echo -e "Kernel atualizado, versões instaladas."
					 #Listando os pacotes instalados, filtrando por palavras, cortando por colunas.
					 dpkg --list | grep linux-image-4.4 | cut -d' ' -f 3
					 
					 echo -e "Distribuição atualizada com Sucesso!!!, continuando com o script"
					 echo
					 echo ============================================================ >> $LOG

					 echo -e "Remoção dos aplicativos desncessários, aguarde..."
					 
					 #Fazendo a autoremoção de aplicativas instalados
					 apt-get -y autoremove &>> $LOG
					 apt-get -y autoclean &>> $LOG
					 
					 echo -e "Remoção concluida com Sucesso!!!, continuando com o script"
					 echo
					 echo ============================================================ >> $LOG
					 echo >> $LOG
					 
					 echo -e "Limpando o Cache do Apt-Get, aguarde..."
					 
					 #Limpando o diretório de cache do apt-get
					 apt-get clean &>> $LOG
					 
					 echo -e "Cache Limpo com Sucesso!!!"
					 echo
					 echo ============================================================ >> $LOG
					 echo >> $LOG
					 echo -e "Fim do Update.sh em: `date`" >> $LOG

					 echo
					 echo -e "Atualização das Listas do Apt-Get, Atualização dos Aplicativos e Atualização do Kernel Feito com Sucesso!!!!!"
					 echo
					 # Script para calcular o tempo gasto para a execução do script-00.sh
						 DATAFINAL=`date +%s`
						 SOMA=`expr $DATAFINAL - $DATAINICIAL`
						 RESULTADO=`expr 10800 + $SOMA`
						 TEMPO=`date -d @$RESULTADO +%H:%M:%S`
					 echo -e "Tempo gasto para execução do update.sh: $TEMPO"
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
