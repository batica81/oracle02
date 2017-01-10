
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


function Populate_option(data, id, fieldname){

  for(var i=0;i<data.length;i++){
    var turk = data[i];
    var option = '<option value="' + turk[id] + '">'+ turk[fieldname]+'</option>';
    $('#selectbasic').append(option);
  }


}
