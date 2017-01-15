<?php 
require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

    $db = new DbAccess;
 
        $IMEKUPCA = $_POST['value'];
        $SIFRAKUPCA = $_POST['pk'];

   //  $sql_query = "UPDATE KUPAC SET IMEKUPCA='.$IMEKUPCA.' WHERE SIFRAKUPCA='.$SIFRAKUPCA.';";

   // $db->database->query($sql_query);


   $db->database->update("KUPAC", [
	"IMEKUPCA" => $IMEKUPCA], 
	["SIFRAKUPCA" => $SIFRAKUPCA]);

