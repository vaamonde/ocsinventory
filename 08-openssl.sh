#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 04/01/2018
# Data de atualização: 04/01/2018
# Versão: 0.1
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Criação dos Certificados utilizado pelo Apache2 e OCS Inventory
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
					 
					 echo -e "Geração das Chaves Privadas/Públicas e Criação do Certificado"
					 echo -e "Pressione <Enter> gerar os Certificado"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Criando o Chave de Criptografia de 2048 bits, senha padrão: ocsinventory"
					 
					 #Criando a chave de criptografia
					 openssl genrsa -des3 -out ocs.key 2048
					 
					 echo -e "Chave criada com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Alterando a Chave de Criptografia, senha padrão: ocsinventory"
					 
					 #Renomeando o arquivo de chave
					 mv -v ocs.key ocs-old.key

					 #Alterando a chave de criptografia
					 openssl rsa -in ocs-old.key -out ocs.key
					 
					 echo -e "Chave alterada com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Criando o arquivo CSR (Certificate Signing Request), nome FQDN: `hostname`"
					 
					 #Criando o arquivo CSR
					 openssl req -new -key ocs.key -out ocs.csr
					 
					 echo -e "Arquivo CSR criado com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Alterando o arquivo CSR (Certificate Signing Request), nome FQDN: `hostname`"
					 
					 #Alterando o arquivo CSR
					 openssl x509 -req -days 3650 -in ocs.csr -signkey ocs.key -out ocs.crt
					 
					 echo -e "Arquivo CSR alterado com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Atualizando os Diretórios do SSL e OCS Inventory com as novas Chaves"
					 
					 cp ocs.crt /etc/ssl/certs/
					 cp ocs.key /etc/ssl/private/
					 cp ocs.crt ocs.key /etc/ocsinventory-agent/
					 
					 echo -e "Arquivo CSR alterado com sucesso!!!, pressione <Enter> para continuar"
					 read
					 sleep 2
					 clear
					 
					 echo -e "Fim do $LOGSCRIPT em: `date`" >> $LOG
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
