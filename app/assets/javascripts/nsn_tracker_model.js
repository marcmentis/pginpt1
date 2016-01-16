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
		//Clear text area
		$('#txa_NsnT_Comments').val('');
		//Get text for comment textarea
		text = create_comment_text(data);
		//Enter text into text area
		$('#txa_NsnT_Comments').val(text);

		//Create Aggregate text
		//Clear text area
		$('#txa_NsnT_Aggregate').val('');
		//Get text for aggregate textarea
		text = create_aggregate_text(data);	
		// Get text for individual groups
		text_grps = get_group_totals(data)

		full_text = ''+text+''	
		full_text += '\n'+text_grps+''
		//Enter text into textarea
		$('#txa_NsnT_Aggregate').val(full_text)

		

	}).fail(function(jqXHR,textStatus,errorThrown){
		alert(''+jqXHR+': '+textStatus+':'+errotThrown+'')
	});
};

function create_comment_text(data) {
	var text = '';
	var current_group = '';
	var last_group = '';
	//Create Comment text
	for (var i = 0; i < data.length; i++) {
		var group_date = moment(data[i].group_date, "YYYY-MM-DD").format('YYYY-MM-DD')
		var groupname = data[i].groupname
		var groupleader = data[i].leader
		var duration = ''+data[i].duration+' hours'
		var groupsite = data[i].groupsite

		var current_group = ''+groupname+': '+groupleader+': '+groupsite+': '+duration+''

		var comment = data[i].comment

		//create the text
		if (current_group != last_group) {
			text += '\n\n****************************'
			text += '\n'+current_group+''
		};
		text += '\n\n'+group_date+':'
		text += '\n'+comment+''

		last_group = current_group;
	};
	return text;
};

function create_aggregate_text(data) {
	var text = '';
	var no_of_groups = data.length;
	var text2 = '';
	var gtot_hrs = 0;
	var gtot_Q1 = 0;
	var gtot_Q2 = 0;
	var gtot_Q3 = 0;
	var gtot_Q4 = 0;
	var gtot_Q5 = 0;
	var gtot_Q6 = 0;
	var Qave = 0;

	
	
	//Get grand totals
	for (var i = 0; i < data.length; i++) {
		var duration = parseFloat(data[i].duration)
		var participate = convert_Q1_Q5_to_float(data[i].participate)
		var respond = convert_Q1_Q5_to_float(data[i].respond)
		var interact_leader = convert_Q1_Q5_to_float(data[i].interact_leader)
		var interact_peers = convert_Q1_Q5_to_float(data[i].interact_peers)
		var discussion_init = convert_Q1_Q5_to_float(data[i].discussion_init)
		var discussion_understand = convert_Q6_to_float(data[i].discussion_understand)

		//Get grand totals
		gtot_hrs += duration;
		gtot_Q1 += (participate/no_of_groups);
		gtot_Q2 += (respond/no_of_groups);
		gtot_Q3 += (interact_leader/no_of_groups);
		gtot_Q4 += (interact_peers/no_of_groups);
		gtot_Q5 += (discussion_init/no_of_groups);
		gtot_Q6 += (discussion_understand/no_of_groups);
	};

	Qave = (gtot_Q1 + gtot_Q2 + gtot_Q3 + gtot_Q4 + gtot_Q5 + gtot_Q6)/6
	text += 'ATD  Tot  Q1  Q2  Q3  Q4  Q5 Q6 Qave Grp Name'
	text += '\n '+no_of_groups+'  '+gtot_hrs.toFixed(1)+'  '+gtot_Q1.toFixed(1)+'  '+gtot_Q2.toFixed(1)+'  '+gtot_Q3 .toFixed(1)+'  '+gtot_Q4.toFixed(1)+'  '+gtot_Q5.toFixed(1)+'  '+gtot_Q6.toFixed(1)+'  '+Qave.toFixed(1)+' All Groups'

	return text;
};

function get_group_totals(data) {
	var text = '';
	var gtot_hrs = 0;
	var gtot_Q1 = 0;
	var gtot_Q2 = 0;
	var gtot_Q3 = 0;
	var gtot_Q4 = 0;
	var gtot_Q5 = 0;
	var gtot_Q6 = 0;
	var Qave = 0;

	var current_group = '';
	var last_group = '';
	var grp_text = '';
	var no_this_grp = 0;

	for (var i = 0; i < data.length; i++) {
		var duration = parseFloat(data[i].duration)
		var participate = convert_Q1_Q5_to_float(data[i].participate)
		var respond = convert_Q1_Q5_to_float(data[i].respond)
		var interact_leader = convert_Q1_Q5_to_float(data[i].interact_leader)
		var interact_peers = convert_Q1_Q5_to_float(data[i].interact_peers)
		var discussion_init = convert_Q1_Q5_to_float(data[i].discussion_init)
		var discussion_understand = convert_Q6_to_float(data[i].discussion_understand)

		var groupname = data[i].groupname
		var groupleader = data[i].leader
		var duration = ''+data[i].duration+''
		var groupsite = data[i].groupsite
		var current_group = ''+groupname+': '+groupleader+': '+groupsite+': '+duration+''



		

		//Get group totals
		if (i == 0) {
			last_group = current_group
			//Get grand totals
			gtot_hrs += duration;
			gtot_Q1 += (participate);
			gtot_Q2 += (respond);
			gtot_Q3 += (interact_leader);
			gtot_Q4 += (interact_peers);
			gtot_Q5 += (discussion_init);
			gtot_Q6 += (discussion_understand);
		};

		if (current_group == last_group) {
			gtot_hrs
			gtot_Q1 = gtot_Q1/no_this_grp;
			gtot_Q2 = gtot_Q2/no_this_grp;
			gtot_Q3 = gtot_Q3/no_this_grp;
			gtot_Q4 = gtot_Q4/no_this_grp;
			gtot_Q5 = gtot_Q5/no_this_grp;
			gtot_Q6 = gtot_Q6/no_this_grp;
		} else {
			grp_text += '\n '+no_this_grp+'  '+gtot_hrs+'  '+gtot_Q1.toFixed(1)+'  '+gtot_Q2.toFixed(1)+'  '+gtot_Q3 .toFixed(1)+'  '+gtot_Q4.toFixed(1)+'  '+gtot_Q5.toFixed(1)+'  '+gtot_Q6.toFixed(1)+'  '+Qave.toFixed(1)+' '+current_group+''
			no_this_grp = 0;
		};

		//Get grand totals
		gtot_hrs += duration;
		gtot_Q1 += (participate);
		gtot_Q2 += (respond);
		gtot_Q3 += (interact_leader);
		gtot_Q4 += (interact_peers);
		gtot_Q5 += (discussion_init);
		gtot_Q6 += (discussion_understand);

		last_group = current_group
		no_this_grp += +1;
		alert(''+current_group+' '+last_group+'')
		alert(grp_text)
	};

	return grp_text;
};

function convert_Q1_Q5_to_float(q) {
	switch(q) {
		case 'never':
			return 1;
			break;
		case 'sometimes':
			return 2;
			break;
		case 'frequently':
			return 3;
			break;
		case 'always':
			return 4;
			break;
		default:
			return 'error'
	};
};

function convert_Q6_to_float(q) {
	switch(q) {
		case 'much worse':
			return 1;
			break;
		case 'somewhat worse':
			return 2;
			break;
		case 'no change':
			return 3;
			break;
		case 'improved':
			return 4;
			break;
		case 'much improved':
			return 5;
			break;
		default:
			return 'error'
	};
};

