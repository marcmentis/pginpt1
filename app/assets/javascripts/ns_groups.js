$(function(){
if($('body.ns_groups').length) {

	//STYLING
		//DIV
		$('#divNsGroupPageWrapper')
			.addClass('pad_3_sides')
		$('#divNsGroupPageInnerWrapper')
			.addClass('centered')
			.css({'max-width': '980px'})

		$('#divNsGrpTitle')
			.css({'text-align': 'center',
					'color': '#2e6e9e',
					'font-size': '17px',
					'font-weight': 'bold',
					'margin': '0 0 7px 0'});
		$('#divSpacerDateSearch')
			.css({'margin': '0 0 15px 0'})
		$('#divSearchAndGrid').hide();

		//forms
		$('#fNsGrpDate, #fNsGrpSearch')
			.addClass('form_container')
			// .css({'width': '275px'})

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

		// BUTTONS
		//Submit complex search on fPatientSearch using hidden submit button
			// $('#btnSubmit').click(function(e){
			$('#fNsGrpSearch').submit(function(e){
				e.preventDefault();
				complex_search_NsGrp();
			});

		//DATES
		$('#dt_NsGrp_g').change(function(){
			$('#divSearchAndGrid').show();
		})

	// RUN ON OPENING
	complex_search_NsGrp()
}
})