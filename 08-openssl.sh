#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 04/01/2018
# Data de atualização: 08/11/2020
# Versão: 0.4
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x
#
# Criação dos Certificados utilizados pelo Apache2, OCS Inventory Server e Agent
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
# Script de criação dos Certificados do OCS Inventory no GNU/Linux Ubuntu Server 16.04.x
# opção do comando: &>> (redirecionar a saída padrão)
# opção do comando echo: -e (enable interpretation of backslash escapes), \n (new line)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
clear
echo
#
echo -e "Geração das Chaves Privadas/Públicas e Criação do Certificado do Apache2 para o OCS Inventory"
echo -e "Pressione <Enter> gerar os Certificados"
read
sleep 2
echo
#
echo -e "Criando o Chave de Criptografia de 2048 bits, senha padrão: ocsinventory, aguarde..." 
	# opção do comando openssl: genrsa (Generation of RSA Private Key), -des3 (Triple-DES Cipher), -out (output file)
	openssl genrsa -des3 -out ocs.key 2048
echo -e "Chave de criptografia criada com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Renomeando o arquivo de chaves ocs.key para ocs-old.key, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: v (verbose)
	mv -v ocs.key ocs-old.key &>> $LOG
echo -e "Arquivo renomeado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Alterando as informações das chaves de criptografia, senha padrão: ocsinventory, aguarde..."
	# opção do comando openssl: rsa (RSA key management), -in (input file), -out (output file)
	openssl rsa -in ocs-old.key -out ocs.key
echo -e "Chave alterada com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Criando o arquivo CSR (Certificate Signing Request), nome FQDN: `hostname`, aguarde..."
	# opção do comando openssl: req (PKCS#10 X.509 Certificate Signing Request (CSR) Management), -new (new CSR), -key (input file RSA), -out (output file CSR)
	# Criando o arquivo CSR, mensagens que serão solicitadas para a criação do certificado
	# Country Name (2 letter code): BR <-- pressione <Enter>
	# State or Province Name (full name): Brasil <-- pressione <Enter>
	# Locality Name (eg, city): Sao Paulo <-- pressione <Enter>
	# Organization Name (eg, company): Bora para Pratica <-- pressione <Enter>
	# Organization Unit Name (eg, section): Procedimentos em TI <-- pressione <Enter>
	# Common Name (eg, server FQDN or YOUR name): ocs.pti.intra <-- pressione <Enter>
	# Email Address: pti@pti.intra <-- pressione <Enter>
	# A challenge password: <-- pressione <Enter>
	# A optional company name: <-- pressione <Enter>
	openssl req -new -key ocs.key -out ocs.csr
echo -e "Arquivo CSR criado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Alterando o arquivo CSR (Certificate Signing Request), nome FQDN: `hostname`, aguarde..."
	# opção do comando openssl: x509 (X.509 Certificate Data Management), -req (PKCS#10 X.509 Certificate Signing Request (CSR) Management), -days
	# (validate certificate file), -in (input file CSR), -singkey (file RSA), -out (output file CRT)
	openssl x509 -req -days 3650 -in ocs.csr -signkey ocs.key -out ocs.crt
echo -e "Arquivo CSR alterado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Atualizando os Diretórios do SSL e OCS Inventory Agent com as novas Chaves"

echo -e "Copiando arquivo ocs.crt para o diretório dos Certificados SSL, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: v (verbose)
	cp -v ocs.crt /etc/ssl/certs/ &>> $LOG
echo -e "Arquivo pcs.crt copiado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Copiando o arquivo ocs.key para o diretório Privado do SSL, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: v (verbose)
	cp -v ocs.key /etc/ssl/private/ &>> $LOG
echo -e "Arquivo ocs.key copiado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Copiando os arquivo ocs.crt e ocs.key para OCS Inventory Agent"
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: v (verbose)
	cp -v ocs.crt ocs.key /etc/ocsinventory-agent/ &>> $LOG
echo -e "Arquivos copiados com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Fazendo o backup do arquivo default-ssl.conf, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: v (verbose)
	mv -v /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf.bkp &>> $LOG
echo -e "Arquivo backupeado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Atualizando o arquivo default-ssl.conf, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando cp: v (verbose)
	cp -v conf/default-ssl.conf /etc/apache2/sites-available/ &>> $LOG
echo -e "Arquivo atualizado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando o arquivo default-ssl.conf, aguarde..."
	sleep 2
	vim /etc/apache2/sites-available/default-ssl.conf
echo -e "Arquivo editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Habilitando o Módulo de SSL e o Site Default-ssl no Apache2, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	a2enmod ssl &>> $LOG
	a2ensite default-ssl &>> $LOG
	sudo service apache2 restart
echo -e "Módulo e Site habilitado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Editando o arquivo do OCS Inventory Agent para suportar SSL, pressione <Enter> para continuar"
	read
	vim /etc/ocsinventory-agent/ocsinventory-agent.cfg
echo -e "Arquivo editado com sucesso!!!, continuando com o script..."
sleep 2
echo
#
echo -e "Fazendo o inventário novamente do OCS Inventory Agent com suporte ao SSL, aguarde..."
	# opção do comando: echo > (redirecionar a saída padrão para o arquivo)
	echo > /var/log/ocsinventory-agent/activity.log
	ocsinventory-agent --debug
	less /var/log/ocsinventory-agent/activity.log
echo -e "Inventário feito sucesso!!!, pressione <Enter> para continuar"
sleep 2
echo
#
echo -e "Criação e Configuração dos Certificados do OCS Inventory Server e Agent finalizada com sucesso!!!"
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