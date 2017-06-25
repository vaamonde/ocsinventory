# OCS Inventory Server integrado com o GLPI Help Desktop

Script de automatização da instalação do OCS Inventory Server, OCS Inventory Agent, GLPI Help Desk e do Netdata Monitor no GNU/Linux Ubuntu Server 16.04 LTS

Curso completo: aulaead.com

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
11: Após a reinicialização, utilize um navegador para finalizar a configuração do OCS Inventory Server, recomendo o Firefox acessando a URL: http://ENDEREÇO_IP_DO_SERVIDOR/ocsreports;<br><br>
12: Finalize a instalação e criação da base de dados via navegador, utilizando o usuário: "root", senha: "123456", base de dados padrão do OCS Inventory: "ocsweb", servidor: "localhost", usuário de administração do OCS Reports padrão e: "admin" com senha: "admin";<br><br>
13: Após a configuração do OSC Inventory Server, execute o arquivo: <b>04-pos_ocs_server.sh</b> utilizando o comando: <b>./04-pos_ocs_server.sh</b>;<br><br>
14: Siga as instruções que serão apresentadas na tela;<br><br>
15: Após a pós-configuração do OCS Inventory Server, instale o OCS Inventory Agent, execute o arquivo: <b>05-ocs_agent.sh</b> utilizando o comando: <b>./05-ocs_agent.sh</b>;<br><br>
16: Após a reinicialização, utilize um navegador, recomendo o Firefox acessando a URL: http://ENDEREÇO_IP_DO_SERVIDOR/ocsreports;<br><br>
17: Verifique se foi adicionado um novo computador na base de dados do OCS Inventory Server;<br><br>
18: Atualize as informações do OCS Inventory Agent digitando o comando: <b>ocsinventory-agent</b>;<br><br>
19: Após a configuração do OCS Inventory Agent, instale o GLPI Help Desk, execute o arquivo: <b>06-glpi.sh</b> utilizando o comando: <b>./06-glpi.sh</b>;<br><br>
20: Após a reinicialização, utilize um navegador, recomendo o Firefox acessando a URL: http://ENDEREÇO_IP_DO_SERVIDOR/glpi;<br><br>
21: Finalize a instalação e criação da base de dados do GLPI Help Desk via navegador;<br><br>
22: Configure o Plugin do OCS Inventory Server no GLPI Help Desk;<br><br>
23: Após a configuração do Plugin do OCS Inventory Agent no GLPI Help Desk, instale o Netdata Monitor, execute o arquivo: <b>07-netdata.sh</b> utilizando o comando: <b>./07-netdata.sh</b>;<br><br>
24: Após a reinicialização, verifique o desempenho do servidor acessando o Netdata, utilize um navegador, recomendo o Firefox acessando a URL: http://SEU_ENDEREÇO_IP:19999;<br><br>

Sucesso sempre, Bora para Prática.<br>
Robson Vaamonde<br>
http://www.facebook.com/procedimentosemti<br>
http://ww.facebook.com/boraparapratica<br>
http://www.youtube.com/boraparapratica<br>
http://www.aulaead.com/
