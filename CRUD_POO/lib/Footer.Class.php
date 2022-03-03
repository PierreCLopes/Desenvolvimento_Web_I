<?php

class Footer
{
    private $props = array();
    private $class;

    public function __construct($class = '')
    {
        $this->class = $class;
    }

    public function addProp($array) 
    {
        $this->props[] = $array;
    }

    public function __toString()
    {
        $footer = '<footer class="'.$this->class.'">';

        foreach ($this->props as $valor) {
            $footer .= $valor;
        }
        
        $footer .= "</footer>";

        return $footer;
    }

}