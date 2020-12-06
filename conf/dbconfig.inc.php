<?php
// Autor: Robson Vaamonde Site: www.procedimentosemti.com.br
// Script utilizado no Curso de OCS Inventory Server
// Facebook: facebook.com/ProcedimentosEmTI
// Facebook: facebook.com/BoraParaPratica
// YouTube: youtube.com/BoraParaPratica
// Data de criação: 31/05/2016
// Data de atualização: 08/11/2020
// Versão: 0.12
// Testado e homologado para a versão do Ubuntu Server 16.04 LTS x64
// Kernel >= 4.4.x

// Nome da Base de Dados do OCS Inventory Server
define("DB_NAME", "ocsweb");
// Nome do Servidor de Leitura da Base de Dados do OCS Inventory Server
define("SERVER_READ","localhost");
// Nome do Servidor de Escrita da Base de Dados do OCS Inventory Server
define("SERVER_WRITE","localhost");
// Porta de Conexão do Banco de Dados do MySQL do OCS Inventory Server
define("SERVER_PORT","3306");
// Nome do Usuário de autenticação na Base de Dados do OCS Inventory Server
define("COMPTE_BASE","ocs");
// Senha do Usuário de autenticação na Base de Dados do OCS Inventory Server
define("PSWD_BASE","123456");
// Configurações do Suporte ao SSL HTTPS do OCS Inventory Server
define("ENABLE_SSL","0");
define("SSL_MODE","");
define("SSL_KEY","");
define("SSL_CERT","");
define("CA_CERT","");
?>
