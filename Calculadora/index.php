<?php
    session_start();
    if(!isset($_SESSION['SessaoIniciada'])){
       // session_start();
        $_SESSION['SessaoIniciada'] = true;
    }
    if(isset($_GET['destroy'])){
        session_destroy();
    }
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Calculadora</title>
</head>
<body>
    <?php
       include_once 'gambi.php';
       if(isset($_SESSION['primeiro'])){
           echo '<h2> primeiro valor: '. $_SESSION['primeiro'] . '</h2>';

       }
       if(isset($_SESSION['segundo'])){
        echo '<h2> segundo valor: '. $_SESSION['segundo'] . '</h2>';

    }
    if(isset($_SESSION['resultado'])){
        echo '<h1> Resultado: '. $_SESSION['resultado'] . '</h1>';

    }
     // var_dump($_SESSION['valor']);
     // var_dump($_SESSION['primeiro']);
     // var_dump($_SESSION['segundo']);
       if (isset($_GET['number'])){
           $_SESSION['valor'] = $_SESSION['valor'] . $_GET['number'];

       }
       if((isset($_SESSION['primeiro'])) and (isset($_SESSION['segundo']))){
            $_SESSION['resultado'] = operar((int)$_SESSION['primeiro'],(int)$_SESSION['segundo'],$_SESSION['operacao']);

       }
    ?>
    <table>
        <thead>
            
        </thead>
        <tr>
            <td><button class="number" name="sete"><a href="index.php?number=7">7</a></button></td>
            <td><button class="number" name="sete"><a href="index.php?number=8">8</a></button></td>
            <td><button class="number" name="sete"><a href="index.php?number=9">9</a></button></td>
            <td><button class="operator" name="divisao"><a href="valores.php?operacao=div&numero=<?php echo $_SESSION['valor']; ?>">%</a></button></td>
        </tr>
        <tr>
            <td><button class="number" name="sete"><a href="index.php?number=4">4</a></button></td>
            <td><button class="number" name="sete"><a href="index.php?number=5">5</a></button></td>
            <td><button class="number" name="sete"><a href="index.php?number=6">6</a></button></td>
            <td><button class="operator" name="multiplicacao"><a href="valores.php?operacao=mult&numero=<?php echo $_SESSION['valor']; ?>">X</a></button></td>
        </tr>
        <tr>
            <td><button class="number" name="sete"><a href="index.php?number=1">1</a></button></td>
            <td><button class="number" name="sete"><a href="index.php?number=2">2</a></button></td>
            <td><button class="number" name="sete"><a href="index.php?number=3">3</a></button></td>
            <td><button class="operator" name="subtracao"><a href="valores.php?operacao=sub&numero=<?php echo $_SESSION['valor']; ?>">-</a></button></td>
        </tr>
        <tr>
            <td><button class="operador" name="c"><a href="index.php?destroy=true">C</a></button></td>
            <td><button class="number" name="zero"><a href="index.php?number=0">0</a></button></td>
            <td><button class="operator" name="resultado"><a href="valores.php?&numero=<?php echo $_SESSION['valor']; ?>">=</a></button></td>
            <td><button class="operator" name="adicao"><a href="valores.php?operacao=adi&numero=<?php echo $_SESSION['valor']; ?>">+</a></button></td>
        </tr>
    </table>
</body>
</html>