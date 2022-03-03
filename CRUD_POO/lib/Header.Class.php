<?php

class Header
{
    private $props = array();

    public function addProp($array) 
    {
        $this->props[] = $array;
    }

    public function __toString()
    {
        $header = '<header>';

        foreach ($this->props as $valor) {
            $header .= $valor;
        }
        
        $header .= "</header>";

        return $header;
    }

}