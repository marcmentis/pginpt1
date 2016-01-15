function NsnT_pat_notes_groups(patient_id, date_after, date_before) {
	var url = '/nsn_tracker_pat_notes_grps/'

	var data_for_params = {'patient_id': patient_id, 'date_after': date_after, 'date_before': date_before}

	$.ajax({ 
		url: url,
		data: data_for_params,
		type: 'GET',
		cache: false,
		dataType: 'json'
	}).done(function(data){
		var text = '';
		//Clear text area
		$('#txa_NsnT_Comments').val('');

		for (var i = 0; i < data.length; i++) {
			var group_date = moment(data[i].group_date, "YYYY-MM-DD").format('YYYY-MM-DD')
			var groupname = data[i].groupname
			var groupleader = data[i].leader

			var comment = data[i].comment

			//create the text
			text += '\n'+groupname+': '+group_date+' '+groupleader+''
			text += '\n'+comment+''

			text += '\n'
		};

		//Enter text into text area
		$('#txa_NsnT_Comments').val(text);

	}).fail(function(jqXHR,textStatus,errorThrown){
		alert(''+jqXHR+': '+textStatus+':'+errotThrown+'')
	});
};