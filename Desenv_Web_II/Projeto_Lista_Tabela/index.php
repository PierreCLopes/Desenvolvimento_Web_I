<?php
include "lib2/li.class.php";
include "lib2/ul.class.php";
include "lib2/html.class.php";
include "lib2/meta.class.php";
include "lib2/title.class.php";
include "lib2/doctype.class.php";
include "lib2/body.class.php";
include "lib2/head.class.php";
//require "lib2/autoload.php"

//$teste = array(new li("","Pierre"), new li("","Pierre"), new li("","Pierre"), new li("","Pierre"));

$doctype = new doctype();
$body = new body("<h1>PIERRE</h1>");
$meta = new meta('charset="UTF-8"');
$meta2 = new meta('http-equiv="X-UA-Compatible" content="IE=edge"');
$meta3 = new meta('name="viewport" content="width=device-width, initial-scale=1.0"');
$title = new title('Pagina');

$html = new html("pr-br",($meta . $meta2 . $meta3 . $title . $body));

echo $doctype;
echo $html;