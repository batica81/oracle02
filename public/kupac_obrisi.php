<?php 
require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

    $db = new DbAccess;
 
  
        $SIFRAKUPCA = $_GET['id_za_brisanje'];


   $db->database->delete("KUPAC", ["SIFRAKUPCA" => $SIFRAKUPCA]);

   header('Location: ' . $_SERVER['HTTP_REFERER']);
exit;

