<?php
require_once 'header.php';
?>

<?php 

require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

if (isset($_POST) && (!empty($_POST['NAZIVARTIKLA'])) ) {

    $db = new DbAccess;
    $last_user_id = $db->database->insert("ARTIKAL", [
        "NAZIVARTIKLA" => $_POST['NAZIVARTIKLA'],
        "OPISARTIKLA" => $_POST['OPISARTIKLA'],
        "JEDMERE" => $_POST['JEDMERE']
    ]);
}

?>

<div class="container">
    <div class="row centered-form">
        <div class="col-xs-12 col-sm-8 col-md-4 col-sm-offset-2 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Dodajte novi artikal</h3>
                </div>
                <div class="panel-body">
                    <form action="" method="post" role="form">
                        <div class="form-group">
                            <input type="text" name="NAZIVARTIKLA" id="NAZIVARTIKLA" class="form-control input-sm" placeholder="NAZIVARTIKLA">
                        </div>
                        <div class="form-group">
                            <input type="text" name="OPISARTIKLA" id="OPISARTIKLA" class="form-control input-sm" placeholder="OPISARTIKLA">
                        </div>
                        <div class="form-group">
                            <input type="text" name="JEDMERE" id="JEDMERE" class="form-control input-sm" placeholder="JEDMERE">
                        </div>     
                        <input type="submit" value="Dodaj artikal" class="btn btn-info btn-block">
                    </form>
                </div>
            </div>
        </div>
    </div>
    <table id='myTable' border='1' class='tablesorter table table-striped'></table>
</div>

<script>
        $.getJSON('get_artikal.php', function(jsondata) {Tablify(jsondata);});
</script>

<?php 
require_once 'footer.php';
?>