<?php
    session_start();

    if (isset($_GET['desconectar'])) {
        session_destroy();
        header("Location: index.php");
    }

    if (!isset($_SESSION['UsuarioId'])) {
        include 'login.php';
    } else {
        include 'sistema.php';
    }
?>