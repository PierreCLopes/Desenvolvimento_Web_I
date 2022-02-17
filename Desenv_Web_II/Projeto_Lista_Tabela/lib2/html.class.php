<?php

class html{
    private $lang;
    private $charset;
    private $title;
    private $conteudo;

    function __construct($lang, $charset, $title, $conteudo){
        $this->lang = $lang;
        $this->charset = $charset;
        $this->title = $title;
        $this->conteudo = $conteudo;
    }

    function __toString(){
        $retorno = '<!DOCTYPE html>
                   <html lang="' . $this->lang . '">';

        $retorno .= '<head>
                        <meta charset="' . $this->charset . '">';

        $retorno .= '<meta http-equiv="X-UA-Compatible" content="IE=edge">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">';

        $retorno .= '<title>' . $this->title . '</title>';

        $retorno .= '</head>
                     <body>' . 
                        $this->conteudo . 
                    '</body>
                     </html>';
        
        return $retorno;
    }
}
