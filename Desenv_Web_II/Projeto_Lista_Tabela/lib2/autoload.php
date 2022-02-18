<?php   
spl_autoload_register(function($className) {
    $file = 'lib2/' . $className . '.class.php';
    if (file_exists($file)) {
        require_once $file;
    }
});