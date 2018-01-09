#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 09/01/2018
# Data de atualização: 09/01/2018
# Versão: 0.12
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x

#Variáveis de ambiente do script
HOST="localhost"
USER="root"
PWD="123456"
DB="ocsweb"
PATH="/backup/glpi"
DATA=`date +%d_%m_%Y-%H_%M`
LOG="$PATH/backup.log"

#Verificando se o diretório de Backup existe
if [ -d $PATH ]; then
	echo -e "Diretório de Log existe, continuando o backup..." &>> $LOG
else
	echo -e "Diretório de Log não existe, criando o diretório." &>> $LOG
	mkdir -p $PATH
	echo -e "Direttório criado sucesso!!!!, continuando o backup..." &>> $LOG
fi

echo -e "Backup da Base de Dados: $DB" &>> $LOG
mysqldump --add-drop-table --complete-insert --extended-insert --quote-names --host=$HOST --user=$USER --password=$PWD --databases $DB > $PATH/glpi-$DATA.sql
echo -e "Backup feito com sucesso!!!, continuando o backup..." &>> $LOG

echo -e "Compactando o Backup da Base de Dados: $DB" &>> $LOG
tar -zcvf $PATH/ocsweb-$DATA.tar.gz $PATH/ocsweb-$DATA.sql &>> $LOG
echo -e "Compactação feita com sucesso!!!, continuando o backup..." &>> $LOG

echo -e "Removendo o arquivo SQL da Base Dados: $DB" &>> $LOG
rm -v $PATH/*.sql &>> $LOG
echo -e "Arquivo removido com sucesso!!!, continuando o backup..." &>> $LOG

echo -e "Backup do $DB finalizado com sucesso!!!" &>> $LOG
