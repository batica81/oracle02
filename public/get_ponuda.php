<?php 
header('Content-Type: application/json');

require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

$db = new DbAccess;
$datas = $db->database->select("PONUDA", "*");

echo json_encode($datas);