<?php 
require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

    $db = new DbAccess;
 
  
        $SIFRAARTIKLA = $_GET['id_za_brisanje'];


   $db->database->delete("ARTIKAL_VIEW", ["SIFRAARTIKLA" => $SIFRAARTIKLA]);

   header('Location: ' . $_SERVER['HTTP_REFERER']);
exit;

