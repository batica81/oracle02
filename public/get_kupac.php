<?php 
header('Content-Type: application/json');

require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

$db = new DbAccess;
$datas = $db->database->select("KUPAC_VIEW", "*");


// $sql_query = 'SELECT k.SIFRAKUPCA "SIFRAKUPCA",
// k.IMEKUPCA "IMEKUPCA",
// k.DETALJI.get_adresa() "ADRESA",
// k.DETALJI.get_pib() "PIB",
// k.DETALJI.get_brtel() "BRTEL",
// k.DETALJI.get_email() "EMAIL"
// FROM KUPAC k';

// $datas = $db->database->query($sql_query)->fetchAll();

echo json_encode($datas);
