<?php
    $host = 'localhost';
    $user = 'root';
    $pass = '';
    $dbname = 'system';
    $port = 3306;

    try{
        $conn = new PDO("mysql:host=$host;port=$port;dbname=" . $dbname, $user, $pass);
       // echo "Conexão realizada com sucesso";
    }catch(PDOException $erro){
       // echo "Erro: Conexão com banco de dados não realizado com sucesso. Erro gerado " . $erro->getMessage();
    }
?>