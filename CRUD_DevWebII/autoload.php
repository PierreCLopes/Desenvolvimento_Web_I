<?php
spl_autoload_register(function($class) {
    $file = $_SERVER["DOCUMENT_ROOT"] . '/SistemasInformacao_UNIDAVI/CRUD_DevWebII/libs/' . $class . '.class.php';
 
    if (file_exists($file)) {
        require_once $file;
    }
});