<?php
    function operar($n1,$n2,$operacao){
        if($operacao == 'sub'){
            return  $n1 - $n2;

        }else if($operacao == 'adi'){
            return  $n1 + $n2;

        }else if($operacao == 'div'){
            return  $n1 / $n2;

        }else if($operacao == 'mult'){
            return $n1 * $n2;

        }
    }
?>