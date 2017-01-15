<?php
require_once 'header.php';
?>

<?php 

require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

if (isset($_POST) && (!empty($_POST['SIFRAARTIKLA'])) ) {

    $db = new DbAccess;
    $last_user_id = $db->database->insert("CENA", [
        "CENA" => $_POST['CENA'],
        "STOPAPDV" => $_POST['STOPAPDV'],
        "SIFRAARTIKLA" => $_POST['SIFRAARTIKLA']
    ]);
}

?>

<div class="container">
    <div class="row centered-form">
        <div class="col-xs-12 col-sm-8 col-md-4 col-sm-offset-2 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Dodajte novu cenu</h3>
                </div>
                <div class="panel-body">
                    <form action="" method="post" role="form">
                        <div class="form-group">
                            <label class="control-label" for="selectbasic">Izaberi artikal</label>
                            <select id="selectbasic" name="SIFRAARTIKLA" class="form-control">

                            </select>
                        </div>
                        <div class="form-group">
                            <input type="text" name="CENA" id="CENA" class="form-control input-sm" placeholder="CENA">
                        </div>
                        <div class="form-group">
                            <input type="text" name="STOPAPDV" id="STOPAPDV" class="form-control input-sm" placeholder="STOPAPDV">
                        </div>     
                        <input type="submit" value="Dodaj cenu" class="btn btn-info btn-block">
                    </form>
                </div>
            </div>
        </div>
    </div>
    <table id='myTable' border='1' class='tablesorter table table-striped'></table>
</div>

<script>
        $.getJSON('get_cena.php', function(jsondata) {Tablify(jsondata, '#myTable');});
        $.getJSON('get_artikal.php', function(jsondata) {Populate_option(jsondata, 'SIFRAARTIKLA', 'NAZIVARTIKLA', '#selectbasic');});
</script>

<?php 
require_once 'footer.php';
?>