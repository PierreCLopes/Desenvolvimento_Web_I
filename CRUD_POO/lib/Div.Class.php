<?php

class Div
{
    private $props = array();
    private $class;

    public function __construct($class = '', ...$array)
    {
        $this->class = $class;
        $this->props = array_merge($this->props, $array);
    }

    public function addProp(...$array) 
    {
        $this->props = array_merge($this->props, $array);
    }

    public function __toString()
    {
        $div = '<div class="'.$this->class.'">';

        foreach ($this->props as $valor) {
            $div .= $valor;
        }
        
        $div .= "</div>";

        return $div;
    }

}