<?php
class LinkCss {

    private $url;
    private $rel;
    private $integrity;
    private $crossorigin;

    public function __construct($vUrl, $vRel, $vIntegrity, $vCrossorigin) {
        $this->url        = $vUrl;
        $this->rel        = $vRel;
        $this->integrity  = $vIntegrity;
        $this->crossorigin = $vCrossorigin;
    }

    public function __toString() {
        return '<link href="'.$this->url.'" rel="'.$this->rel.'" integrity="'.$this->integrity.'" crossorigin="'.$this->crossorigin.'">'."\n";
    }
}