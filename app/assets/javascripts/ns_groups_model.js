function complex_search_nsGrp (){
	// facility = -1
	var groupname = $('#ftx_S_groupname').val();
	var leader = $('#ftx_S_leader').val();
	var facility = $('#session-facility').val();

	// $("#gridGrid").remove();         
	url = '/ns_groups_search?groupname='+groupname+'&leader='+leader+'&facility='+facility+''
	refreshgrid_NsGrp(url);	
};

function refreshgrid_NsGrp(url){

	// if (url == 'nil') {url = '/patients'}; 
	if (url == 'nil') {url = "/ns_groups_search?firstname=&lastname=&identifier=&facility=-1&site=-1"}

	
	//Create Table and Div for grid and navigation "pager" 
 	// $("#gridWork").remove();         
	$('#divGrid').html('<table id="divTable" style="background-color:#E0E0E0"></table><div id="divPager"></div>');
	//Define grid
	$("#divTable").jqGrid({
		url: url,
		datatype:"json",
		mtype:"GET",
		colNames:["id","Duration","GrpName","Leader","Site","Facility"],
		colModel:[
			{name:"id",index:"id",width:55, hidden:true},
			{name:"duration",index:"duration",width:25,align:"center",editable:true},
			{name:"groupname",index:"groupname",width:150,align:"center"},
			{name:"leader",index:"leader",width:100,align:"center"},
			{name:"groupsite",index:"groupsite",width:100,align:"center"},
			{name:"facility",index:"facility",width:15,align:"center", hidden:true}
		],
		editurl:"/patient/update",
		pager:"#divPager",
		height:235,
		width: 535,
		altRows: true,
		rowNum:10,
		rowList:[15,25,40],
		sortname:"groupname",
		sortorder:"asc",
		viewrecords:true,
		gridview: true, //increased speed can't use treeGrid, subGrid, afterInsertRow
		// loadonce: true,  //grid load data only once. datatype set to 'local'. Futher manip on client. 'Pager' functions disabled
		caption:"NonScheduled Groups ",

	        loadComplete: function(){
	        	// alert('in loadComplete')
	        },

			onSelectRow:function(id) { 
				//Store the group id in the hidden field
				$('#nsGrp_ID').val(id);

			data_for_params = {ns_group: {id: id}}
			$.ajax({ 
				// This is the 'show' route
				url: '/ns_groups/'+id+'',
				data: data_for_params,
				//type: 'POST',
				type: 'GET',
				cache: false,
				dataType: 'json'
				}).done(function(data){
					var input_date = $('#dt_NsGrp_input').val();
					var full_group_name = ''+data.groupname+': '+data.leader+': '+data.groupsite+'';
					var ns_group_id = $('#nsGrp_ID').val();
					var group_date = $('#dt_NsGrp_input').val();
					//Clear and hide New/Edit if showing 
					clearFields_patientData1();
					$('#divNsGrpNewEdit').hide();
					
					//Fill out and show Current Group
					$('#ftx_GrpDate_display').val(input_date);
					$('#ftx_GrpName_display').val(full_group_name);	
					$('#divFormNsGrpCurrentGrp, #divNsGrpToDoDone').show();

					//Populate ToDo and Done Lists
					popNsGrpLists(ns_group_id, group_date)
						  
				}).fail(function(){
					alert('Error in: /ns_group/id');
					alert('HTTP status code: ' + jqXHR.status + '\n' +
					'textStatus: ' + textStatus + '\n' +
					'errorThrown: ' + errorThrown);
					alert('HTTP message body (jqXHR.responseText): ' + '\n' + jqXHR.responseText);
				});	

				
				// set_id(id);  //set the ID variable
				// $('#patient_id').val(id);  //set the ID variable
				// data_for_params = {patient: {id: id}}
				// $.ajax({ 
				// 		  // url: '/inpatient_show',
				// 		  url: '/patients/'+id+'',
				// 		  data: data_for_params,
				// 		  //type: 'POST',
				// 		  type: 'GET',
				// 		  cache: false,
				// 		  dataType: 'json'
				// 	}).done(function(data){
				// 		clearFields();
				// 		$('#bPatientSubmit').attr('value','Edit');
				// 		$('#divPatientAsideRt, #bPatientSubmit, #bPatientBack').show();
				// 		$('#id').val(data.id);
				// 		$('#txt_Pat_firstname').val(data.firstname);
				// 		$('#txt_Pat_lastname').val(data.lastname);
				// 		if ($('#all-facilities').val() !== 'true'){
				// 			$('#txt_Pat_lastname').prop("disabled", true)
				// 								.css({'background-color': '#E0E0E0'})
				// 		};
				// 		$('#txt_Pat_number').val(data.identifier);
				// 		$('#slt_F_facility').val(data.facility);	
				// 		if ($('#all-facilities').val() == 'true') {
				// 			// IF ADMIN-3 - need to first populate slt_F_ward as table can include any facililty
				// 			$('#slt_F_ward').mjm_addOptions('ward', {
				// 				firstLine: 'All Wards', 
				// 				facility: data.facility,
				// 				complete: function(){
				// 					$('#slt_F_ward').val(data.site);
				// 			}
				// 		});
				// 		}else {
				// 			//If not ADMIN-3, can populate slt_F_ward with session-facility in begining and so
				// 				//just choose the ward here.
				// 			$('#slt_F_ward').val(data.site);	
				// 		};
				// 		// $('#dt_Pat_DOA').val(data.doa)
				// 		$('#dt_Pat_DOA').val(moment(data.doa,"YYYY-MM-DD").format('YYYY-MM-DD'));
				// 		$('#dt_Pat_DOB').val(moment(data.dob, "YYYY-MM-DD").format('YYYY-MM-DD'));
				// 		$('#dt_Pat_DOD').val(moment(data.dod, "YYYY-MM-DD").format('YYYY-MM-DD'));
								  
				// 	}).fail(function(){
				// 		alert('Error in: /inpatient');
				// 	});
				
			},

			loadError: function (jqXHR, textStatus, errorThrown) {
		        alert('HTTP status code: ' + jqXHR.status + '\n' +
		              'textStatus: ' + textStatus + '\n' +
		              'errorThrown: ' + errorThrown);
		        alert('HTTP message body (jqXHR.responseText): ' + '\n' + jqXHR.responseText);
		    },	
	})
	.navGrid('#divPager', 
		{edit:false,add:false,del:false,search:false,refresh:false}
		// {edit:false,add:false,del:true,search:false,refresh:false}
		// {"del":true}, 
		// {"closeAfterEdit":true,"closeOnEscape":true}, 
		// {}, {}, {}, {}
 	  )
	.navButtonAdd('#divPager', {
		caption: 'New',
		buttonicon: '',
		onClickButton: function(){
			//TO DO   Remove focus from any Group row
			$('#nsGrp_ID').val('');
			clearFields_patientData1();
			$('#btNsGrpNewSubmit').attr('value', 'New')	
			$('#divNsGrpNewEdit').show();
			//THINK ABOUT CLEARING FIELDS etc. HERE
		},
		position:'last'
	})
	.navButtonAdd('#divPager', {
		caption: 'Edit',
		buttonicon: '',
		onClickButton: function(){
			id = $('#nsGrp_ID').val();
			//Check that group has been selected
			if (id.length < 1) {
				clearFields_patientData1();
				alert('Please select a group')
				return true;
			};

			data_for_params = {ns_group: {id: id}}
			$.ajax({ 
				// This is the 'show' route
				url: '/ns_groups/'+id+'',
				data: data_for_params,
				//type: 'POST',
				type: 'GET',
				cache: false,
				dataType: 'json'
				}).done(function(data){
					//CLEAR FIELDS
					$('#btNsGrpNewSubmit').attr('value', 'Edit')

					$('#slt_NsGrp_duration').val(data.duration);
					$('#txt_NsGrp_group_name').val(data.groupname);
					$('#txt_NsGrp_leader').val(data.leader);
					$('#txt_NsGrp_group_site').val(data.groupsite);
	
					$('#divNsGrpNewEdit').show();	  
				}).fail(function(){
					alert('Error in: /ns_group/id');
					alert('HTTP status code: ' + jqXHR.status + '\n' +
					'textStatus: ' + textStatus + '\n' +
					'errorThrown: ' + errorThrown);
					alert('HTTP message body (jqXHR.responseText): ' + '\n' + jqXHR.responseText);
				});					
		},
	})
	.navButtonAdd('#divPager', {
		caption: 'Del',
		buttonicon: '',
		onClickButton: function(){	
			for_delete = $('#forDelete').val();
			if (for_delete == 'true') {
				ID = $('#nsGrp_ID').val(); 
				if (ID.length > 0) {	
					if(confirm("Are you sure you want to delete this patient")){
						nsGrp_ajax1('/ns_groups/'+ID+'', 'DELETE');	
					} else {
						return true;
					};
				} else{
					alert('No patient has been selected.')
				};
			}else {
				alert("Sorry, you do not have privileges to delete patients");
				return true;
			};
		},
		position:'last'
	});
};

