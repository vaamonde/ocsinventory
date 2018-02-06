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

# Atualizar as listas do apt-get
apt-get update
echo -e "Pressione <Enter> para continuar..."
read
clear

# Atualizar o sistema
apt-get upgrade
echo -e "Pressione <Enter> para continuar..."
read
clear

# Atualizar a distribuição
apt-get dist-upgrade
echo -e "Pressione <Enter> para continuar..."
read
clear

# Instalando o OCS Inventory Agent e suas Dependências.
apt-get install ocsinventory-agent libnet-ssleay-perl libcrypt-ssleay-perl
echo -e "Pressione <Enter> para continuar..."
read
clear

# Fazendo o download dos arquivos do Servidor OCS Inventory
wget http://ocs.pti.intra/download/ocs.crt
echo
wget http://ocs.pti.intra/download/ocsinventory-agent.cfg
echo -e "Pressione <Enter> para continuar..."
read
clear

# Copiando o arquivo de Certificado Raiz
cp -v ocs.crt /usr/local/share/ca-certificates/ocs.crt
echo
cp -v ocs.crt /etc/ocsinventory/ocs.crt
echo -e "Pressione <Enter> para continuar..."
read
clear

# Atualizando o Certififcado Raiz do Desktop
update-ca-certificates
echo -e "Pressione <Enter> para continuar..."
read
clear

# Testando se o Certificado está funcionando com o wget
wget https://ocs.pti.intra/download/ocs.crt -O /tmp/ocs.crt
echo -e "Pressione <Enter> para continuar..."
read
clear

# Atualizando o arquivo de configuração do OCS Inventory Agent
cp -v ocsinventory-agent.cfg /etc/ocsinventory/ocsinventory-agent.cfg
echo -e "Pressione <Enter> para continuar..."
read
clear

# Editando o arquivo de configuração do OCS Inventory Agent
vim /etc/ocsinventory/ocsinventory-agent.cfg
echo -e "Pressione <Enter> para continuar..."
read
clear

# Criando o Diretório de Log OCS Inventory Agent
mkdir -v /var/log/ocsinventory-agent/
echo -e "Pressione <Enter> para continuar..."
read
clear

# Criando o Arquivo de Log do OCS Inventory Agent
touch /var/log/ocsinventory-agent/activity.log
echo -e "Pressione <Enter> para continuar..."
read
clear

# Atualizando o Inventário
echo > /var/log/ocsinventory-agent/activity.log
ocsinventory-agent --debug -i
echo -e "Pressione <Enter> para continuar..."
read
clear

# Verificando o conteúdo do Arquivo de Log do OCS Inventory Agent
less /var/log/ocsinventory-agent/activity.log
echo -e "Pressione <Enter> para continuar..."
read
clear
