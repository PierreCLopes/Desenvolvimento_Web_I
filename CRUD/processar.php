<?php
    include_once 'conexao.php';

    if (!isset($_GET['edit'])){
        $Nome = '';
        $Marca = '';
        $Estoque = '';
        $Valor = '';
        $Criador = '';
        $Update = false;
        $Id = 0;
        $MsgForm = 'Adicionar produto';
    }
    if(isset($_POST['salvar'])){
        session_start();

        if((empty($_POST['nome'])) or (empty($_POST['marca'])) or (empty($_POST['valor'])) or (empty($_POST['estoque'])) or (empty($_SESSION['UsuarioId']))){
            $_SESSION['MsgErro'] = 'Erro: Faltam informações para inserir o produto!';   
            header('Location: sistema.php');
        }else{
            $Nome = $_POST['nome'];
            $Marca = $_POST['marca'];
            $Valor = $_POST['valor'];
            $Estoque = $_POST['estoque'];
            $Criador = $_SESSION['UsuarioId'];

            $ValorEstoque = $Valor * $Estoque;
            try{
                $SQL = "INSERT INTO produto (nome, marca, valor, estoque, criador, valorestoque) 
                        VALUES (:nome, :marca, :valor, :estoque, :criador, :valorestoque)";

                $Query = $conn->prepare($SQL);
                $Query->bindParam(':nome', $Nome);
                $Query->bindParam(':valor', $Valor); 
                $Query->bindParam(':estoque', $Estoque); 
                $Query->bindParam(':criador', $Criador); 
                $Query->bindParam(':valorestoque', $ValorEstoque); 
                $Query->bindParam(':marca', $Marca); 

                $Query->execute();

                header('Location: sistema.php');

                $_SESSION['MsgSucesso'] = 'Produto cadastrado com sucesso!';   
            }catch(PDOException $erro){
                $_SESSION['MsgErro'] = "Erro: Não foi possível inserir o registro. Erro gerado " . $erro->getMessage();
                header('Location: sistema.php');
            }
        }
    }

    if(isset($_GET['delete'])){
        session_start();

        $Id = $_GET['delete'];
        try{
            $SQL = "DELETE FROM produto WHERE id = :id";

            $Query = $conn->prepare($SQL);
            $Query->bindParam(':id', $Id);

            $Query->execute();

            $_SESSION['MsgSucesso'] = 'Produto deletado com sucesso!';  
            header('Location: sistema.php');
        }catch(PDOException $erro){
            $_SESSION['MsgErro'] = "Erro: Não foi possível deletar o registro. Erro gerado " . $erro->getMessage();  
            header('Location: sistema.php'); 
        }
    }

    if(isset($_GET['edit'])){
        $Id = $_GET['edit'];
        $Update = true;
        $MsgForm = 'Editar produto';
        try{
            $SQL = "SELECT * FROM produto WHERE id = :id";

            $Query = $conn->prepare($SQL);
            $Query->bindParam(':id', $Id);

            $Query->execute();

            $row = $Query->fetch(PDO::FETCH_ASSOC);

            if(isset($row['id'])){
                $Nome = $row['nome'];
                $Marca = $row['marca'];
                $Estoque = $row['estoque'];
                $Valor = $row['valor'];
                $Criador = $row['criador'];
                $Id = $row['id'];
            }

           // header('Location: sistema.php'); 
        }catch(PDOException $erro){
            $_SESSION['MsgErro'] = "Erro: Não foi possível buscar o registro. Erro gerado " . $erro->getMessage();
            header('Location: sistema.php');   
        }
    }

    if(isset($_POST['update'])){
        session_start();

        $Nome = $_POST['nome'];
        $Marca = $_POST['marca'];
        $Estoque = $_POST['estoque'];
        $Valor = $_POST['valor'];
        $Id = $_POST['id'];

        $ValorEstoque = $Valor * $Estoque;

        try{
            $SQL = "UPDATE produto 
                       SET nome = :nome,
                           valor = :valor,
                           valorestoque = :valorestoque,
                           estoque = :estoque,
                           marca = :marca
                     WHERE id = :id"; 

            $Query = $conn->prepare($SQL);
            $Query->bindParam(':id', $Id);  
            $Query->bindParam(':valor', $Valor); 
            $Query->bindParam(':estoque', $Estoque); 
            $Query->bindParam(':valorestoque', $ValorEstoque); 
            $Query->bindParam(':marca', $Marca); 
            $Query->bindParam(':nome', $Nome); 

            $Query->execute();

            $_SESSION['MsgSucesso'] = 'Produto atualizado com sucesso!'; 
            header('Location: sistema.php');
        }catch(PDOException $erro){
            $_SESSION['MsgErro'] = "Erro: Não foi possível atualizar o registro. Erro gerado " . $erro->getMessage();
            header('Location: sistema.php');
        }
    }
?>