function popNsForm(patient_id, newEdit) {

};

//This is the group 'newEdit' function
function nsGrp_ajax1 (url, type) {
	// var firstname = $('#firstname').val();
	// var lastname = $('#lastname').val();
	// var number = $('#number').val();
	// var facility = $('#slt_F_facility').val();
	// var ward = $('#slt_F_ward').val();

	var params_string = $('#fNsGrpNewEdit').serialize();
	params_string_replace = params_string.replace(/&/g,',')
	params_string_replace = params_string_replace.replace(/%2F/g,'/')
	params_array = params_string_replace.split(',');
	

	var params_hash = {};
	params_hash['updated_by'] = $('#session-username').val();
	params_hash['facility'] = $('#session-facility').val();
	//Serialize does NOT generate disabled values
	// if ($('#all-facilities').val() !== 'true') {
	// 	params_hash['facility'] = $('#slt_F_facility').val();
	// };
	
	for(var i=0, l = params_array.length; i<l; i++){
		string = params_array[i]
		array = string.split('=')
		key = array[0];
		value = array[1]
		params_hash[key] = value;
	}
	//Make strong params
	data_for_params = {ns_group: params_hash}

	$.ajax({
		url: url,
		type: type,
		data: data_for_params,
		cache: false,
		dataType: 'json'
	}).done(function(data){
		clearFields_patientData1();
		complex_search_nsGrp();
		// clearFields();
		// $('#divPatientAsideRt, #bEdit, #bNew, #bDelete, #bBack').hide();
		// $('#divPatientAsideRt, #bPatientSubmit, #bPatientBack').hide();

	}).fail(function(jqXHR,textStatus,errorThrown){
		// alert('HTTP status code: ' + jqXHR.status + '\n' +
  //             'textStatus: ' + textStatus + '\n' +
  //             'errorThrown: ' + errorThrown);
  //       alert('HTTP message body (jqXHR.responseText): ' + '\n' + jqXHR.responseText);
        var msg = JSON.parse(jqXHR.responseText)
        var newHTML;
        newHTML = '<h3>Validation Error</h3>';	
        newHTML += '<ul>';        
        $.each(msg, function(key, value){
        	newHTML += '<li>'+ value +'</li>';
        });
        newHTML += '</ul>';
        $('#NsGrpsNewEditErrors').show().html(newHTML)
	});
};

