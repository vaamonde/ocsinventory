#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 11/06/2018
# Versão: 0.14
# Testado e homologado para a versão do Ubuntu Server 16.04.x LTS x64
# Kernel >= 4.x.x
#
# Instalação dos pacotes principais para a primeira etapa, indicado para a distribuição GNU/Linux Ubuntu Server 16.04.x LTS x64
#
# Atualização das listas do Apt-Get
# Atualização dos Aplicativos Instalados
# Atualização da Distribuição Ubuntu Server (Kernel)
# Auto-Limpeza do Apt-Get
# Limpeza do repositório Local do Apt-Get
# Reinicialização do Servidor
#
# Utilizar o comando: sudo -i para executar o script
#

# Arquivo de configuração dos parâmetros
source 00-parametros.sh
#

# Caminho do arquivo para o Log do script
LOG=$VARLOGPATH/$LOGSCRIPT
#

# Verificação da criação do Diretório de Log, usado somente no script de atualização
if [ -e "$VARLOGPATH" ]; then
	echo -e "Diretório: $VARLOGPATH já existe, continuando com o script"
	sleep 3
else
	echo -e "Diretório: $VARLOGPATH não existe, criando o diretório..."
	mkdir $VARLOGPATH
	echo -e "Diretório criado com sucesso!!!, continuando com o script"
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
					 echo -e "Remoção dos aplicativos desnecessários"
					 echo -e "Limpando o repositório Local do Apt-Get (Cache)"
					 echo
					 echo -e "Após o término o Servidor será reinicializado"
					 echo
					 echo  ============================================================ >> $LOG
					 
					 echo -e "Atualizando as listas do Apt-Get, aguarde..."
					 
					 #Exportando a variável do Debian Frontend Noninteractive para não solicitar interação com o usuário
					 export DEBIAN_FRONTEND=noninteractive
					 
					 #Atualizando as listas do apt-get
					 apt-get update &>> $LOG
					 
					 echo -e "Listas atualizadas com sucesso!!!, continuando com o script"
					 echo
					 echo  ============================================================ >> $LOG

					 echo -e "Atualizando os pacotes instalados, aguarde..."
					 
					 #Fazendo a atualização de todos os pacotes instalados no servidor
					 apt-get -o Dpkg::Options::="--force-confold" upgrade -q -y --force-yes &>> $LOG
					 
					 echo -e "Pacotes atualizados com sucesso!!!, continuando com o script"
					 echo
					 echo  ============================================================ >> $LOG

					 echo -e "Atualizando a distribuição é o Kernel, aguarde..."
					 echo -e "Kernel atual: `uname -r`"
					 
					 #Fazendo a atualização da distribuição e do Kernel
					 apt-get -o Dpkg::Options::="--force-confold" dist-upgrade -q -y --force-yes &>> $LOG
					 
					 echo
					 echo -e "Distribuição e Kernel atualizados, versões instaladas."
					 #Listando os pacotes instalados, filtrando por palavras, cortando por colunas.
					 dpkg --list | grep linux-image-4.4 | cut -d' ' -f 3
					 
					 echo -e "Distribuição e Kernel atualizadas com sucesso!!!, continuando com o script"
					 echo
					 echo ============================================================ >> $LOG

					 echo -e "Remoção dos aplicativos desnecessários, aguarde..."
					 
					 #Fazendo a autoremoção de aplicativas instalados
					 apt-get -y autoremove &>> $LOG
					 apt-get -y autoclean &>> $LOG
					 
					 echo -e "Remoção dos aplicativos concluída com sucesso!!!, continuando com o script"
					 echo
					 echo ============================================================ >> $LOG
					 echo >> $LOG
					 
					 echo -e "Limpando o cache do Apt-Get, aguarde..."
					 
					 #Limpando o diretório de cache do apt-get
					 apt-get clean &>> $LOG
					 
					 echo -e "Cache limpo com sucesso!!!, continuando com o script"
					 echo
					 echo ============================================================ >> $LOG
					 echo >> $LOG
					 echo -e "Fim do $LOGSCRIPT em: `date`" >> $LOG

					 echo
					 echo -e "Atualização das Listas, Atualização dos Aplicativos e Atualização do Kernel feito com sucesso!!!!!"
					 echo
					 # Script para calcular o tempo gasto para a execução
						 DATAFINAL=`date +%s`
						 SOMA=`expr $DATAFINAL - $DATAINICIAL`
						 RESULTADO=`expr 10800 + $SOMA`
						 TEMPO=`date -d @$RESULTADO +%H:%M:%S`
					 echo -e "Tempo gasto para execução do 01-update.sh: $TEMPO"
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
