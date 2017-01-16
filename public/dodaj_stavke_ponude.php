<?php 

require '../vendor/autoload.php';
require_once 'dbaccess_class.php';



$db = new DbAccess;

    $last_user_id = $db->database->insert("STAVKAPONUDE", [
        "BRPONUDE" => $_POST['BRPONUDE'],
        // "RBR" => $_POST['RBR'],
        "KOLICINA" => $_POST['KOLICINA'],
        "SIFRAARTIKLA" => $_POST['SIFRAARTIKLA']
    ]);


header('Location: ' . $_SERVER['HTTP_REFERER']);
exit;