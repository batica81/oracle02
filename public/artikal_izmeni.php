<?php 
require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

    $db = new DbAccess;
 
        $NAZIVARTIKLA = $_POST['value'];
        $SIFRAARTIKLA = $_POST['pk'];

   //  $sql_query = "UPDATE KUPAC SET IMEKUPCA='.$IMEKUPCA.' WHERE SIFRAKUPCA='.$SIFRAKUPCA.';";

   // $db->database->query($sql_query);


   $db->database->update("ARTIKAL_VIEW", [
	"NAZIVARTIKLA" => $NAZIVARTIKLA], 
	["SIFRAARTIKLA" => $SIFRAARTIKLA]);

