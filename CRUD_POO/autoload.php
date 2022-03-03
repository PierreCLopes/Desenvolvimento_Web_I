<?php
spl_autoload_register(function($class) {
    $arquivo = $_SERVER["DOCUMENT_ROOT"] . '/SistemasInformacao_UNIDAVI/CRUD_POO/lib/' . $class . '.class.php';
 
    if (file_exists($arquivo)) {
        require $arquivo;
    }
});