function nsGrp_newedit_note (url, type) {
	// var firstname = $('#firstname').val();
	// var lastname = $('#lastname').val();
	// var number = $('#number').val();
	// var facility = $('#slt_F_facility').val();
	// var ward = $('#slt_F_ward').val();


	var params_string = $('#fNsGrpNotes').serialize();
	params_string_replace = params_string.replace(/&/g,',')
	params_string_replace = params_string_replace.replace(/%2F/g,'/')
	params_array = params_string_replace.split(',');

	var params_hash = {};
	params_hash['updated_by'] = $('#session-username').val();
	params_hash['ns_group_id'] = $('#nsGrp_ID').val();
	params_hash['group_date'] = $('#ftx_GrpDate_display').val();

	
	for(var i=0, l = params_array.length; i<l; i++){
		string = params_array[i]
		array = string.split('=')
		key = array[0];
		value = array[1]
		params_hash[key] = value;
	}
	//Make strong params
	data_for_params = {ns_note: params_hash}

	$.ajax({
		url: url,
		type: type,
		data: data_for_params,
		cache: false,
		dataType: 'json'
	}).done(function(data){
		var ns_group_id = $('#nsGrp_ID').val();
		var group_date = $('#dt_NsGrp_input').val();
		// clearFields_patientData1();
		// complex_search_nsGrp();

		// clearFields();
		// $('#divPatientAsideRt, #bEdit, #bNew, #bDelete, #bBack').hide();
		// $('#divPatientAsideRt, #bPatientSubmit, #bPatientBack').hide();

		//Populate ToDo and Done Lists
		popNsGrpLists(ns_group_id, group_date)

	}).fail(function(jqXHR,textStatus,errorThrown){
		// alert('HTTP status code: ' + jqXHR.status + '\n' +
  //             'textStatus: ' + textStatus + '\n' +
  //             'errorThrown: ' + errorThrown);
  //       alert('HTTP message body (jqXHR.responseText): ' + '\n' + jqXHR.responseText);

        var msg = JSON.parse(jqXHR.responseText)
        var newHTML;
        newHTML = '<h3>Validation Error</h3>';	
        newHTML += '<ul>';        
        $.each(msg, function(key, value){
        	newHTML += '<li>'+ value +'</li>';
        });
        newHTML += '</ul>';
        $('#divGrpsPatNoteErrors').show().html(newHTML)
	});
};

