<?php

class Nav
{
    private $props = array();
    private $class;

    public function __construct($class = '')
    {
        $this->class = $class;
    }

    public function addProp($array) 
    {
        $this->lista[] = $array;
    }

    public function __toString()
    {
        $nav = '<nav class="'.$this->class.'">';

        foreach ($this->props as $valor) {
            $nav .= $valor;
        }
        
        $nav .= "</nav>";

        return $nav;
    }

}