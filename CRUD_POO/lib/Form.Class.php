  
<?php

class Form
{
    private $props = array();
    private $class;
    private $method;
    private $action;

    public function __construct($method, $action, $class = '')
    {
        $this->method = $method;
        $this->action = $action;
        $this->class  = $class;
    }

    public function addProp($array) 
    {
        $this->props[] = $array;
    }

    public function __toString()
    {
        $form = '<form class="'.$this->class.'" method="'.$this->method.'" action="'.$this->action.'">';

        foreach ($this->props as $valor) {
            $form .= $valor;
        }
        
        $form .= "</form>";

        return $form;
    }

}