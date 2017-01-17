<?php
require_once 'header.php';
?>

<?php 

require '../vendor/autoload.php';
require_once 'dbaccess_class.php';

if (isset($_POST) && (!empty($_POST['SIFRAKUPCA'])) ) {

    $db = new DbAccess;
    $last_user_id = $db->database->insert("PONUDA", [
        "SIFRAKUPCA" => $_POST['SIFRAKUPCA']
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
                        <button id="singlebutton" name="singlebutton" class="btn btn-info">Dodaj ponudu</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <table id='myTable_ponuda' border='1' class='tablesorter table table-striped edit'></table>







<script>



    $.getJSON('get_ponuda.php', function(jsondata) {Tablify_ponuda(jsondata, '#myTable_ponuda', 'BRPONUDE');});
    $.getJSON('get_kupac.php', function(jsondata) {Populate_option(jsondata,'SIFRAKUPCA', 'IMEKUPCA', '#selectbasic');});

    $.getJSON('get_ponuda.php', function(jsondata) {Populate_option(jsondata,'BRPONUDE', 'BRPONUDE', '#select_BRPONUDE');});
    $.getJSON('get_artikal.php', function(jsondata) {Populate_option(jsondata,'SIFRAARTIKLA', 'NAZIVARTIKLA', '#select_SIFRAARTIKLA');});
</script>


<?php 

if (isset($_GET['br_ponude'])) {
    

 ?>


<div class="ponuda_omot">
<h3>Detalji ponude br. <strong><?php echo $_GET['br_ponude'];?></strong></h3>

    <div class="row centered-form">
        <div class="col-xs-12 col-sm-8 col-md-4 col-sm-offset-2 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Dodajte novu stavku ponude</h3>
                </div>
                <div class="panel-body">
                    <form action="dodaj_stavke_ponude.php" method="post" role="form">
                        <input type="hidden" name="BRPONUDE" value="<?php echo $_GET['br_ponude'];?>">

                         <div class="form-group">
                                  <label class="control-label" for="select_SIFRAARTIKLA">Izaberi artikal</label>
                                    <select id="select_SIFRAARTIKLA" name="SIFRAARTIKLA" class="form-control">

                                    </select>
                        </div>

                         <div class="form-group">
                                <label class="control-label" for="kolicina">Unesi količinu</label>
                                <input type="number" min="1" step="1" name="KOLICINA" class="form-control input-sm" placeholder="Kolicina" required>

                        </div>

                        <button id="singlebutton" name="singlebutton" class="btn btn-info">Dodaj stavku ponude</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div>
    <h4>Stavke ponude</h4>

    <table id="detalji_ponude" border='1' class='table table-striped table-condensed'></table>
    </div>
</div>

<script type="text/javascript">
    
    $.getJSON('get_stavke_ponude.php?BRPONUDE=<?php echo $_GET['br_ponude'];?>', function(jsondata) {Tablify_stavka(jsondata, '#detalji_ponude', 'RBR');});
    
</script>




<?php 
};
 ?>


     


</div>

<?php 
require_once 'footer.php';
?>