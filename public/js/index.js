
function Tablify(data, table_id){ 

        var tableRow;
        var tableHeader = '<thead>';

        for (var keyName in data[0]){
          tableHeader += '<th>' + keyName + '</th>';
        }

        tableHeader += '</thead>';

        for(var i=0;i<data.length;i++){
          var turk = data[i];
          tableRow += '<tr>';

            for(var key in turk){
              tableRow += '<td>' + turk[key] + '</td>';
            }

          tableRow += '</tr>';
        }

        $(table_id).append(tableHeader);
        $(table_id).append(tableRow);
        $(table_id).tablesorter(); 

} // end tablify


function Populate_option(data, id, fieldname, option_id){

  for(var i=0;i<data.length;i++){
    var turk = data[i];
    var option = '<option value="' + turk[id] + '">'+ turk[fieldname]+'</option>';
    $(option_id).append(option);
  }
}


function Tablify_kupac(data, table_id, primary_key){ 

        var tableRow;
        var tableHeader = '<thead>';
        var keynames_array = [];
        var tmp_keys_array = [];

        for (var keyName in data[0]){
          tableHeader += '<th>' + keyName + '</th>';
          keynames_array.push(keyName);
        }

        tableHeader += '<th>OPCIJE</th>';
        tableHeader += '</thead>';

        for(var i=0;i<data.length;i++){
          var turk = data[i];
          tableRow += '<tr>';

                tmp_key = turk[primary_key];


            for(var key in turk){
                tableRow += '<td id="'+tmp_key+'_'+key+'" class="'+ key +'">' + turk[key] + '</td>';

            }
                tableRow += '<td><a class="btn btn-danger" href="kupac_obrisi.php?id_za_brisanje='+tmp_key+'">Obriši<a></td>';
                tableRow += '</tr>';
                tmp_keys_array.push(tmp_key);

        }

        $(table_id).append(tableHeader);
        $(table_id).append(tableRow);
        $(table_id).tablesorter(); 
                              
              

        for (var i = 0; i < tmp_keys_array.length; i++) {
         
          temp_id = '#'+tmp_keys_array[i]+'_'+'IMEKUPCA';

          

         $(temp_id).editable({
            type: 'text',
            pk: tmp_keys_array[i],
            url: 'kupac_izmeni.php',
            title: 'Izmenite ime kupca'
          });
        };

} // end Tablify_kupac


function Tablify_artikal(data, table_id, primary_key){ 

        var tableRow;
        var tableHeader = '<thead>';
        var keynames_array = [];
        var tmp_keys_array = [];

        for (var keyName in data[0]){
          tableHeader += '<th>' + keyName + '</th>';
          keynames_array.push(keyName);
        }
        tableHeader += '<th>OPCIJE</th>';
        tableHeader += '</thead>';

        for(var i=0;i<data.length;i++){
          var turk = data[i];
          tableRow += '<tr>';

          tmp_key = turk[primary_key];

            for(var key in turk){
            
                tableRow += '<td id="'+tmp_key+'_'+key+'" class="'+ key +'">' + turk[key] + '</td>';
            }

          tableRow += '<td><a class="btn btn-danger" href="artikal_obrisi.php?id_za_brisanje='+tmp_key+'">Obriši<a></td>';

          tableRow += '</tr>';
          tmp_keys_array.push(tmp_key);
        }

        $(table_id).append(tableHeader);
        $(table_id).append(tableRow);
        $(table_id).tablesorter(); 


        for (var i = 0; i < tmp_keys_array.length; i++) {
         
          temp_id = '#'+tmp_keys_array[i]+'_'+'NAZIVARTIKLA';

          

         $(temp_id).editable({
            type: 'text',
            pk: tmp_keys_array[i],
            url: 'artikal_izmeni.php',
            title: 'Izmenite naziv artikla'
          });
        };

} // end Tablify_artikal


function Tablify_ponuda(data, table_id, primary_key){ 

        var tableRow;
        var tableHeader = '<thead>';
        var keynames_array = [];
        var tmp_keys_array = [];

        for (var keyName in data[0]){
          tableHeader += '<th>' + keyName + '</th>';
          keynames_array.push(keyName);
        }

        tableHeader += '<th>OPCIJE</th>';

        tableHeader += '</thead>';

        for(var i=0;i<data.length;i++){
          var turk = data[i];
          tableRow += '<tr>';

          tmp_key = turk[primary_key];

            for(var key in turk){
            
                tableRow += '<td id="'+tmp_key+'_'+key+'" class="'+ key +'">' + turk[key] + '</td>';
            }

            tableRow += '<td><a class="btn btn-success" href="#">Izmeni<a> <a class="btn btn-danger" href="ponuda_obrisi.php?id_za_brisanje='+tmp_key+'">Obriši</td>';

          tableRow += '</tr>';
          tmp_keys_array.push(tmp_key);
        }

        $(table_id).append(tableHeader);
        $(table_id).append(tableRow);
        $(table_id).tablesorter(); 

// Dodaj polje koje je moguce menjati

        for (var i = 0; i < tmp_keys_array.length; i++) {
         
          temp_id = '#'+tmp_keys_array[i]+'_'+'SIFRAKUPCA';

          

         $(temp_id).editable({
            type: 'text',
            pk: tmp_keys_array[i],
            url: 'ponuda_izmeni.php',
            title: 'Izmenite naziv artikla'
          });
        };

} // end Tablify_ponuda



function Populate_option_1(data, id, fieldname, option_id){

  for(var i=0;i<data.length;i++){
    var turk = data[i];
    var option = '<option value="' + turk[id] + '">'+ turk[fieldname]+'</option>';
    $(option_id).append(option);
  }
}