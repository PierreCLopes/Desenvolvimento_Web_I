<?php

class Html
{
    private $language;
    private $props    = array();

    public function __construct($language)
    {
        $this->language   = $language;
    }

    public function addProp($array) 
    {
        $this->props[] = $array;
    }

    public function __toString()
    {
        $html = '<!doctype html>';
        $html = '<html lang="'.$this->language.'">';

        foreach ($this->props as $valor) {
            $html .= $valor;
        }
        
        $html .= "</html>";

        return $html;
    }

}