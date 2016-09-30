# OCS Inventory Server

Script de automatização da instalação do OCS Inventory Server, OCS Inventory Agent, GLPI Help Desk e do Netdata Monitor no GNU/Linux Ubuntu Server 16.04 LTS

Procedimento para utilizar os scripts.

01: Instale o GNU/Linux Ubuntu Server 16.04 LTS x64;<br>
02: Altere para super usuário com o comando: <b>sudo -i</b>;<br>
03: Faça o clone do projeto para o servidor: git clone https://github.com/vaamonde/ocsinventory;<br>
04: Acesse o diretório: ocsinventory: <b>cd ocsinventory/</b>;<br>
05: Altere as permissões dos arquivos: <b>chmod +x *.sh</b>;<br>
06: Execute primeiro o arquivo: <b>01-update.sh</b> utilizando o comando: <b>./01-update.sh</b>;<br>
07: Após a reinicialização, execute o arquivo: <b>02-lamp.sh</b> utilizando o comando: <b>./02-lamp.sh</b>;<br>
08: Siga as instruções que serão apresentadas na tela;<br>
09: Após a reinicialização, execute o arquivo: <b>03-ocs_server.sh</b> utilizando o comando: <b>./03-ocs_server.sh</b>;<br>
10: Siga as instruções que serão apresentadas na tela;<br>
11: Após a reinicialização, utilize um navegador, recomendo o Firefox acesse a URL: http://SEU_ENDEREÇO_IP/ocsreports;<br>
12: Finalize a instalação e criação da base de dados via navegador;<br>
13: Acesse o <b>PhpMyAdmin</b>, utilize um navegador, recomendo o Firefox na URL: http://SEU_ENDEREÇO_IP/phpmyadmin;<br>
14: Altere a senha do usuário: <b>ocs@localhost</b> no Banco de Dados: <b>mysql</b> na tabela: <b>user</b>;<br>
15: Após a instalação, remova o arquivo: <b>install.php</b> localizado em: <b>/usr/share/ocsinventory-reports/ocsreports/</b>;<br>
16: Edite o arquivo: <b>dbconfig.inc.php</b> e altere a senha do banco de dados localizado em: <b>/usr/share/ocsinventory-reports/ocsreports/</b>;<br>
17: Edite o arquivo: <b>z-ocsinventory-server.conf</b> e altere a senha do banco de dados localizado em: <b>/etc/apache2/conf-availabel/</b>;<br>
18: Após a configuração do OCS Inventory Server, instale o OCS Inventory Agent, execute o arquivo: <b>04-ocs_agent.sh</b> utilizando o comando: <b>./04-ocs_agent.sh</b>;<br>
19: Após a reinicialização, utilize um navegador, recomendo o Firefox acesse a URL: http://SEU_ENDEREÇO_IP/ocsreports;<br>
20: Verifique se foi adicionado um novo computador na base de dados do OCS Inventory Server;<br>
21: Atualize as informações do OCS Inventory Agent digitando o comando: <b>ocsinventory-agent</b>;<br>
22: Após a configuração do OCS Inventory Agent, instale o GLPI Help Desk, execute o arquivo: <b>05-glpi.sh</b> utilizando o comando: <b>./05-glpi.sh</b>;<br>
23: Após a reinicialização, utilize um navegador, recomendo o Firefox acesse a URL: http://SEU_ENDEREÇO_IP/glpi;<br>
24: Finalize a instalação e criação da base de dados do GLPI Help Desk via navegador;<br>
25: Configure o Plugin do OCS Inventory Server no GLPI Help Desk;<br>
26: Após a configuração do OCS Inventory Agent, instale o Netdata Monitor, execute o arquivo: <b>06-netdata.sh</b> utilizando o comando: <b>./06-netdata.sh</b>;<br>
27: Após a reinicialização, verifique o desempenho do servidor acessando o Netdata, utilize um navegador, recomendo o Firefox acesse a URL: http://SEU_ENDEREÇO_IP:19999;<br>

Sucesso sempre, Bora para Prática.<br>
Robson Vaamonde<br>
http://www.facebook.com/procedimentosemti<br>
http://ww.facebook.com/boraparapratica<br>
http://www.youtube.com/boraparapratica<br>
http://aulaead.com/cursos
