<?php 
header('Content-Type: application/json');

require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

$db = new DbAccess;
// $datas = $db->database->select("STAVKAPONUDE", ["BRPONUDE", "RBR", "KOLICINA", "SIFRAARTIKLA"], ["BRPONUDE" => $_GET['BRPONUDE']]);


$datas = $db->database->select("STAVKA_VIEW", ["BRPONUDE", "RBR", "KOLICINA", "NAZIVARTIKLA"], ["BRPONUDE" => $_GET['BRPONUDE']]);



echo json_encode($datas);