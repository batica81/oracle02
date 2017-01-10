<?php
require_once 'header.php';
?>

<div class="container">
<table id="myTable" border='1' class='tablesorter table table-striped'></table>




<div id="accordion">
  <h3>First header</h3>
  <div>First content panel</div>
  <h3>Second header</h3>
  <div>Second content panel</div>
</div>
</div>


<script>
        $.getJSON('get_stavke_ponude.php', function(jsondata) {Tablify(jsondata, '#myTable');});
</script>

<script>
  $( function() {
    $( "#accordion" ).accordion({
      heightStyle: "content",
      collapsible: true
    });
  } );
  </script>

<?php 
require_once 'footer.php';
?>