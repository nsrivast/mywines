// autocomplete helper functions

function split( val ) {
  return val.split( /,\s*/ );
}
function extractLast( term ) {
  return split( term ).pop();
}
function keepInWindow( event ) {
  if ( event.keyCode === $.ui.keyCode.TAB &&
      $( this ).data( "ui-autocomplete" ).menu.active ) {
    event.preventDefault();
  }
}
function sourceFunction ( sourceList ){
	return function ( request, response ) {
		response( $.ui.autocomplete.filter(
			sourceList, extractLast( request.term )
		))
	}
}

var autocompleteOptions = {
   minLength: 0,
   focus: function() { return false; },
   select: function( event, ui ) {
     var terms = split( this.value );
     terms.pop();
     terms.push( ui.item.value );
     terms.push( "" );
     this.value = terms.join( ", " );
     return false;
   }
 }
 
 
 // implement sortable data tables

$(document).ready(function() {
	var dataTableSettings = {
		"bPaginate": false,
    "bLengthChange": false,
    "bFilter": true,
    "bSort": true,
    "bInfo": false,
    "bAutoWidth": false};
				
	$('#tasting_table').dataTable(dataTableSettings);
	$('#wine_table').dataTable(dataTableSettings);
	$('#user_table').dataTable(dataTableSettings);
	$('#classification_table').dataTable(
		$.extend(dataTableSettings, {"aaSorting": [[3, "asc" ], [2, "asc"], [1, "asc"], [0, "asc"]] })
		);
});