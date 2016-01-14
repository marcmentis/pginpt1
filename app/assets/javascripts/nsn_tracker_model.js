function NsnT_pat_notes_groups(patient_id, date_after, date_before) {
	alert('in function')
	var url = '/nsn_tracker_pat_notes_grps/'

	var data_for_params = {nsn_tracker: {'patient_id': patient_id, 'date_after': date_after, 'date_before': date_before}}

	$.ajax({ 
		url: url,
		data: data_for_params,
		type: 'GET',
		cache: false,
		dataType: 'json'
	}).done(function(data){
		alert('success')
	}).fail(function(jqXHR,textStatus,errorThrown){
		alert(''+jqXHR+': '+textStatus+':'+errotThrown+'')
	});
};