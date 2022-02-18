<?php

class li{
    private $css;
    private $conteudo;

    function __construct($class, $conteudo){
        $this->css = $class;
        $this->conteudo = $conteudo;
    }

    function __toString(){
        return "<li class=\"{$this->css}\">{$this->conteudo}</li>";
    }
}