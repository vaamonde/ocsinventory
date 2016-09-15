# OCS Inventory Server

Script de automatização da instalação do OCS Inventory Server no GNU/Linux Ubuntu Server 16.04 LTS

Procedimento para utilizar os scripts.

01: Instale o GNU/Linux Ubuntu Server 16.04 LTS x64;<br>
02: Altere para super usuário com o comando: sudo -i;<br>
03: Faça o clone do projeto para o servidor: git clone https://github.com/vaamonde/ocsinventory;<br>
04: Acesse o diretório: ocsinventory: cd ocsinventory/;<br>
05: Altere as permissões dos arquivos: chmod +x *.sh;<br>
06: Execute primeiro o arquivo: update.sh utilizando o comando: ./update.sh;<br>
07: Após a reinicialização, execute o arquivo: install.sh utilizando o comando: ./install.sh;<br>
08: Siga a instruções que serão apresentadas na tela.;<br>
09: Após a reinicialização, utilize um navegador, recomendo o Firefox na URL: http://SEU_ENDEREÇO_IP/ocsreports;<br>
10: Finalize a instalação e criação da base de dados via navegador;<br>
11: Acesse o PhpMyAdmin, utilize um navegador, recomendo o Firefox na URL: http://SEU_ENDEREÇO_IP/phpmyadmin;<br>
12: Altere a senha do usuário: ocs@localhost no Banco de Dados mysql na tabela user;<br>
13: Após a instalação, remova o arquivo: install.php localizado em: /usr/share/ocsinventory-reports/ocsreports;<br>
14: Edite o arquivo dbconfig.inc.php e altere a senha do banco de dados;<br>
15: Edite o arquivo z-ocsinventory-server.conf e altere a senha do banco de dados;<br>
16: Atualize as informações do Agent do Servidor digitando o comando: ocsinventory-agent.<br>

Sucesso sempre, Bora para Prática.<br>
Robson Vaamonde<br>
http://www.facebook.com/procedimentosemti<br>
http://ww.facebook.com/boraparapratica<br>
http://www.youtube.com/boraparapratica<br>
http://aulaead.com/cursos
