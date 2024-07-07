1. Instalação do MySQL Shell

Windows

Baixe o MySQL Shell do site oficial do MySQL.

Execute o instalador e siga as instruções na tela.

Linux

sudo apt-get update sudo apt-get install mysql-shell

macOS

Baixe o MySQL Shell do site oficial do MySQL.

Extraia o arquivo baixado e siga as instruções de instalação.

 

2. Inicialização do MySQL Shell

Para iniciar o MySQL Shell, abra seu terminal ou prompt de comando e digite:

![image](https://github.com/caiakos/CC1/assets/104407618/21694065-a99a-4c9d-bc39-0f23abe73f69)

Você verá uma interface interativa onde pode começar a digitar comandos.

 

3. Modos de Operação

O MySQL Shell suporta três modos:

SQL Mode (\sql): Para executar comandos SQL.

JavaScript Mode (\js): Para executar comandos e scripts JavaScript.

Python Mode (\py): Para executar comandos e scripts Python.

 

Mudando o Modo

Você pode mudar entre modos usando os seguintes comandos:

Para SQL Mode: \sql

Para JavaScript Mode: \js

Para Python Mode: \py

 

4. Conexão ao Servidor MySQL

Para conectar ao servidor MySQL, use o comando \connect ou \c seguido das credenciais de conexão.

Conexão com Senha

Se o seu servidor MySQL requer uma senha, você pode fornecê-la diretamente no comando de conexão ou ser solicitado a inseri-la após o comando. Veja os exemplos abaixo:

Conexão Básica

\connect user@hostname:3306

Este comando solicitará que você insira a senha:

Password: ****

![image](https://github.com/caiakos/CC1/assets/104407618/4c7b743d-92bc-4f44-b805-a1b0193328a4)

Conexão com Senha no Comando

Para fornecer a senha diretamente no comando, use o formato abaixo. Atenção: este método não é seguro porque a senha ficará visível no histórico do shell.

\connect user:password@hostname:3306

![image](https://github.com/caiakos/CC1/assets/104407618/0f7567dd-77ab-4b9d-958b-1d9addda4c5b)

Conectar-se a um servidor local:

\connect root@localhost:3306

Conectar-se a um servidor remoto:

\connect user@192.168.1.100:3306

Conectar-se com senha fornecida diretamente:

\connect user:mysecretpassword@192.168.1.100:3306

 

5. Comandos Básicos

SQL Mode

·         Listar bancos de dados: SHOW DATABASES;

 ![image](https://github.com/caiakos/CC1/assets/104407618/5d50d71a-82d4-44b7-bbe8-a4a6930979e2)

·         Usar um banco de dados: USE database_name;

![image](https://github.com/caiakos/CC1/assets/104407618/ed0803a6-4fac-4d04-8ed5-3b85c0738d3d)


·         Listar tabelas: SHOW TABLES;

![image](https://github.com/caiakos/CC1/assets/104407618/694045fe-294a-49e6-b935-5e07e14713bd)

·         Descrever a estrutura de uma tabela: DESC table_name;

![image](https://github.com/caiakos/CC1/assets/104407618/416734ba-b7c0-490b-a798-f81651de7e6e)

·         Executar uma consulta: SELECT * FROM table_name;

![image](https://github.com/caiakos/CC1/assets/104407618/d3e4bfad-ea05-4f64-ae28-faf324785460)

JavaScript Mode

·         Executar uma consulta:

var result = shell.execute('SELECT * FROM table_name');

print(result);

·         Inserir dados:

shell.execute('INSERT INTO table_name (column1, column2) VALUES ("value1", "value2")');

Python Mode

·         Executar uma consulta:

result = shell.execute('SELECT * FROM table_name') print(result)

·         Inserir dados:

shell.execute('INSERT INTO table_name (column1, column2) VALUES ("value1", "value2")')



6. Trabalhando com Scripts

Você pode executar scripts externos de JavaScript e Python diretamente no MySQL Shell.



Executando um Script JavaScript

Salve seu script em um arquivo, por exemplo, script.js:

var result = shell.execute('SELECT * FROM table_name'); print(result);

Para executar o script:

\source /caminho/para/seu/script.js

 

Executando um Script Python

Salve seu script em um arquivo, por exemplo, script.py:

result = shell.execute('SELECT * FROM table_name') print(result)

Para executar o script:

\source /caminho/para/seu/script.py

 

7. Administração do MySQL InnoDB Cluster (Javascript)

Criando um Cluster

dba.createCluster('myCluster');

Adicionando um Nó ao Cluster

var cluster = dba.getCluster('myCluster'); cluster.addInstance('user@hostname:3306');

Verificando o Status do Cluster

var cluster = dba.getCluster('myCluster'); print(cluster.status());

 

8. Integração com MySQL Router

Inicializando o MySQL Router

mysqlrouter --bootstrap user@hostname:3306 --user=mysqlrouter

Configurando o MySQL Router

mysqlrouter --config /caminho/para/mysqlrouter.conf

 

9. Referências e Recursos Adicionais

Documentação Oficial do MySQL Shell: https://dev.mysql.com/doc/mysql-shell/8.4/en/

Tutoriais MySQL: https://dev.mysql.com/doc/index-other.html

Repositório GitHub do MySQL Shell: https://github.com/mysql/mysql-shell
