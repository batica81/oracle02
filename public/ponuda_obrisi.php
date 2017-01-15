<?php 
require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

    $db = new DbAccess;
 
  
        $BRPONUDE = $_GET['id_za_brisanje'];


   $db->database->delete("PONUDA", ["BRPONUDE" => $BRPONUDE]);

   header('Location: ' . $_SERVER['HTTP_REFERER']);
exit;

