<?php 
header('Content-Type: application/json');

require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

require_once 'connectvars.php';


$db = new DbAccess;
$datas = $db->database->select("DETALJI_KDT", "*");

echo json_encode($datas);




//   //Obican PDO

$db_pdo = 'oci:dbname=//127.0.0.1/;charset=AL32UTF8'; 
$conn = new PDO($db_pdo,DB_USER,DB_PASSWORD);
$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // foreach($conn->query('SELECT * FROM DETALJI_KDT') as $row) {
    //     print_r($row);
    // }

$sql = "INSERT INTO TABLE1 (ID, DETALJI) VALUES (6, DETALJI_KUPCA('NS', 11000, 112254, 'aaa'))";


    $conn->exec($sql);
    echo "New record created successfully";
// try {


// $stmt = $conn->prepare("INSERT INTO TABLE1 VALUES (:value1, :value2)");
// $stmt->bindParam(':value1', $value1);
// $stmt->bindParam(':value2', $value2); 'detalji_kupca(\"NS\", \"11000\", \"112254\", \"aaa\")'


// $value1 = 6;
// $value2 = 7;
// $stmt->execute();

	
// } catch (PDOException $e) {
// 	print "Error!: " . $e->getMessage() . "<br/>";
//     die();
// }



$conn = null;




















// try {


// $stmt = $conn->prepare("INSERT INTO TABLE2 (COLUMN1, COLUMN2) VALUES (:value1, :value2)");
// $stmt->bindParam(':value1', $value1);
// $stmt->bindParam(':value2', $value2);


// $value1 = 'one';
// $value2 = 'two';
// $stmt->execute();

	
// } catch (PDOException $e) {
// 	print "Error!: " . $e->getMessage() . "<br/>";
//     die();
// }
    





