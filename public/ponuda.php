<?php
require_once 'header.php';
?>

<?php 

require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

if (isset($_POST) && (!empty($_POST['SIFRAKUPCA'])) ) {

    $db = new DbAccess;
    $last_user_id = $db->database->insert("PONUDA", [
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
                        <div class="form-group">
                                  <label class="control-label" for="selectbasic">Izaberi Kupca</label>
                                    <select id="selectbasic" name="SIFRAKUPCA" class="form-control">

                                    </select>
                        </div>
                        <button id="singlebutton" name="singlebutton" class="btn btn-success">Dodaj ponudu</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <table id='myTable' border='1' class='tablesorter table table-striped'></table>
</div>

<script>
    $.getJSON('get_ponuda.php', function(jsondata) {Tablify(jsondata);});
    $.getJSON('get_kupac.php', function(jsondata) {Populate_option(jsondata,'SIFRAKUPCA', 'IMEKUPCA');});
</script>

<?php 
require_once 'footer.php';
?>