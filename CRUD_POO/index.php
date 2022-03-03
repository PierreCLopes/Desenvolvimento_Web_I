<?php
    require ('autoload.php');
    $meta = new Meta (['charset' => 'UTF-8', 'viewport' => 'width=device-width, initial-scale=1']);
    $html = new Html ('pt-br');
    $title = new Title ('Anthony');
    $head = new Head ();
    $head->addProp($meta, $title, new LinkCss("https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css","stylesheet", "sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl","anonymous"));
    echo $head;

    $body = new Body ();
    $body->addProp(new Script('https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js', 'sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0', 'anonymous', ''));
    $container = new Div('container');
    $div_row = new Div('row', new Div('col bg-primary', 'Hello World'));
    $div_area = new Div ('row');


    $div_area->addProp(new Menu());
    $mid = new Div('col-sm-10 bg-danger', 'Olha ele D Novo');
    $div_area->addProp($mid);
    $container->addProp($div_row);
    $container->addProp($div_area);

    
    $body->addProp($container);
    
    echo $body;
?>