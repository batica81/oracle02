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

 
if (isset($_POST) && (!empty($_POST['SIFRAKUPCA'])) ) {

    $last_user_id = $database->insert("PONUDA", [
        "SIFRAKUPCA" => $_POST['SIFRAKUPCA'],
        "SIFRAUPITA" => $_POST['SIFRAUPITA']
    ]);
}

?>



<div class="container">
    <div class="row centered-form">
        <div class="col-xs-12 col-sm-8 col-md-4 col-sm-offset-2 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Kreirajte novu ponudu</h3>
                </div>
                <div class="panel-body">
                    <form action="" method="post" role="form">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 col-md-6">
                            <div class="form-group">
                                  <label class="control-label" for="selectbasic">Izaberi Kupca</label>
                                  <div class="">
                                    <select id="selectbasic" name="SIFRAKUPCA" class="form-control">

                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6">
                            <div class="form-group">
                              <div class="col-md-4">
                                <button id="singlebutton" name="singlebutton" class="btn btn-success">Dodaj</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</div>
<table id='myTable' border='1' class='tablesorter table table-striped'></table>
</div>


<script>

    $.getJSON('https://tor64.duckdns.org/oracle02/public/get_ponuda.php', function(jsondata) {Tablify(jsondata);});

    $.getJSON('https://tor64.duckdns.org/oracle02/public/get_kupac.php', function(jsondata) {Populate_option(jsondata);});

</script>

