<?php

class Head
{
    private $props = array();

    public function addProp(...$array) 
    {
        $this->props = array_merge($this->props, $array);
    }

    public function __toString()
    {
        $head = '<head>';

        foreach ($this->props as $valor) {
            $head .= $valor;
        }
        
        $head .= "</head>";

        return $head;
    }

}