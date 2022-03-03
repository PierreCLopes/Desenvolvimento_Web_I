<?php

class Ul {
    
    private $props = array();
    private $class;

    public function __construct($class) {
        $this->class = $class;
    }

    public function addProp($sAtributo) {
        $this->props[] = $sAtributo;
    }

    public function __toString() {
        $sUl = '<ul class="'.$this->class.'">';
        foreach ($this->props as $valor) {
            $sUl .= $valor;
        }
        $sUl .= "</ul>\n";
        return $sUl;
    }
}