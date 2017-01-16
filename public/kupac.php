<?php
require_once 'header.php';
?>

<?php 

require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

if (isset($_POST) && (!empty($_POST['imekupca'])) ) {

    $db = new DbAccess;
 
        $IMEKUPCA = $_POST['imekupca'];
        $ADRESA = $_POST['adresa'];
        $PIB = $_POST['pib'];
        $BRTEL = $_POST['brtel'];
        $EMAIL = $_POST['email'];
 
    $sql_query = "INSERT INTO KUPAC (IMEKUPCA, DETALJI) VALUES ('".$IMEKUPCA."', DETALJI_KUPCA('".$ADRESA."', '".$PIB."', '".$BRTEL."', '".$EMAIL."'))";

   $db->database->query($sql_query);

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
                                    <input type="text" name="imekupca" id="imekupca" class="form-control input-sm" placeholder="imekupca" required>
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
                                    <input type="number" name="pib" id="pib" class="form-control input-sm" placeholder="pib">
                                </div>
                            </div>
                     
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <div class="form-group">
                                    <input type="number" name="brtel" id="brtel" class="form-control input-sm" placeholder="brtel">
                                </div>
                            </div>
                        </div>
               
               <input type="submit" value="Dodaj kupca" class="btn btn-info btn-block">

                    </form>
                </div>
            </div>
        </div>
    </div>

    <table id='myTable_kupac' border='1' class='tablesorter table table-striped'></table>


</div>




<script>
       $(document).ready(function() {

        $.getJSON('get_kupac.php', function(jsondata) {Tablify_kupac(jsondata, '#myTable_kupac', 'SIFRAKUPCA');});




});

</script>

<?php 
require_once 'footer.php';
?>