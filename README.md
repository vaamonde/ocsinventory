# OCS Inventory Server

Script de automatização da instalação do OCS Inventory Server, OCS Inventory Agent, GLPI Help Desk e do Netdata Monitor no GNU/Linux Ubuntu Server 16.04 LTS

Procedimento para utilizar os scripts.

01: Instale o GNU/Linux Ubuntu Server 16.04 LTS x64;<br>
02: Altere para super usuário com o comando: sudo -i;<br>
03: Faça o clone do projeto para o servidor: git clone https://github.com/vaamonde/ocsinventory;<br>
04: Acesse o diretório: ocsinventory: cd ocsinventory/;<br>
05: Altere as permissões dos arquivos: chmod +x *.sh;<br>
06: Execute primeiro o arquivo: 01-update.sh utilizando o comando: ./01-update.sh;<br>
07: Após a reinicialização, execute o arquivo: 02-lamp.sh utilizando o comando: ./02-lamp.sh;<br>
08: Siga as instruções que serão apresentadas na tela;<br>
09: Após a reinicialização, execute o arquivo: 03-ocs_server.sh utilizando o comando: ./03-ocs_server.sh;<br>
10: Siga as instruções que serão apresentadas na tela;<br>
11: Após a reinicialização, utilize um navegador, recomendo o Firefox acesse a URL: http://SEU_ENDEREÇO_IP/ocsreports;<br>
12: Finalize a instalação e criação da base de dados via navegador;<br>
13: Acesse o PhpMyAdmin, utilize um navegador, recomendo o Firefox na URL: http://SEU_ENDEREÇO_IP/phpmyadmin;<br>
14: Altere a senha do usuário: ocs@localhost no Banco de Dados mysql na tabela user;<br>
15: Após a instalação, remova o arquivo: install.php localizado em: /usr/share/ocsinventory-reports/ocsreports;<br>
16: Edite o arquivo dbconfig.inc.php e altere a senha do banco de dados localizado em: /usr/share/ocsinventory-reports/ocsreports;;<br>
17: Edite o arquivo z-ocsinventory-server.conf e altere a senha do banco de dados localizado em: /etc/apache2/conf-availabel;<br>
18: Após a configuração do OCS Inventory Server, instale o OCS Agent, execute o arquivo: 04-ocs_agent.sh;<br>
19: Após a reinicialização, utilize um navegador, recomendo o Firefox acesse a URL: http://SEU_ENDEREÇO_IP/ocsreports;<br>
20: Verifique se foi adicionado um novo computador a base de dados do OCS Inventory Server;<br>
21: Atualize as informações do OCS Inventory Agent digitando o comando: ocsinventory-agent;<br>
22: Após a configuração do OCS Inventory Agent, instale o GLPI Help Desk, execute o arquivo: 05-glpi.sh;<br>
23: Após a reinicialização, utilize um navegador, recomendo o Firefox acesse a URL: http://SEU_ENDEREÇO_IP/glpi;<br>
24: Finalize a instalação e criação da base de dados via navegador;<br>
25: Configure o Plugin do OCS Inventory no GLPI;<br>
26: Verifique o desempenho do servidor acesso o Netdata, utilize um navegador, recomendo o Firefox acesse a URL: http://SEU_ENDEREÇO_IP:19999;<br>

Sucesso sempre, Bora para Prática.<br>
Robson Vaamonde<br>
http://www.facebook.com/procedimentosemti<br>
http://ww.facebook.com/boraparapratica<br>
http://www.youtube.com/boraparapratica<br>
http://aulaead.com/cursos
