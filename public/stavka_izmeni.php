<?php 
require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

    $db = new DbAccess;
 
        $KOLICINA = $_POST['value'];
        $RBR = $_POST['pk'];
        $BRPONUDE = $_POST['name'];

if ($KOLICINA > 0) {


	$sql_query = "UPDATE STAVKAPONUDE SET KOLICINA=".$KOLICINA." WHERE (BRPONUDE=".$BRPONUDE." AND RBR=".$RBR.")";

	$db->database->query($sql_query);
}


