feature "FEATURE:'ForSelect' page", js: true, a_feature: true do
	background do
		# For authentication, authorization
		page.set_rack_session(confirmed: 'authen_and_in_db', authen: 'good_authen', facility: '0013', user_name: 'First Last')
		# page.set_rack_session(confirmed: 'authen_and_in_db', authen: 'good_authen')
	end

	context "Open 'for_selects' page by clicking on Main Menu 'admin'/'for_selects' " do
		background do
			@Auser = create(:user, lastname: 'Auser', authen: 'good_authen', facility: '0013', id: '1111')
			@Auser = @Auser.add_role('admin3')
			# create(:user, lastname: 'Buser', authen: 'pgbuser', facility: '0013', id: '2222')
			# create(:user, lastname: 'Cuser', authen: 'pgCuser', facility: '0013', id: '3333')
			# create(:user, lastname: 'Buser', authen: 'chbuser', facility: '0025', id: '4444')
			# create(:user, lastname: 'Cuser', authen: 'chCuser', facility: '0025', id: '5555')

			create(:for_select, code: 'facility', facility: '9999', value: '0013', text: 'Pilgrim', id: '1111' )
			create(:for_select, code: 'facility', facility: '9999', value: '0025', text: 'SCPS', id: '2222')
			create(:for_select, code: 'ward', facility: '0013', value: '81/101', text: '81/101', id: '3333')
			
			visit root_path
			click_link('admin')
			click_link('for_selects')
		end

		scenario "can see 'Search Criteria' and 'For Selects' Grid'"  do			
			expect(page).to have_content('Search Criteria')
			expect(page).to have_content('For Selects')
			# save_and_open_page
		end

		scenario "'For Select' Grid populated with all ForSelects" do
			within('#divGrid_for_selects') do
				expect(page).to have_content('Pilgrim')
				expect(page).to have_content('SCPS')
				expect(page).to have_content('81/101')
			end
		end

		context "Filtering 'For Selects' grid'" do
			scenario "successfull 'like' filter with a single attribute" do
				fill_in('ftx_for_selects_S_code', with: 'f')
				page.execute_script("$('form#fForSelectSearch').submit()")
				expect(page).to have_content('facility')
				expect(page).to have_content('0013')
				expect(page).to have_content('0025')
				expect(page).not_to have_content('ward')
				# save_and_open_page
			end
			scenario "successfull 'and' filter with multiple attributes" do			
				fill_in('ftx_for_selects_S_code', with: 'f')
				fill_in('ftx_for_selects_S_value', with: '0013')
				page.execute_script("$('form#fForSelectSearch').submit()")
				expect(page).to have_content('facility')
				expect(page).to have_content('0013')
				expect(page).not_to have_content('0025')
				expect(page).not_to have_content('ward')
				# save_and_open_page
			end
		end

		context "Adding New ForSelect" do
			background do
				# page.find(:css, ".ui-pg-div").click()
				page.execute_script("
						for_select_clearFields();
						$('#divForSelectAsideRt, #b_for_select_Rt_Submit, #b_for_select_Rt_Back')
								.show();
						$('#b_for_select_Rt_Submit').attr('value','New');
						function for_select_clearFields(){
							$('#ftx_for_select_Rt_code, #ftx_for_select_Rt_value, #ftx_for_select_Rt_text, #ftx_for_select_Rt_grouper, #ftx_for_select_option_order').val('');
							$('#ForSelectAsideRtErrors').html('').hide();
							if ($('#all-facilities').val() == 'true') {
								$('#slt_for_select_Rt_facility').val('-1');
							}else{
								facility = $('#session-facility').val();
								$('#slt_for_select_Rt_facility').val(facility);
							};
						 };
					")
			end
			scenario "New 'For Selects' Form appears to Right of Select/Grid" do		
				within('#divForSelectAsideRt') do
					expect(page).to have_content('For Selects Data')
					expect(page).to have_button('New')
				end
			end

			scenario "Correctly filling all validated fields creates new ForSelect" do
				within("#fForSelectAsideRt") do
						page.select('Pilgrim', :from =>'slt_for_select_Rt_facility')
						fill_in('ftx_for_select_Rt_code', with: 'new_code')
						fill_in('ftx_for_select_Rt_value', with: 'value')
						fill_in('ftx_for_select_Rt_text', with: 'text')
						fill_in('ftx_for_select_option_order', with: 'order')
						click_button('New')
						expect(page).not_to have_content('Please')
						# save_and_open_page
					end
				within("#divGrid_for_selects") do
					# Will only be in this container if successfully added to database
					# And then found and entered into grid
					expect(page).to have_content('new_code')
				end		
			end

			scenario "Failing to fill all validated fields raises client-side error" do
				within("#fForSelectAsideRt") do
					fill_in('ftx_for_select_Rt_code', with: '')
					click_button('New')
					expect(page).to have_content('Please choose Facility')
					# save_and_open_page
				end
			end
		end

		context "Editing existing ForSelect" do
			background do
				# clicks jqGrid row with id=1111
				page.execute_script("$('#1111').click()")		
			end

			scenario "Edit 'For Select' Form appears to Right of Select/Grid" do				
				within('#divForSelectAsideRt') do
					expect(page).to have_content('For Selects Data')
					expect(page).to have_button('Edit')
				end
			end

			# scenario "Correctly filling all validated fields edits an existing Patient", a_failure: true do
			# 	within("#fPatientAsideRt") do
			# 			fill_in('txt_Pat_firstname', with: 'Joseph')
			# 			save_and_open_page
			# 			# fill_in('txt_Pat_lastname', with: 'Soap')
			# 			# fill_in('txt_Pat_number', with: '12345')
			# 			# # page.select('Pilgrim', :from =>'slt_F_facility')
			# 			# # page.select('81/101', :from =>'slt_F_ward')
			# 			# fill_in('dt_Pat_DOA', with: '2015-11-10')
			# 			# click_button('Edit')
			# 			# expect(page).not_to have_content('Please')
			# 		end
			# 	within("#divGrid") do
			# 		# Will only be in this container if successfully added to database
			# 		# And then found and entered into grid
			# 		expect(page).to have_content('Joseph')
			# 	end		
			# end

			# scenario "Failing to fill all validated fields raises client-side error" do
			# 	within("#fForSelectAsideRt") do
			# 		fill_in('ftx_for_select_Rt_code', with: '')
			# 		click_button('Edit')
			# 		expect(page).to have_content('Please choose Facility')
			# 		# save_and_open_page
			# 	end
			# end
		end
	end

	context "Selects (dropdowns)" do
		context "User has 'all-facility' privileges" do
			background do
				@Auser = create(:user, lastname: 'Auser', authen: 'good_authen', facility: '0013', id: '1111')
				@Auser = @Auser.add_role('admin3')
				
				create(:for_select, code: 'facility', facility: '9999', value: '0013', text: 'Pilgrim', id: '1111' )
				create(:for_select, code: 'facility', facility: '9999', value: '0025', text: 'SCPS', id: '2222')
				create(:for_select, code: 'ward', facility: '0013', value: '81/101', text: '81/101', id: '3333')
				
				visit root_path
				click_link('admin')
				click_link('for_selects')
			end
			context "In 'Search' form" do
				scenario "'Facility' populated with all facilities" do
					# expect(page).to have_content('Pilgrim')
					expect(page).to have_select('slt_for_selects_S_facility', :with_options => ['Pilgrim', 'SCPS'])
				end

			end
			context "In 'For Selects' form (new, edit)" do
				scenario "'Facility' populated with all facilities" do
					page.execute_script("
						for_select_clearFields();
						$('#divForSelectAsideRt, #b_for_select_Rt_Submit, #b_for_select_Rt_Back')
								.show();
						$('#b_for_select_Rt_Submit').attr('value','New');
						function for_select_clearFields(){
							$('#ftx_for_select_Rt_code, #ftx_for_select_Rt_value, #ftx_for_select_Rt_text, #ftx_for_select_Rt_grouper, #ftx_for_select_option_order').val('');
							$('#ForSelectAsideRtErrors').html('').hide();
							if ($('#all-facilities').val() == 'true') {
								$('#slt_for_select_Rt_facility').val('-1');
							}else{
								facility = $('#session-facility').val();
								$('#slt_for_select_Rt_facility').val(facility);
							};
						 };
					")
					expect(page).to have_select('slt_for_select_Rt_facility', :with_options => ['Pilgrim', 'SCPS'])
				end			
			end
			
		end

		context "User does not have 'all-facility' privileges" do
			background do
				@Auser = create(:user, lastname: 'Auser', authen: 'good_authen', facility: '0013', id: '1111')
				@Auser = @Auser.add_role('admin1')
				
				create(:for_select, code: 'facility', facility: '9999', value: '0013', text: 'Pilgrim', id: '1111' )
				create(:for_select, code: 'facility', facility: '9999', value: '0025', text: 'SCPS', id: '2222')
				create(:for_select, code: 'ward', facility: '0013', value: '81/101', text: '81/101', id: '3333')
				
				visit root_path
				click_link('admin')
				click_link('for_selects')
			end
			context "In 'Search' form" do
				scenario "'Facility' select is disabled. Shows users' facility only" do
					expect(page).to have_select('slt_for_selects_S_facility', disabled: true)
					# If look at text - gives all options not just that selected
					expect(find(:css, 'select#slt_for_selects_S_facility').value).to eq('0013')
					# save_and_open_page
				end
			end
			context "In 'For Selects' form (new, edit)" do
				scenario "'Facility' populated with all facilities" do
					page.execute_script("
						for_select_clearFields();
						$('#divForSelectAsideRt, #b_for_select_Rt_Submit, #b_for_select_Rt_Back')
								.show();
						$('#b_for_select_Rt_Submit').attr('value','New');
						function for_select_clearFields(){
							$('#ftx_for_select_Rt_code, #ftx_for_select_Rt_value, #ftx_for_select_Rt_text, #ftx_for_select_Rt_grouper, #ftx_for_select_option_order').val('');
							$('#ForSelectAsideRtErrors').html('').hide();
							if ($('#all-facilities').val() == 'true') {
								$('#slt_for_select_Rt_facility').val('-1');
							}else{
								facility = $('#session-facility').val();
								$('#slt_for_select_Rt_facility').val(facility);
							};
						 };
					")
					expect(page).to have_select('slt_for_select_Rt_facility', disabled: true)
					# If look at text - gives all options not just that selected
					expect(find(:css, 'select#slt_for_select_Rt_facility').value).to eq('0013')
				end		
			end
		end
	end

end