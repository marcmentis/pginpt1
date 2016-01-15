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
		var current_group = '';
		var last_group = '';
		//Clear text area
		$('#txa_NsnT_Comments').val('');

		for (var i = 0; i < data.length; i++) {
			var group_date = moment(data[i].group_date, "YYYY-MM-DD").format('YYYY-MM-DD')
			var groupname = data[i].groupname
			var groupleader = data[i].leader
			var duration = ''+data[i].duration+' hours'
			var groupsite = data[i].groupsite

			var current_group = ''+groupname+': '+groupleader+': '+groupsite+': '+duration+''

			var comment = data[i].comment

			var current_group

			//create the text
			if (current_group != last_group) {
				text += '\n\n****************************'
				text += '\n'+current_group+''
			};
			text += '\n\n'+group_date+':'
			text += '\n'+comment+''

			last_group = current_group;
		};

		//Enter text into text area
		$('#txa_NsnT_Comments').val(text);

	}).fail(function(jqXHR,textStatus,errorThrown){
		alert(''+jqXHR+': '+textStatus+':'+errotThrown+'')
	});
};