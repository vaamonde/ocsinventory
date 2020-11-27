#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 09/01/2018
# Data de atualização: 29/01/2018
# Versão: 0.13
# Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
# Kernel >= 4.4.x

#Variáveis de ambiente do script
HOST="localhost"
USER="root"
PWD="123456"
DB="ocsweb"
PATH_1="/backup/ocsinventory"
DATA=`date +%d_%m_%Y-%H_%M`
LOG="$PATH_1/backup.log"

#Verificando se o diretório de Backup existe
if [ -d $PATH_1 ]; then
	echo -e "Diretório de Log existe, continuando o backup..."
else
	echo -e "Diretório de Log não existe, criando o diretório."
	mkdir -pv $PATH_1
	echo -e "Diretório criado sucesso!!!!, continuando o backup..."
fi

#Reinicializando o serviço do MySQL
sudo service mysql restart

echo -e "Backup da Base de Dados: $DB" &>> $LOG
mysqldump --add-drop-table --complete-insert --extended-insert --quote-names --host=$HOST --user=$USER --password=$PWD --databases $DB > $PATH_1/ocsweb-$DATA.sql
echo -e "Backup feito com sucesso!!!, continuando o backup..." &>> $LOG

echo -e "Compactando o Backup da Base de Dados: $DB" &>> $LOG
tar -zcvf $PATH_1/ocsweb-$DATA.tar.gz $PATH_1/ocsweb-$DATA.sql &>> $LOG
echo -e "Compactação feita com sucesso!!!, continuando o backup..." &>> $LOG

echo -e "Removendo o arquivo SQL da Base Dados: $DB" &>> $LOG
rm -v $PATH_1/*.sql &>> $LOG
echo -e "Arquivo removido com sucesso!!!, continuando o backup..." &>> $LOG

echo -e "Backup do $DB finalizado com sucesso!!!" &>> $LOG
