feature "FEATURE:'Patients' page", js: true do
	background do
		# For authentication, authorization
		page.set_rack_session(confirmed: 'authen_and_in_db', authen: 'good_authen', facility: '0013', user_name: 'First Last')
		# page.set_rack_session(confirmed: 'authen_and_in_db', authen: 'good_authen')
	end
	context "Open patient's page by clicking on Main Menu 'patient' " do
		background do
			@admin3 = create(:user, authen: 'good_authen')
			@admin3 = @admin3.add_role('admin3')
			create(:for_select, code: 'facility', facility: '9999', value: '0013', text: 'Pilgrim' )
			create(:for_select, code: 'facility', facility: '9999', value: '0025', text: 'SCPS')
			create(:for_select, code: 'ward', facility: '0013', value: '81/101', text: '81/101')
			create(:patient, lastname: 'Apatient', facility: '0013', site: '81/101', id: '1111')
			create(:patient, lastname: 'Bpatient', facility: '0013', site: '81/101', id: '2222')
			create(:patient, lastname: 'Apatient', facility: '0025', site: 'a_unit', id: '3333')
			create(:patient, lastname: 'Bpatient', facility: '0025', site: 'a_unit', id: '4444')
			
			visit root_path
			click_link('patients')
		end

		scenario "can see 'Search Criteria' and 'Patients Grid'" do			
			expect(page).to have_content('Search Criteria')
			expect(page).to have_content('Patients')
		end

		scenario "'Patients Grid' populated with all Patients" do
			expect(page).to have_content('Apatient')
			expect(page).to have_content('Bpatient')
		end

		context "Filtering 'Patients grid'" do
			scenario "successfully 'like' filter with a single attribute" do
				fill_in('ftx_S_lastname', with: 'Apatient')
				page.execute_script("$('form#fPatientSearch').submit()")
				expect(page).to have_content('Apatient')
				expect(page).not_to have_content('Bpatient')
				# save_and_open_page
			end
			scenario "successfull 'and' filter with multiple attributes" do			
				fill_in('ftx_S_lastname', with: 'A')
				page.select('SCPS', :from => 'slt_S_facility')
				expect(page).to have_content('Apatient')
				expect(page).to have_content('a_unit')
				expect(page).not_to have_content('Bpatient')
				expect(page).not_to have_content('0013')
				# save_and_open_page
			end
		end

		context "Adding New Patient" do
			background do
				# page.find(:css, ".ui-pg-div").click()
				page.execute_script("
					facility = $('#slt_F_facility').val();
					clearFields();
					$('#divPatientAsideRt, #bPatientSubmit, #bPatientBack').show();
					$('#bPatientSubmit').attr('value','New');
					")
			end
			scenario "New Patient Form appears to Right of Select/Grid" do		
				within('#divPatientAsideRt') do
					expect(page).to have_content('Patient Data')
					expect(page).to have_button('New')
				end
			end

			scenario "Correctly filling all validated fields creates new Paient" do
				within("#fPatientAsideRt") do
						fill_in('txt_Pat_firstname', with: 'Joseph')
						fill_in('txt_Pat_lastname', with: 'Soap')
						fill_in('txt_Pat_number', with: '12345')
						page.select('Pilgrim', :from =>'slt_F_facility')
						page.select('81/101', :from =>'slt_F_ward')
						fill_in('dt_Pat_DOA', with: '2015-11-10')
						click_button('New')
						expect(page).not_to have_content('Please')
						# save_and_open_page
					end
				within("#divGrid") do
					# Will only be in this container if successfully added to database
					# And then found and entered into grid
					expect(page).to have_content('Joseph')
				end		
			end

			scenario "Failing to fill all validated fields raises client-side error" do
				within("#fPatientAsideRt") do
					fill_in('txt_Pat_firstname', with: 'Firstname')
					click_button('New')
					expect(page).to have_content('Please enter Last Name')
					# save_and_open_page
				end
			end
		end

		context "Editing existing Patient" do
			background do
				# clicks jqGrid row with id=1111
				page.execute_script("$('#1111').click()")

			# page.execute_script("
			# 	id = 1111
			# 	$('#Pat_ID').val(id);  //set the ID variable
			# 	data_for_params = {patient: {id: id}}

			# 	$.ajax({ 
			# 			  // url: '/inpatient_show',
			# 			  url: '/patients/'+id+'',
			# 			  data: data_for_params,
			# 			  //type: 'POST',
			# 			  type: 'GET',
			# 			  cache: false,
			# 			  dataType: 'json'
			# 		}).done(function(data){
			# 			clearFields();
			# 			$('#bPatientSubmit').attr('value','Edit');
			# 			$('#divPatientAsideRt, #bPatientSubmit, #bPatientBack').show();
			# 			$('#id').val(data.id);
			# 			$('#txt_Pat_firstname').val(data.firstname);
			# 			$('#txt_Pat_lastname').val(data.lastname);
			# 			if ($('#all-facilities').val() !== 'true'){
			# 				$('#txt_Pat_lastname').prop('disabled', true)
			# 									.css({'background-color': '#E0E0E0'})
			# 			};
			# 			$('#txt_Pat_number').val(data.identifier);
			# 			$('#slt_F_facility').val(data.facility);	
			# 			if ($('#all-facilities').val() == 'true') {
			# 				// IF ADMIN-3 - need to first populate slt_F_ward as table can include any facililty
			# 				$('#slt_F_ward').mjm_addOptions('ward', {
			# 					firstLine: 'All Wards', 
			# 					facility: data.facility,
			# 					complete: function(){
			# 						$('#slt_F_ward').val(data.site);
			# 				}
			# 			});
			# 			}else {
			# 				//If not ADMIN-3, can populate slt_F_ward with session-facility in begining and so
			# 					//just choose the ward here.
			# 				$('#slt_F_ward').val(data.site);	
			# 			};
			# 			// $('#dt_Pat_DOA').val(data.doa)
			# 			$('#dt_Pat_DOA').val(moment(data.doa,'YYYY-MM-DD').format('YYYY-MM-DD'));
			# 			$('#dt_Pat_DOB').val(moment(data.dob, 'YYYY-MM-DD').format('YYYY-MM-DD'));
			# 			$('#dt_Pat_DOD').val(moment(data.dod, 'YYYY-MM-DD').format('YYYY-MM-DD'));
								  
			# 		}).fail(function(){
			# 			alert('Error in: /inpatient');
			# 		});
			# 	")
			
			end
			scenario "Edit Patient Form appears to Right of Select/Grid" do				
				within('#divPatientAsideRt') do
					expect(page).to have_content('Patient Data')
					expect(page).to have_button('Edit')
				end
			end

			# scenario "Correctly filling all validated fields edits an existing Paient" do
			# 	within("#fPatientAsideRt") do
			# 			fill_in('txt_Pat_firstname', with: 'Joseph')
			# 			fill_in('txt_Pat_lastname', with: 'Soap')
			# 			fill_in('txt_Pat_number', with: '12345')
			# 			# page.select('Pilgrim', :from =>'slt_F_facility')
			# 			# page.select('81/101', :from =>'slt_F_ward')
			# 			fill_in('dt_Pat_DOA', with: '2015-11-10')
			# 			click_button('Edit')
			# 			expect(page).not_to have_content('Please')
			# 			# save_and_open_page
			# 		end
			# 	within("#divGrid") do
			# 		# Will only be in this container if successfully added to database
			# 		# And then found and entered into grid
			# 		expect(page).to have_content('Joseph')
			# 	end		
			# end

			scenario "Failing to fill all validated fields raises client-side error" do
				within("#fPatientAsideRt") do
					fill_in('txt_Pat_firstname', with: nil)
					click_button('Edit')
					expect(page).to have_content('Please enter First Name')
					# save_and_open_page
				end
			end
		end

	end
	context "Selects (dropdowns)" do
		context "User has 'all-facility' privileges" do
			background do
				@admin3 = create(:user, authen: 'good_authen')
				@admin3 = @admin3.add_role('admin3')
				create(:for_select, code: 'facility', facility: '9999', value: '0013', text: 'Pilgrim' )
				create(:for_select, code: 'facility', facility: '9999', value: '0025', text: 'SCPS')
				create(:for_select, code: 'ward', facility: '0013', value: '81/101', text: '81/101')
				create(:patient, lastname: 'Apatient', facility: '0013', site: '81/101')
				create(:patient, lastname: 'Bpatient', facility: '0013', site: '81/101')
				visit root_path
				click_link('patients')
			end
			context "In 'Search' form" do
				scenario "'Facility' populated with all facilities" do
					# expect(page).to have_content('Pilgrim')
					expect(page).to have_select('slt_S_facility', :with_options => ['Pilgrim', 'SCPS'])
				end

				scenario "'Ward' contains ward from chosen 'Facility'" do
					# Works with Selenium
					page.select('Pilgrim', :from =>'slt_S_facility')
					expect(page).to have_select('slt_S_ward', :with_options => ['81/101'])
					# NB: CAN'T GET THIS TO WORK For Poltergeist				
					# find('#slt_S_facility').find('option[value = "0013"]').select_option
					# page.find_by_id('slt_S_facility').find("option[value='0013']").select_option
					# select_by_value('slt_S_facility', '0013') #Requires helper method http://stackoverflow.com/questions/12265174/select-an-option-by-value-not-text-in-capybara
				end
			end
			context "In 'Patient' form (new, edit)" do
			end
			
		end

		context "User does not have 'all-facility' privileges" do
			background do
				@admin3 = create(:user, authen: 'good_authen')
				@admin3 = @admin3.add_role('pat_crud')
				create(:for_select, code: 'facility', facility: '9999', value: '0013', text: 'Pilgrim' )
				create(:for_select, code: 'facility', facility: '9999', value: '0025', text: 'SCPS')
				create(:for_select, code: 'ward', facility: '0013', value: '81/101', text: '81/101')
				create(:patient, lastname: 'Apatient', facility: '0013', site: '81/101')
				create(:patient, lastname: 'Bpatient', facility: '0013', site: '81/101')
				visit root_path
				click_link('patients')
			end
			context "In 'Search' form" do
				scenario "'Facility' select is disabled. Shows users' facility only" do
					expect(page).to have_select('slt_S_facility', disabled: true)
					# If look at text - gives all options not just that selected
					expect(find(:css, 'select#slt_S_facility').value).to eq('0013')
					# save_and_open_page
				end

				scenario "'Ward' select contains wards from selected Facility" do
					expect(page).to have_select('slt_S_ward', :with_options => ['81/101'])
				end	
			end
			context "In 'Patient' form (new, edit)" do
			end
		end
	end
end