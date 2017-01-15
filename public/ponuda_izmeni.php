<?php 
require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

    $db = new DbAccess;
 
        $SIFRAKUPCA = $_POST['value'];
        $BRPONUDE = $_POST['pk'];


   $db->database->update("PONUDA", [
	"SIFRAKUPCA" => $SIFRAKUPCA], 
	["BRPONUDE" => $BRPONUDE]);
