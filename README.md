# OCS Inventory Server

Script de automatização da instalação do OCS Inventory Server, OCS Inventory Agent, GLPI Help Desk e do Netdata Monitor no GNU/Linux Ubuntu Server 16.04 LTS

Procedimento para utilizar os scripts.

01: Instale o GNU/Linux Ubuntu Server 16.04 LTS x64;<br><br>
02: Altere para super usuário com o comando: <b>sudo -i</b>;<br><br>
03: Faça o clone do projeto para o servidor: git clone https://github.com/vaamonde/ocsinventory;<br><br>
04: Acesse o diretório: ocsinventory: <b>cd ocsinventory/</b>;<br><br>
05: Altere as permissões dos arquivos: <b>chmod +x *.sh</b>;<br><br>
06: Execute primeiro o arquivo: <b>01-update.sh</b> utilizando o comando: <b>./01-update.sh</b>;<br><br>
07: Após a reinicialização, execute o arquivo: <b>02-lamp.sh</b> utilizando o comando: <b>./02-lamp.sh</b>;<br><br>
08: Siga as instruções que serão apresentadas na tela;<br><br>
09: Após a reinicialização, execute o arquivo: <b>03-ocs_server.sh</b> utilizando o comando: <b>./03-ocs_server.sh</b>;<br><br>
10: Siga as instruções que serão apresentadas na tela;<br><br>
11: Após a reinicialização, utilize um navegador para finalizar a configuração, recomendo o Firefox acessando a URL: http://ENDEREÇO_IP_DO_SERVIDOR/ocsreports;<br><br>
12: Finalize a instalação e criação da base de dados via navegador, utilizando o usuário: "root", senha: "123456", basse de dados: "ocsweb" e servidor: "localhost", usuário de administração do OCS Reports padrão e: "admin" com senha: "admin";<br><br>
13: Acesse o <b>PhpMyAdmin</b>, utilize um navegador, recomendo o Firefox acessando a URL: http://ENDEREÇO_IP_DO_SERVIDOR/phpmyadmin;<br><br>
14: Altere a senha do usuário: <b>ocs@localhost</b> no Banco de Dados: <b>mysql</b> na tabela: <b>user</b>;<br><br>
15: Após a instalação, remova o arquivo: <b>install.php</b> localizado em: <b>/usr/share/ocsinventory-reports/ocsreports/</b>;<br><br>
16: Edite o arquivo: <b>dbconfig.inc.php</b> e altere a senha do banco de dados localizado em: <b>/usr/share/ocsinventory-reports/ocsreports/</b>;<br><br>
17: Edite o arquivo: <b>z-ocsinventory-server.conf</b> e altere a senha do banco de dados localizado em: <b>/etc/apache2/conf-availabel/</b>;<br><br>
18: Após a configuração do OCS Inventory Server, instale o OCS Inventory Agent, execute o arquivo: <b>04-ocs_agent.sh</b> utilizando o comando: <b>./04-ocs_agent.sh</b>;<br><br>
19: Após a reinicialização, utilize um navegador, recomendo o Firefox acessando a URL: http://ENDEREÇO_IP_DO_SERVIDOR/ocsreports;<br><br>
20: Verifique se foi adicionado um novo computador na base de dados do OCS Inventory Server;<br><br>
21: Atualize as informações do OCS Inventory Agent digitando o comando: <b>ocsinventory-agent</b>;<br><br>
22: Após a configuração do OCS Inventory Agent, instale o GLPI Help Desk, execute o arquivo: <b>05-glpi.sh</b> utilizando o comando: <b>./05-glpi.sh</b>;<br><br>
23: Após a reinicialização, utilize um navegador, recomendo o Firefox acessando a URL: http://ENDEREÇO_IP_DO_SERVIDOR/glpi;<br><br>
24: Finalize a instalação e criação da base de dados do GLPI Help Desk via navegador;<br><br>
25: Configure o Plugin do OCS Inventory Server no GLPI Help Desk;<br><br>
26: Após a configuração do Plugin do OCS Inventory Agent no GLPI Help Desk, instale o Netdata Monitor, execute o arquivo: <b>06-netdata.sh</b> utilizando o comando: <b>./06-netdata.sh</b>;<br><br>
27: Após a reinicialização, verifique o desempenho do servidor acessando o Netdata, utilize um navegador, recomendo o Firefox acessando a URL: http://SEU_ENDEREÇO_IP:19999;<br><br>

Sucesso sempre, Bora para Prática.<br>
Robson Vaamonde<br>
http://www.facebook.com/procedimentosemti<br>
http://ww.facebook.com/boraparapratica<br>
http://www.youtube.com/boraparapratica<br>
http://www.aulaead.com/
