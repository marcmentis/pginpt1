$(function(){
if($('body.ns_groups').length) {
	//VARIABLES
		var user_facility = $('#session-facility').val();
		var user_id = $('#session-authen').val();
		var user_name = $('#session-username').val();

	//STYLING
		//DIV
		$('#divNsGroupPageWrapper')
			.addClass('pad_3_sides')
		$('#divNsGroupPageInnerWrapper')
			.addClass('centered')
			.css({'max-width': '1200px'})

		$('#divNsGrpTitle')
			.css({'text-align': 'center',
					'color': '#2e6e9e',
					'font-size': '17px',
					'font-weight': 'bold',
					'margin': '0 0 7px 0'});

		$('#divSearchAndGrid, #divNsGrpNewEdit, #divFormNsGrpCurrentGrp, #divNsGrpToDoDone, #divNsGrpNotes')
			.addClass('nsgroup_div_spacer1')
			.hide();
		$('#NsGrpsNewEditErrors')
			.addClass('error_explanation')
			.hide();


		//forms
		$('#fNsGrpDate, #fNsGrpSearch, #fNsGrpNewEdit, #divFormNsGrpCurrentGrp, #fToDoDone, #fNotes, #fNsGrpWardPatients')
			.addClass('form_container')
			// .css({'width': '275px'})
		$('#fNsGrpWardPatients')
			.addClass('nsgroup_div_spacer1')

		//selects
		$('#slt_NsGrp_duration').mjm_addOptions('NsGrpDuration', {firstLine: 'Choose'})
		$('#slt_NsGrp_to_do, #slt_NsGrp_done')
			.attr({'size': '10',
				'multiple': 'no'})
			.css({'width': '100%'});

		//button
		$('[id^=bt]').button().addClass('reduce_button')
		// Can't use .hide() as wont work with IE 10
		$('#btnSubmit').addClass('move_off_page')

		//dates
		$('[id^=dt]')
			.datepicker({
				dateFormat: 'yy-mm-dd',
				changeMonth: true,
				changeYear: true,
				yearRange: "-100: +10" })
			.addClass('texts')
			.css({'width':'7em'});

		$('#dt_NsGrp_display')
			.css({'background-color': '#E4E4E4',
				'color': '#5D5D5D',
				'border-color': '#949494'})


		//textboxes
		$('#ftx_GrpName_display')
			.css({'width': '25em',
					'background-color': '#E4E4E4',
					'color': '#5D5D5D',
					'border-color': '#B5B5B5'})
		$('#ftx_GrpDate_display')
			.css({'width': '7em',
					'background-color': '#E4E4E4',
					'color': '#5D5D5D',
					'border-color': '#B5B5B5'})

			// $('#txt-NsGrp-ShowFacility')
			// 	.prop('readonly', true)
			// 	.css({'width': '7em', 
			// 			'background-color': '#F5F5F5',
			// 			'text-align': 'center',
			// 			'color': '#2e6e9e'})
		

		//DATES
		$('#dt_NsGrp_input').change(function(){
			$('#divSearchAndGrid').show();
		})

	//SELECCT HANDLERS
		//populate selects
			$('#slt_NsGrp_ward').mjm_addOptions('ward', {firstLine: 'All Wards', facility: user_facility, group: true})
		//populate patient on ward change
		$('#slt_NsGrp_ward').change(function(e){
			var ward = $(this).val()
			popSelectWard(user_facility, ward)
		})

	//BUTTON HANDLERS
		//Submit complex search on fPatientSearch using hidden submit button
		$('#fNsGrpSearch').submit(function(e){
			e.preventDefault();
			complex_search_nsGrp();
		});
		//Show Facility in title
			// facility = $('#session-facility').val()
			// $('#txt-NsGrp-ShowFacility').val(facility)
		//Submit New/Edit information from input form fNsGrpNewEdit
		$('#fNsGrpNewEdit').submit(function(e){
			e.preventDefault();
			// VALIDATE that the form properly filled out
			validation_array = [
				['slt_NsGrp_duration','-1','Please choose Group Duration'],
				['txt_NsGrp_group_name','','Please enter Group Name'],
				['txt_NsGrp_leader','','Please enter Group Leader'],
				['txt_NsGrp_group_site','','Please enter Group Site']
			]

			//Loop through array and remove error messages if corrected
			remove_error_divs_if_corrected(validation_array)
 			//Loop through array and show error message if '', '-1' etc.
 			exit = validate_elements(validation_array)
 			if (exit) {return true};

 			//Get value of submit button to determine which AJAX call to make
			submit_value = $(this).find('input[type=submit]').attr('value')
			// alert(submit_value)
			switch(submit_value){
				case 'New':
					nsGrp_ajax1('/ns_groups/', 'POST');
					break;
				case 'Edit':
					ID = $('#nsGrp_ID').val();
					nsGrp_ajax1('/ns_groups/'+ID+'', 'PATCH');
					break;
				default:
					alert('submit_id not found');
					return false;
			};
		});

		//Close PatientData and clear fields
		$('#btNsGrpBack').click(function(){
			clearFields_patientData1();
			$('#divNsGrpNewEdit').hide();
		});

	// RUN ON OPENING
	complex_search_nsGrp()
}
})