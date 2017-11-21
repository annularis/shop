<?php

class Test extends CI_Controller{
    
    public function index(){
     
        $this->smartie->testInstall();
    }
}