<?php
    class Menu{
        public function __toString(){
            $propsMenu = new Ul('list-group');
            $propsMenu->addProp(new Li('list-group-item', '<a class = "nav-link" href= "?action=pessoas"> pessoas</a>'));

            $menu = "" . new Div("col-sm-2",$propsMenu);

		    return $menu;
            
        }
    }
?>