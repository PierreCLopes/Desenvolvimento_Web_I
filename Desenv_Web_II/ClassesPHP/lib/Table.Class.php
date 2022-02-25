<?php

class Table{
    private $LinePage;
    private $Tr = array();
    private $Th = array();
    private $Td;
    private $Class;

    function __construct($vLinePage,  $vClass){
        $this->LinePage = $vLinePage;
        $this->Class = $vClass;
    }

    function addTh(array $vTh){
        $this->Th = array_merge($this->Th, $vTh);
    }

    function addTr(array $vTr){
        $this->Tr = array_merge($this->Tr, $vTr);
    }



    function __toString(){
        $Result = '<table border="1" ';
        if(!is_null($this->Class) && !empty($this->Class)){
            $Result .= 'class= "' . $this->Class . '"';
        }
        $Result .= '>';
        
        if(!empty($this->Th)){
            foreach($this->Th as $vTh){
                $Result .= '<th>' . $vTh . '</th>';
            }
        }
        
        if(!empty($this->Tr)){
            foreach($this->Tr as $vTr){
                $Result .= '<tr>';
                foreach($this->Th as $vTh){
                    $Result .= '<td>' . $vTr[$vTh] . '</td>';
                };
                $Result .= '</tr>';
            }
        }
        $Result .= '</table>';

        return $Result;
    }

}