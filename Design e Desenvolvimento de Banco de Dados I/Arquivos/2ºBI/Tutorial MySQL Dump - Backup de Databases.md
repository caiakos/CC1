1. Exportando Dados com mysqldump

O mysqldump é uma ferramenta de backup fornecida pelo MySQL que permite exportar um banco de dados ou tabelas específicas para um arquivo SQL. Este arquivo pode ser usado para restaurar os dados posteriormente.

Sintaxe Básica

mysqldump -u [usuário] -p [nome_do_banco] > [nome_do_arquivo].sql



Exemplos

Exportar um banco de dados completo (Backup da database):

mysqldump -u root -p meu_banco > meu_banco_dump.sql

Exportar uma tabela específica (Backup do Tabela):

mysqldump -u root -p meu_banco minha_tabela > minha_tabela_dump.sql

Exportar todos os bancos de dados (Backup de todas as databases):

mysqldump -u root -p --all-databases > todos_os_bancos_dump.sql

Exportar com inclusão de procedimentos armazenados e triggers:

mysqldump -u root -p --routines --triggers meu_banco > meu_banco_completo_dump.sql

 

2. Importando Dados com mysql

Para importar os dados de um arquivo SQL para um banco de dados MySQL, você pode usar o comando mysql no terminal.

Sintaxe Básica

mysql -u [usuário] -p [nome_do_banco] < [nome_do_arquivo].sql

 

Exemplos

Importar um banco de dados completo (recuperar uma database):

mysql -u root -p meu_banco < meu_banco_dump.sql

Importar todos os bancos de dados (caso tenha usado --all-databases no dump):

mysql -u root -p < todos_os_bancos_dump.sql

 

3. Backup e Restauração no MySQL Shell

O MySQL Shell oferece funcionalidades adicionais para backup e restauração, especialmente com o MySQL InnoDB Cluster. Vamos ver como usar o MySQL Shell para essas operações.

Backup com MySQL Shell

O MySQL Shell usa a API de Document Store para realizar backups.

Realizando um Backup

Abra o MySQL Shell:
![image](https://github.com/caiakos/CC1/assets/104407618/f6bfcc25-d2c2-4d83-b59d-4748ba3a45db)

Conecte-se ao servidor MySQL:
![image](https://github.com/caiakos/CC1/assets/104407618/37044b5c-b244-4624-b99f-96faf166dc56)

Use a função de exportação de utilitários:
![image](https://github.com/caiakos/CC1/assets/104407618/3c2f8b98-beb5-452f-92d3-5f1b95a0b772)



Restauração com MySQL Shell

Para restaurar um backup usando o MySQL Shell:

Realizando uma Restauração

Abra o MySQL Shell:
![image](https://github.com/caiakos/CC1/assets/104407618/dae54875-b8d6-4621-956b-86926697ef25)

Conecte-se ao servidor MySQL:
![image](https://github.com/caiakos/CC1/assets/104407618/1b23fb0b-b96e-4c28-b796-f9c783d4ff67)

Use a função de importação de utilitários:
![image](https://github.com/caiakos/CC1/assets/104407618/f520a95e-7e01-40d0-b860-c891cae280b4)

Caso apresente o erro:
![image](https://github.com/caiakos/CC1/assets/104407618/9d7aaf00-328f-4652-839a-7989c6f03d60)

Faça as seguintes alterações das configurações:
![image](https://github.com/caiakos/CC1/assets/104407618/ab11af44-3aea-4a81-8854-5c8027c83eee)

Depois volte pro modo JS e execute novamente a importação.

Para fazer essa alteração de forma permanente, você deve editar o arquivo de configuração do MySQL (my.cnf ou my.ini, dependendo do sistema operacional) e adicionar a seguinte linha:

[mysqld]

local_infile = 1

