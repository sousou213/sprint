<?php

require_once('controleur/controleur.php');

try {
    if (isset($_POST['recuperer']) and !empty(['name']) and !empty(['date'])){
        $nom=$_POST['name'];
        $date=$_POST['date'];
        CtlRecupNss($nom, $date);
    }
    else {
        throw new Exception('ntm');
    }
}
catch(Exception $e) {
   $msg=$e->getMessage();
   CtlErreur($msg);
}