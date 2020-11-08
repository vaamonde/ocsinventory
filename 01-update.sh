#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Data de criação: 31/05/2016
# Data de atualização: 08/11/2020
# Versão: 0.16
# Testado e homologado para a versão do Ubuntu Server 16.04.x LTS x64
# Kernel >= 4.4.x
#
# Atualização das listas do Apt-Get
# Atualização dos Aplicativos Instalados
# Atualização da Distribuição Ubuntu Server (Kernel)
# Auto-Limpeza do Apt-Get
# Limpeza do repositório Local do Apt-Get
# Reinicialização do Servidor
#
# Arquivo de configuração dos parâmetros
source 00-parametros.sh
#
# Caminho do arquivo para o Log do script
LOG=$VARLOGPATH/$LOGSCRIPT
#
# Verificação da criação do Diretório de Log, usado somente no script de atualização
# opção do comando: echo: -e (interpretador de escapes de barra invertida)
# opção do comando if: [ ] = testa uma expressão, -e = testa se é diretório existe
echo -e "Verificando se o diretório de Log existe, aguarde...\n"
if [ -e "$VARLOGPATH" ]; then
	echo -e "Diretório: $VARLOGPATH já existe, continuando com o script"
	sleep 3
else
	echo -e "Diretório: $VARLOGPATH não existe, criando o diretório, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mkdir: -v (verbose)
	mkdir -v $VARLOGPATH
	echo -e "Diretório criado com sucesso!!!, continuando com o script..."
	sleep 3
fi
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
# Script de atualização do GNU/Linux Ubuntu Server 16.04.x
# opção do comando: &>> (redirecionar a saída padrão)
# opção do comando echo: -e (enable interpretation of backslash escapes), \n (new line)
# opção do comando hostname: -I (all IP address)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
clear
#
echo -e "Usuário é `whoami`, continuando a executar o $LOGSCRIPT\n"
echo -e "Atualização das Listas do Apt-Get"
echo -e "Atualização dos Aplicativos Instalados"
echo -e "Atualização da Distribuição Ubuntu Server (Kernel)"
echo -e "Remoção dos aplicativos desnecessários"
echo -e "Limpando o repositório Local do Apt-Get (Cache)"
echo
echo -e "Após o término o Servidor será reinicializado, aguarde..."
echo
#
echo -e "Adicionando o Repositório Universal do Apt, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	add-apt-repository universe &>> $LOG
echo -e "Repositório adicionado com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Adicionando o Repositório Multiversão do Apt, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	add-apt-repository multiverse &>> $LOG
echo -e "Repositório adicionado com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Atualizando as listas do Apt, aguarde..."
	#opção do comando: &>> (redirecionar a saída padrão)
	apt-get update &>> $LOG
echo -e "Listas atualizadas com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Atualizando os pacotes instalados, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt-get: -o (options), -q (quiet), -y (yes)
	apt-get -o Dpkg::Options::="--force-confold" upgrade -q -y --force-yes &>> $LOG
echo -e "Pacotes atualizados com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Atualizando a distribuição é o Kernel, aguarde..."
echo -e "Kernel atual: `uname -r`"
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt-get: -o (options), -q (quiet), -y (yes)
	# opção do comando uname: -r (kernel release)
	apt-get -o Dpkg::Options::="--force-confold" dist-upgrade -q -y --force-yes &>> $LOG
echo -e "Distribuição e Kernel atualizados, versões instaladas.\n"
	# opção do comando cut: -d (delimiter), -f (fields)
	dpkg --list | grep linux-image-4.4 | cut -d' ' -f 3
echo -e "Distribuição e Kernel atualizadas com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Remoção dos aplicativos desnecessários, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt-get: -y (yes)
	apt-get -y autoremove &>> $LOG
	apt-get -y autoclean &>> $LOG
echo -e "Remoção dos aplicativos concluída com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Limpando o cache do Apt-Get, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt-get: -y (yes)
	apt-get clean &>> $LOG
echo -e "Cache limpo com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Atualização das Listas, Aplicativos e do Kernel feito com sucesso!!!!!"
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
echo -e "Pressione <Enter> para reinicializar o servidor: `hostname`"
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Fim do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
read
sleep 2
reboot