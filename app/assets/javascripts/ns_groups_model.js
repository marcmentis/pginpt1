function complex_search_NsGrp (){
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
			{name:"duration",index:"duration",width:15,align:"center",editable:true},
			{name:"groupname",index:"groupname",width:150,align:"center"},
			{name:"leader",index:"leader",width:100,align:"center"},
			{name:"groupsite",index:"groupsite",width:100,align:"center"},
			{name:"facility",index:"facility",width:15,align:"center", hidden:true}
		],
		editurl:"/patient/update",
		pager:"#divPager",
		height:235,
		width: 435,
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
				// set_id(id);  //set the ID variable
				// $('#Pat_ID').val(id);  //set the ID variable
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
				groupID = id;
				alert(groupID)
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
			alert('new')
			// facility = $('#slt_F_facility').val();
			// clearFields();
			// $('#divPatientAsideRt, #bPatientSubmit, #bPatientBack').show();
			// $('#bPatientSubmit').attr('value','New');
		},
		position:'last'
	})
	.navButtonAdd('#divPager', {
		caption: 'Del',
		buttonicon: '',
		onClickButton: function(){	
			alert('delete')
			// for_delete = $('#forDelete').val();
			// if (for_delete == 'true') {
			// 	ID = $('#Pat_ID').val(); 
			// 	if (ID.length > 0) {	
			// 		if(confirm("Are you sure you want to delete this patient")){
			// 			patients_ajax1('/patients/'+ID+'', 'DELETE');	
			// 		} else {
			// 			return true;
			// 		};
			// 	} else{
			// 		alert('No patient has been selected.')
			// 	};
			// }else {
			// 	alert("Sorry, you do not have privileges to delete patients");
			// 	return true;
			// };
		},
		position:'last'
	});
};