# CRUD_PHP

-Esse CRUD é um trabalho do curso de Sistemas de Informação, materia de Desenvolvimento Web I na UNIDAVI;

-O CRUD consiste em uma aplicação conectada com banco de dados MySQL, onde irá Criar, Ler, Alterar e Excluir registros da tabela de produtos;

-Também está implementado um sistema de login com sessão, onde é verificado o usuário no Banco de dados, portanto antes de testar o sistema é necessário criar uma usuário no Banco;



#OBS:
-Para utilizar a aplicação é necessário de um banco de dados com nome "system";
-Nele devem existir duas tabelas:
--uma com nome "produto", contendo as colunas "id"(PK,Int,Auto Increment), "nome"(varchar), "marca"(varchar), "estoque"(int), "valor"(decimal 15,2), "valorestoque"(decimal 15,2), "criador"(Int, FK da tabela usuarios(id));
--outra tabela com nome "usuarios", contendo as colunas "id"(PK,Int,Auto Increment), "nome"(varchar), "login"(varchar), "password"(varchar);

-Qualquer necessidade de alteração na conexão com o Banco de dados deve ser feito no arquivo conexao.php;