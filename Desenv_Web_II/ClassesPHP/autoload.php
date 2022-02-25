<?php   
spl_autoload_register(function($className) {
    $file = $_SERVER["DOCUMENT_ROOT"] . '/SistemasInformacao_UNIDAVI/Desenv_Web_II/ClassesPHP/lib/' . $className . '.class.php';
    
    if (file_exists($file)) {
        require $file;
    }
}); 