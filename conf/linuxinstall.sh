#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 05/02/2018
# Data de atualização: 05/02/2018
# Versão: 0.1

# Procedimentos para instalação do Agente do OCS Inventory na Plataforma GNU/Linux
# Script de instalação para distribuição derivadas do Debian (Ubuntu e Linux Mint)
# Adaptar o script para a sua necessidade, para distribuições baseadas no Red Hat
# Utilizar o comando yum, verificar os diretórios também e sua localização.

echo -e "Atualizando as Listas do Apt-Get, aguarde..."
# Atualizar as listas do apt-get
apt-get update
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Atualizando os Software instalados, aguarde..."
# Atualizar o sistema
apt-get upgrade
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Atualizando a Distribuição Kernel, aguarde..."
# Atualizar a distribuição
apt-get dist-upgrade
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Instalando o OCS Inventory Agent e suas Dependências, aguarde..."
# Instalando o OCS Inventory Agent e suas Dependências.
apt-get install ocsinventory-agent libnet-ssleay-perl libcrypt-ssleay-perl vim git
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Baixando o arquivo do Certificado e das Configurações do OCS Inventory Agent, aguarde..."
# Fazendo o download dos arquivos do Servidor OCS Inventory
wget http://ocs.pti.intra/download/ocs.crt
echo
wget http://ocs.pti.intra/download/ocsinventory-agent.cfg
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Copiando o arquivo do Certificado, aguarde..."
# Copiando o arquivo de Certificado Raiz
cp -v ocs.crt /usr/local/share/ca-certificates/ocs.crt
echo
cp -v ocs.crt /etc/ocsinventory/ocs.crt
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Atualizando o Certificado Raiz, aguarde..."
# Atualizando o Certififcado Raiz do Desktop
update-ca-certificates
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Testando a conexão HTTPS, aguarde..."
# Testando se o Certificado está funcionando com o wget
wget https://ocs.pti.intra/download/ocs.crt -O /tmp/ocs.crt
echo -e "Caso aparece alguma mensagem de ERRO, verificar a opção: update-ca-certificates"
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Atualizando o arquivo de configuração do OCS Inventory Agent, aguarde..."
# Atualizando o arquivo de configuração do OCS Inventory Agent
cp -v ocsinventory-agent.cfg /etc/ocsinventory/ocsinventory-agent.cfg
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Editando o arquivo de configuração do OCS Inventory Agent, aguarde..."
# Editando o arquivo de configuração do OCS Inventory Agent
vim /etc/ocsinventory/ocsinventory-agent.cfg
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Criando o Diretório de Log do OCS Inventory Agent, aguarde..."
# Criando o Diretório de Log OCS Inventory Agent
mkdir -v /var/log/ocsinventory-agent/
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Criando o Arquivo de Log do OCS Inventory Agent, aguarde..."
# Criando o Arquivo de Log do OCS Inventory Agent
touch /var/log/ocsinventory-agent/activity.log
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Executando o inventário novamente, aguarde..."
# Atualizando o Inventário
echo > /var/log/ocsinventory-agent/activity.log
echo
ocsinventory-agent --debug -i
echo -e "Pressione <Enter> para continuar..."
read
clear

echo -e "Analisando o arquivo de Log do OCS Inventory Agent, aguarde..."
# Verificando o conteúdo do Arquivo de Log do OCS Inventory Agent
less /var/log/ocsinventory-agent/activity.log
echo -e "Pressione <Enter> para continuar..."
read
clear
