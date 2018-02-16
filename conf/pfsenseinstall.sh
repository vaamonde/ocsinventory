#!/bin/sh
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 16/02/2018
# Data de atualização: 16/02/2018
# Versão: 0.1

# Procedimentos para instalação do Agente do OCS Inventory na Plataforma FreeBSD
# Script adaptado para a instalação no pfSense versão 2.4
# Informações dos pacotes: http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/
# Recomendado fazer a instalação de 5 em 5, verificar sempre as versões dos software

#Instalar primeiro o comando wget: pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/wget-1.19.4.txz
#Depois baixar o script: /usr/local/bin/wget http://172.16.10.11/download/pfsenseinstall.sh

echo -e "Primeira etapa de instalação, aguarde..."
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-URI-1.73.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Net-SSLeay-1.84.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-IO-Socket-IP-0.39.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Mozilla-CA-20160104.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Socket-2.027.txz
echo -e "Instalação feita com sucesso!!!, continuando o script em 5 segundos..."
sleep 5

echo -e "Segunda etapa de instalação, aguarde..."
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-IO-Socket-SSL-2.051.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Net-HTTP-6.17.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Digest-HMAC-1.03_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Authen-NTLM-1.09_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Encode-Locale-1.05.txz
echo -e "Instalação feita com sucesso!!!, continuando o script em 5 segundos..."
sleep 5

echo -e "Terceira etapa de instalação, aguarde..."
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-IO-HTML-1.001_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-HTTP-Date-6.02_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-LWP-MediaTypes-6.02_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-HTTP-Message-6.14.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-HTTP-Daemon-6.01_1.txz
echo -e "Instalação feita com sucesso!!!, continuando o script em 5 segundos..."
sleep 5

echo -e "Quarta etapa de instalação, aguarde..."
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-HTTP-Negotiate-6.01_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-WWW-RobotRules-6.02_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-HTTP-Cookies-6.04.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-HTML-Tagset-3.20_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-HTML-Parser-3.72.txz
echo -e "Instalação feita com sucesso!!!, continuando o script em 5 segundos..."
sleep 5

echo -e "Quinta etapa de instalação, aguarde..."
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Try-Tiny-0.28.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-File-Listing-6.04_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-libwww-6.31.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-LWP-Protocol-https-6.07_1.txz
echo -e "Instalação feita com sucesso!!!, continuando o script em 5 segundos..."
sleep 5

echo -e "Sexta etapa de instalação, aguarde..."
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/nmap-7.60.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-XML-Namespace-0.02_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-XML-NamespaceSupport-1.12.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-XML-SAX-Base-1.09.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-XML-SAX-0.99_2.txz
echo -e "Instalação feita com sucesso!!!, continuando o script em 5 segundos..."
sleep 5

echo -e "Sétima etapa de instalação, aguarde..."
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-XML-Parser-2.44.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-XML-SAX-Expat-0.51_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-XML-Simple-2.24.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Net-Netmask-1.9022.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Proc-Daemon-0.23.txz
echo -e "Instalação feita com sucesso!!!, continuando o script em 5 segundos..."
sleep 5

echo -e "Oitava etapa de instalação, aguarde..."
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Crypt-CBC-2.33_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Crypt-DES-2.07_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Digest-SHA1-2.13_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Net-SNMP-6.0.1_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Storable-2.45_1.txz
echo -e "Instalação feita com sucesso!!!, continuando o script em 5 segundos..."
sleep 5

echo -e "Nona etapa de instalação, aguarde..."
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Tie-IxHash-1.23_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Text-Iconv-1.7_3.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-HTML-Tree-5.07.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Scalar-List-Utils-1.48,1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-XML-XPath-1.42.txz
echo -e "Instalação feita com sucesso!!!, continuando o script em 5 segundos..."
sleep 5

echo -e "Décima etapa de instalação, aguarde..."
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-XML-Twig-3.52.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Nmap-Parser-1.36.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Crypt-SSLeay-0.72_3.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/pciids-20171206.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/libpci-3.5.6.txz
echo -e "Instalação feita com sucesso!!!, continuando o script em 5 segundos..."
sleep 5

echo -e "Décima Primeira etapa de instalação, aguarde..."
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/pciutils-3.5.6.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-Net-IP-1.26_1.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-PPerl-0.25_4.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/atk-2.24.0.txz
pkg add http://pkg.freebsd.org/freebsd:11:x86:64/latest/All/p5-libwww-6.31.txz
echo -e "Instalação feita com sucesso!!!, continuando o script em 5 segundos..."
sleep 5

echo -e "Instalação do Agente do OCS Inventory, aguarde..."
pkg add http://pkg.freebsd.org/freebsd:11:x86:32/latest/All/Ocsinventory-Unix-Agent-2.1.1_4,1.txz
echo -e "Instalação feita com sucesso!!!, continuando o script em 5 segundos..."
sleep 5

echo -e "Criação dos Diretórios das Instalação do Agente do OCS Inventory, aguarde..."
mkdir -v /etc/ocsinventory/
mkdir -v /var/log/ocsinventory-agent/
mkdir -pv /var/lib/ocsinventory-agent/
touch /var/log/ocsinventory-agent/activity.log
echo -e "Criação dos Diretórios feito com sucesso!!!, continuando o script em 5 segundos..."
sleep 5


echo -e "Finalização da instalação do OCS Inventory Agent no pfSense"
perl5 /usr/local/lib/perl5/site_perl/Ocsinventory/Unix/postinst.pl
echo -e "Instalação feita com sucesso!!!, continuando o script em 5 segundos..."
sleep 5

echo -e "Baixando o arquivo de configuração do OCS Inventory Agent, aguarde..."
/usr/local/bin/wget http://172.16.10.11/download/ocsinventory-agent.cfg -O /etc/ocsinventory/ocsinventory-agent.cfg
echo -e "Arquivo baixado com sucesso!!!, continuando o script em 5 segundos..."
sleep 5

echo -e "Editando o arquivo de Configuração do OCS Inventory Agent, aguarde..."
vi /etc/ocsinventory/ocsinventory-agent.cfg
echo -e "Arquivo editado com sucesso!!!, continuando o script em 5 segundos..."
sleep 5

echo -e "Executando o inventário do pfSense, aguarde..."
/usr/local/bin/ocsinventory-agent --debug
echo -e "Inventário feito com sucesso!!!, continuando o script em 5 segundos..."
sleep 5
