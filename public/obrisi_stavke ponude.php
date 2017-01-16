<?php 
require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

    $db = new DbAccess;
 
  
        $RBR = $_GET['id_za_brisanje'];
        $BRPONUDE = $_GET['id_ponude'];

        $db->database->delete("STAVKAPONUDE", [
			"AND" => [
				"RBR" => $RBR,
				"BRPONUDE" => $BRPONUDE
			]
		]);

header('Location: ' . $_SERVER['HTTP_REFERER']);
exit;
