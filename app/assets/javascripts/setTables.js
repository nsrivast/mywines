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