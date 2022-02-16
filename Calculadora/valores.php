<?php
    session_start();
    if (!isset($_SESSION['primeiro'])){
        $_SESSION['primeiro'] = $_GET['numero'];  
        $_SESSION['valor'] = '';
        $_SESSION['operacao'] = $_GET['operacao']; 
    }else{
        $_SESSION['segundo'] = $_GET['numero']; 
        $_SESSION['valor'] = '';
    }

    header('Location: index.php');
    
?>