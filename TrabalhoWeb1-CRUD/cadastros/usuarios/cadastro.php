<?php
    session_start();
    include '../../bibliotecas/parametros.php';
    include '../../bibliotecas/conexao.php';
    include LAYOUTS.'header.php';
    if (isset($_POST['gravar'])) {
        if($_POST['senha'] !== $_POST['confirmarsenha']){
            ?>
            <div class="alert alert-danger" role="alert">
                A senha e a confirmação devem ser iguais!
            </div>   
            <?php
        }else{
            $SenhaHash = password_hash($_POST['senha'], PASSWORD_DEFAULT);
            try {
                $stmt = $conn->prepare(
                    'INSERT INTO usuarios (nome,login,email,password) values (:nome,:login,:email,:senha)');
                //$stmt->bindParam(':id', $id, PDO::PARAM_INT);
                $stmt->execute(array('nome' => $_POST['nome'], 'login' => $_POST['login'], 'email' => $_POST['email'], 'senha' => $SenhaHash));
                //$stmt->execute();
                header('Location: ../../index.php');
            } catch(PDOException $e) {
                echo 'ERROR: ' . $e->getMessage();
            }
        }
    }
?>
<form method="post">
    <div class="form-group">
        <label for="nome">Nome</label>
        <input type="text" class="form-control" name="nome" id="nome" placeholder="Nome" required>

        <label for="login">Login</label>
        <input type="text" class="form-control" name="login" id="login" placeholder="Login" required>

        <label for="email">Email</label>
        <input type="text" class="form-control" name="email" id="email" placeholder="Email" required>

        <label for="senha">Senha</label>
        <input type="password" class="form-control" name="senha" id="senha" placeholder="Senha" required>

        <label for="confirmarsenha">Confirmar senha</label>
        <input type="password" class="form-control" name="confirmarsenha" id="confirmarsenha" placeholder="Confirmar senha" required>
    </div>
    <input type="submit" name="gravar" value="Gravar" class="btn btn-success">
</form>
<?php
    include LAYOUTS.'footer.php'; 
?>
