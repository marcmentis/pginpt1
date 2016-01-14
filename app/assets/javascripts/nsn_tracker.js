$(function(){
if ($('body.nsn_tracker').length) {
	//VARIABLES
		var user_facility = $('#session-facility').val();
		var user_id = $('#session-authen').val();
		var user_name = $('#session-username').val();

		//textareas
		var heightS1 = '90';
		var heightL1 = '180';
		var heightEL1 = '360';

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
						.css({'width': '60%'})
		$('#fNsnTpat_info').addClass('form_container')
						.css({'width': '100%'})

		//texts

		//textareas

		//buttons

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

};  //if ($('body.nsn_tracker').length) {
}); //$(function(){