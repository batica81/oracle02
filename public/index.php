<?php
if (!isset($_SERVER['PHP_AUTH_PW']) || (($_SERVER['PHP_AUTH_PW'] != 'sifra123'))) {
    header('HTTP/1.1 401 Unauthorized');
    header('WWW-Authenticate: Basic realm="Kamera"');
    exit('<h3>Kamera</h3>Sorry, you need proper credentials.');
} 
?>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/starter.css">
    <link rel="stylesheet" type="text/css" href="css/styles.css">
 
    <script src="js/jquery-2.2.2.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src='js/tablesorter.min.js'></script> 
    <script src="js/index.js"></script>

<?php 

error_reporting(0); 

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

 
if (isset($_POST) && (!empty($_POST['imekupca'])) ) {

    $last_user_id = $database->insert("KUPAC", [
        "IMEKUPCA" => $_POST['imekupca'],
        "ADRESA" => $_POST['adresa'],
        "PIB" => $_POST['pib'],
        "BRTEL" => $_POST['brtel'],
        "EMAIL" => $_POST['email']
    ]);
}

?>



<div class="container">
    <div class="row centered-form">
        <div class="col-xs-12 col-sm-8 col-md-4 col-sm-offset-2 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Dodajte novog kupca</h3>
                </div>
                <div class="panel-body">
                    <form action="" method="post" role="form">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <div class="form-group">
                                    <input type="text" name="imekupca" id="imekupca" class="form-control input-sm" placeholder="imekupca">
                                </div>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <div class="form-group">
                                    <input type="text" name="adresa" id="adresa" class="form-control input-sm" placeholder="adresa">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <input type="email" name="email" id="email" class="form-control input-sm" placeholder="Email Address">
                        </div>

                        <div class="row">
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <div class="form-group">
                                    <input type="text" name="pib" id="pib" class="form-control input-sm" placeholder="pib">
                                </div>
                            </div>
                     
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <div class="form-group">
                                    <input type="text" name="brtel" id="brtel" class="form-control input-sm" placeholder="brtel">
                                </div>
                            </div>
                        </div>
               
               <input type="submit" value="Dodaj" class="btn btn-info btn-block">

                    </form>
                </div>
            </div>
        </div>
    </div>

    <table id='myTable' border='1' class='tablesorter table table-striped'></table>
</div>

    <script>
            $.getJSON('https://tor64.duckdns.org/oracle02/public/get_kupac.php', function(jsondata) {Tablify(jsondata);});
    </script>
