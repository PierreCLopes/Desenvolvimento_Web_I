<?php

class Body
{
    private $props = array();
    private $class;

    public function __construct($class = '')
    {
        $this->class = $class;
    }

    public function addProp(...$array) 
    {
        $this->props = array_merge($this->props, $array);
    }

    public function __toString()
    {
        $body = '<body class="'.$this->class.'">';

        foreach ($this->props as $valor) {
            $body .= $valor;
        }
        
        $body .= "</body>";

        return $body;
    }

}