function popSelectWard(user_facility, ward) {
	// var url = '/ns_groups_ward_patients/'
	var url = '/patients_by_ward/'
	//create strong parameter
	data_for_params = {patient: {'site': ward, 'facility': user_facility}}

	$.ajax({
		url: url,
		type: 'GET',
		data: data_for_params,
		cache: false,
		dataType: 'json'
	}).done(function(data){
		$('#slt_NsGrp_patient').find('option').remove();
		var html = '<option value="">ChoosePat </option>';
		for(var i = 0; i < data.length; i++){
			firstname = data[i]["firstname"]
			lastname = data[i]["lastname"]
			identifier = data[i]["identifier"]
			name = ''+lastname+': '+firstname+' '+identifier+''
			if (data[i] !== 'null'){
				text = name
				value = data[i]["id"]
			};

			html += '<option value="'+value+'">' + text + ' </option>'	
		}
		$('#slt_NsGrp_patient').append(html);
	}).fail(function(jqXHR,textStatus,errorThrown){
		alert('jqXHR: '+jqXHR+'/n textStatus: '+textStatus+' errorThrown: '+errorThrown+'')
	});

};

function popGroupPatientJoinTable(ns_group_id, patient_id) {
	var url = '/ns_groups_add_join/'
	//create strong parameter
	data_for_params = {ns_group: {'ns_group_id': ns_group_id, 'patient_id': patient_id}}
	$.ajax({
		url: url,
		type: 'POST',
		data: data_for_params,
		cache: false,
		dataType: 'json'
	}).done(function(data){
		// alert(data['success'])
		var ns_group_id = $('#nsGrp_ID').val();
		var group_date = $('#dt_NsGrp_input').val();
		popNsGrpLists(ns_group_id, group_date)
	}).fail(function(jqXHR,textStatus,errorThrown){
		alert('Likely this patient already in group:/n jqXHR: '+jqXHR+'/n textStatus: '+textStatus+' errorThrown: '+errorThrown+'')
	});
};

function get_patient_note(patient_id, ns_group_id, group_date) {
	var url = 'ns_notes_pat_group_date'
	var data_for_params = {ns_note: {'patient_id': patient_id,
										'ns_group_id': ns_group_id,
										'group_date': group_date}};

	$.ajax({
			url: url,
			type: 'GET',
			data: data_for_params,
			cache: false,
			dataType: 'json'
		}).done(function(data){
			var patientname = $('#slt_NsGrp_done option:selected').text();
			note_id = data[0]['id']
			alert(note_id)
			$('#ftx_Note_id').val(data[0]['id'])
			$('#ftx_PatNote_display').val(patientname);
			$('#btNsGrpNoteSubmit').attr('value', 'Edit')


			$('#divNsGrpNotes').show();
		}).fail(function(jqXHR,textStatus,errorThrown){
			alert(''+jqXHR+': '+textStatus+':'+errorThrown+'')
		});
};

function popNsGrpLists(ns_group_id, group_date) {
	// alert(ns_group_id);
	// alert(group_date);
	var url = 'ns_groups_pat_lists'
	var data_for_params = {ns_group: {'ns_group_id': ns_group_id,
										'group_date': group_date}};

	$.ajax({
			url: url,
			type: 'GET',
			data: data_for_params,
			cache: false,
			dataType: 'json'
		}).done(function(data){
			to_do = data.pat_all_to_do;
			done = data.pat_all_done;
			// test = to_do[0]['lastname']
			// alert(test)
			
			todo_id = 'slt_NsGrp_to_do';
			done_id = 'slt_NsGrp_done';
			populatePatientListSelects(todo_id, to_do);
			populatePatientListSelects(done_id, done);
		}).fail(function(jqXHR,textStatus,errorThrown){
			alert(''+jqXHR+': '+textStatus+':'+errorThrown+'')
		});
}
function populatePatientListSelects (slt_name, data) {
		$('#'+slt_name+'').find('option').remove();
			var html = '';
			for(var i = 0; i < data.length; i++){
				id = data[i].id;
				lastname = data[i].lastname;
				firstname = data[i].firstname;
				identifier = data[i].identifier;
				html += '<option value="'+id+'">' + lastname + ' '+firstname+': '+identifier+'</option>'
			}
			$('#'+slt_name+'').append(html);
};

function removePatient(ns_group_id, patient_id) {
	var url = '/ns_groups_remove_join/'
	//create strong parameter
	data_for_params = {ns_group: {'ns_group_id': ns_group_id, 'patient_id': patient_id}}
	$.ajax({
		url: url,
		type: 'DELETE',
		data: data_for_params,
		cache: false,
		dataType: 'json'
	}).done(function(data){
		// alert(data['success'])
		var ns_group_id = $('#nsGrp_ID').val();
		var group_date = $('#dt_NsGrp_input').val();
		popNsGrpLists(ns_group_id, group_date)
	}).fail(function(jqXHR,textStatus,errorThrown){
		alert(' jqXHR: '+jqXHR+'/n textStatus: '+textStatus+' errorThrown: '+errorThrown+'')
	});
};

function clearFields_patientData1 () {
	$('#slt_NsGrp_duration').val('-1');
	$('#txt_NsGrp_group_name, #txt_NsGrp_leader, #txt_NsGrp_group_site')
		.val('');
	$('.error_message').hide();
};