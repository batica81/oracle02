<?php 
header('Content-Type: application/json');

require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

$db = new DbAccess;
$datas = $db->database->select("STAVKAPONUDE", ["RBR", "BRPONUDE", "KOLICINA", "SIFRAARTIKLA"], ["BRPONUDE" => $_POST['BRPONUDE']]);

echo json_encode($datas);