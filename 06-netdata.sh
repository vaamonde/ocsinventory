#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 29/09/2016
# Versão: 0.10
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Instalação do Netdata
#
# Utilizar o comando: sudo -i para executar o script
#
# Caminho para o Log do netdata.sh
LOG="/var/log/netdata.log"
#


if [ "$USUARIO" == "0" ]
then
	if [ "$UBUNTU" == "16.04" ]
		then
			if [ "$KERNEL" == "4.4" ]
				then
					 clear
					 #Exportando a variável do Debian Frontend Noninteractive para não solicitar interação com o usuário
					 export DEBIAN_FRONTEND=noninteractive
					 
					 echo -e "Usuário é `whoami`, continuando a executar o netdata.sh"
					 echo
					 echo  ============================================================ >> $LOG
					 
					 echo -e "Instalação do sistema de monitoramente em tempo real Netdata"
					 echo -e "Após a instalação acessar a URL http://`hostname`:19999"
					 echo -e "Pressione <Enter> para instalar"
					 read
					 sleep 2
					 echo
					 
					 #Clonando o site do GitHub do Netdata
					 git clone https://github.com/firehol/$NETDATAVERSION --depth=1 &>> $LOG
					 
					 echo -e "Clonagem do software do Netdata feito com sucesso!!!"
					 echo
					 
					 #Acessando o diretório do Netdata
					 cd $NETDATAINSTALL
					 
					 #Compilando e instalando o Netdata
					 echo -e "Pressione <Enter> para compilar o software do NetData"
					 echo
					 read
					 
					 #Executando o script de instalação do Netdata
					 ./netdata-installer.sh
					 
					 #MENSAGENS QUE SERÃO SOLICITADAS NA INSTALAÇÃO DO NETDATA
					 #Press ENTER to build and install netdata to your system? <-- pressione <Enter>
					 #Saindo do diretório do Netdata
					 cd ..
					 
					 echo
					 echo -e "Instalação do Netdata feita com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Fim do netdata.sh em: `date`" >> $LOG
					 echo -e "Instalação do Netdata feito com Sucesso!!!!!"
					 echo
					 # Script para calcular o tempo gasto para a execução do netdata.sh
						 DATAFINAL=`date +%s`
						 SOMA=`expr $DATAFINAL - $DATAINICIAL`
						 RESULTADO=`expr 10800 + $SOMA`
						 TEMPO=`date -d @$RESULTADO +%H:%M:%S`
					 echo -e "Tempo gasto para execução do netdata.sh: $TEMPO"
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
