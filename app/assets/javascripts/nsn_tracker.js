$(function(){
if ($('body.nsn_tracker').length) {
	//VARIABLES
		var user_facility = $('#session-facility').val();
		var user_id = $('#session-authen').val();
		var user_name = $('#session-username').val();

		//textareas
		var heightS1 = '360';
		var heightL1 = '560';
		var heightEL1 = '760';

	//STYLING
		//divs
		$('#divNsnTPageWrapper')
			.addClass('pad_3_sides');
		$('#divNsnTPageInnerWrapper')
			.addClass('centered')
			.css({'max-width': '1000px'})
		$('#div_NsnTTitle')
			.css({'text-align': 'center',
					'color': '#2e6e9e',
					'font-size': '17px',
					'font-weight': 'bold',
					'margin': '0 0 7px 0'});

		//selects
		$('[id^=slt_]')
			.css({'width': '125px'})

		//forms
		$('#fNsnTsearch').addClass('form_container')
						.css({'width': '70%'})
		$('#fNsnTpat_info').addClass('form_container')
						.css({'width': '100%'})

		//texts

		//textareas
		$('#txa_NsnT_Comments')
			.addClass('text-content left')
			.width('92%')
			.height(heightS1);
		$('#txa_NsnT_Aggregate')
			.addClass('text-content left')
			.width('92%')
			.height(heightS1);

		//buttons
		$('[id^=bt_]').button().addClass('reduce_button')

		//dates
		$('[id^=dt]')
			.datepicker({
				dateFormat: 'yy-mm-dd',
				changeMonth: true,
				changeYear: true,
				yearRange: "-100: +10" })
			.addClass('texts')
			.css({'width':'7em'});

	//SELECT HANDLERS
		//populate selects
		$('#slt_NsnT_ward').mjm_addOptions('ward', {firstLine: 'Wards', facility: user_facility, group: true})

		//Populate Patient select when ward is selected
		$('#slt_NsnT_ward').change(function(){
			var site = $('#slt_NsnT_ward').val();
			var slt_name = 'slt_NsnT_patient'

			//'Useful_function'
			//Get Pat C# and name and populate ward select
			get_site_pats_pop_pat_select (site, slt_name)
		});	

	//BUTTON HANDLERS
		//Toggle handlers
		$('#bt_NsnT_togAggregate').click(function(){
			element = $('#txa_NsnT_Aggregate');
			tripleToggle(element, heightS1, heightL1, heightEL1)
		});
		$('#bt_NsnT_togComments').click(function(){
			element = $('#txa_NsnT_Comments');
			tripleToggle(element, heightS1, heightL1, heightEL1)
		});

		// Note Search for Patient
		$('#slt_NsnT_ward, #slt_NsnT_patient, #dt_NsnT_after, #dt_NsnT_before').change(function(e){		
			//Validate - no empty inputs
			var ward = $('#slt_NsnT_ward').val();
			var patient_id = $('#slt_NsnT_patient').val();
			var date_after = $('#dt_NsnT_after').val();
			var date_before = $('#dt_NsnT_before').val();
			if ((ward == '-1') ||(date_after == '') || (date_before == '')
			 || (patient_id == '-1') || (patient_id == null) ){
				return true
			};
			//Get all patient notes
			NsnT_pat_notes_groups(patient_id, date_after, date_before)
			// MxAw_complex_search1(user_facility);
		});


};  //if ($('body.nsn_tracker').length) {
}); //$(function(){