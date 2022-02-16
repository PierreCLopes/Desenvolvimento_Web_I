<?php
    if(!isset($_SESSION['UsuarioNome'])){
        session_start();
    }
    if(!isset($_SESSION['UsuarioNome'])){
        header('Location: login.php');    
    }
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="sistema.css">
    <title>Document</title>
</head>
<body>
    <?php 
        require_once 'processar.php';
    ?>
    <?php
        require_once 'listar.php';
    ?>
    <center>
    <form action="processar.php" method="POST" class="form-box textbox">
        <h2><?php echo $MsgForm;?></h2>
        <?php
            if(isset($_SESSION['MsgErro'])){
                echo '<h3 class="erro">'.$_SESSION['MsgErro'].'</h3>';
                unset($_SESSION['MsgErro']);
            }
            if(isset($_SESSION['MsgSucesso'])){
                echo '<h3 class="sucesso">'.$_SESSION['MsgSucesso'].'</h3>';
                unset($_SESSION['MsgSucesso']);
            }
        ?>
        <input type="hidden" name="id" value="<?php echo $Id;?>">
        <label for="valor">Nome: </label>
        <input type="text" name="nome" value="<?php echo $Nome?>" placeholder="" required>
        <br>
        <label for="valor">Marca: </label>
        <input type="text" name="marca" value="<?php echo $Marca?>" placeholder="" required>
        <br>
        <label for="valor">Valor: </label>
        <input type="number" min="1" step="any" name="valor" value="<?php echo $Valor?>" placeholder="" required>
        <br>
        <label for="estoque">Estoque: </label>
        <input type="number" name="estoque" value="<?php echo $Estoque?>" placeholder="" required>
        <br>
        <br>
        <?php
            if($Update){
                echo '<button type="submit" name="update" class="salvar">Atualizar</button>';    
            }else{
                echo '<button type="submit" name="salvar"  class="salvar">Salvar</button>';
            }
        ?>
    </form>
    </center>
    <button name="desconectar" class="desconectar"><a href="index.php?desconectar=true">Desconectar</a></button>
</body>
</html>