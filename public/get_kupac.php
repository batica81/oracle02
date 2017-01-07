<?php 
header('Content-Type: application/json');

require '../vendor/autoload.php';

$database = new medoo([
    'database_type' => 'oracle',
    'database_name' => '',
    'server' => '127.0.0.1',
    'username' => 'db02',
    'password' => 'qwerty',
    'charset' => 'UTF8',
    'option' => [
        PDO::ATTR_CASE => PDO::CASE_NATURAL
    ]
]);


$datas = $database->select("KUPAC", "*");

echo json_encode($datas);

