<!DOCTYPE html>
<html lang="pt-br">
  <head>
    <title>Login</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="loginstyle.css">
  </head>
  <body> 
    <?php
        session_start();
        include 'bibliotecas/parametros.php';
        include 'bibliotecas/conexao.php';

        $dados = filter_input_array(INPUT_POST, FILTER_DEFAULT);

        if(!empty($dados['login'])){
            //var_dump($dados);

            $QueryLogin = "SELECT id,
                                  login,
                                  password,
                                  nome
                             FROM usuarios 
                            WHERE login = :login ";
            $ResultLogin = $conn->prepare($QueryLogin);
            $ResultLogin->bindParam(':login',$dados['username'],PDO::PARAM_STR);
            $ResultLogin->execute();

            if (($ResultLogin) and ($ResultLogin->rowCount() != 0)){
                $RowUsuario = $ResultLogin->fetch(PDO::FETCH_ASSOC);
                //var_dump($RowUsuario);
                if(password_verify($dados['password'],$RowUsuario['password'])){
                    $_SESSION['UsuarioNome'] = $RowUsuario['nome'];
                    $_SESSION['UsuarioLogin'] = $RowUsuario['login'];
                    $_SESSION['UsuarioPassword'] = $RowUsuario['password'];
                    $_SESSION['UsuarioId'] = $RowUsuario['id'];
                    header('Location: index.php'); 
                   // var_dump($_SESSION);
                }else{
                    $_SESSION['MsgLogin'] = "Erro: Usuário ou senha inválidos!";
                }
            }else{
                $_SESSION['MsgLogin'] = "Erro: Usuário ou senha inválidos!";
            }
            
        }
        if(isset($_POST['registrar'])){
            header('Location: cadastros/usuarios/cadastro.php');
        }else{
    ?>
    
    <form action="" class="login-box" method="post" >
        <?php
            if (isset($_SESSION['MsgLogin'])){
                echo '<h3 class="MsgErro">'.$_SESSION['MsgLogin'].'</h3>';
                unset($_SESSION['MsgLogin']);
            }
        ?>
        <h1>Login</h1>
        <section class="textbox">
            <input name="username" type="text" placeholder="Username" value="">
        </section>

        <section class="textbox">
            <input name="password" type="password" placeholder="Password" value="">
        </section>
        
        <input type="submit" value="Login" name="login" class="login">
        <input type="submit" value="Registrar" name="registrar" class="login">
    </form>
    </body>
</html>
<?php
    }