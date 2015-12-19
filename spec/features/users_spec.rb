feature "FEATURE:'Users' page", js: true, a_feature: true do
	background do
		# For authentication, authorization
		page.set_rack_session(confirmed: 'authen_and_in_db', authen: 'good_authen', facility: '0013', user_name: 'First Last')
		# page.set_rack_session(confirmed: 'authen_and_in_db', authen: 'good_authen')
	end

	context "Open users' page by clicking on Main Menu 'admin'/'users' " do
		background do
			@Auser = create(:user, lastname: 'Auser', authen: 'good_authen', facility: '0013', id: '1111')
			@Auser = @Auser.add_role('admin3')
			create(:user, lastname: 'Buser', authen: 'pgbuser', facility: '0013', id: '2222')
			create(:user, lastname: 'Cuser', authen: 'pgCuser', facility: '0013', id: '3333')
			create(:user, lastname: 'Buser', authen: 'chbuser', facility: '0025', id: '4444')
			create(:user, lastname: 'Cuser', authen: 'chCuser', facility: '0025', id: '5555')

			create(:for_select, code: 'facility', facility: '9999', value: '0013', text: 'Pilgrim' )
			create(:for_select, code: 'facility', facility: '9999', value: '0025', text: 'SCPS')
			create(:for_select, code: 'ward', facility: '0013', value: '81/101', text: '81/101')
			
			visit root_path
			click_link('admin')
			click_link('users')
		end

		scenario "can see 'Search Criteria' and 'Users Grid'" do			
			expect(page).to have_content('Search Criteria')
			expect(page).to have_content('Users')
			# save_and_open_page
		end

		scenario "'Users Grid' populated with all Users" do
			expect(page).to have_content('Auser')
			expect(page).to have_content('Buser')
			expect(page).to have_content('Cuser')
		end

		context "Filtering 'Users grid'" do
			scenario "successfull 'like' filter with a single attribute" do
				fill_in('ftx_user_S_lastname', with: 'Auser')
				page.execute_script("$('form#fUserSearch').submit()")
				expect(page).to have_content('Auser')
				expect(page).not_to have_content('Buser')
				# save_and_open_page
			end
			scenario "successfull 'and' filter with multiple attributes" do			
				fill_in('ftx_user_S_lastname', with: 'B')
				page.select('Pilgrim', :from => 'slt_user_S_facility')
				expect(page).to have_content('Buser')
				expect(page).to have_content('0013')
				expect(page).not_to have_content('Cuser')
				expect(page).not_to have_content('Auser')
				expect(page).not_to have_content('0025')
				# save_and_open_page
			end
		end

		context "Adding New User" do
			background do
				# page.find(:css, ".ui-pg-div").click()
				page.execute_script("
						reset_ID();	
						user_clearFields();
						roles_clearFields();
						$('#divUserAsideRt, #b_user_Rt_Submit, #b_user_Rt_Back').show();
						$('#b_user_Rt_Submit').attr('value','New');
					")
			end
			scenario "New User Form appears to Right of Select/Grid" do		
				within('#divUserAsideRt') do
					expect(page).to have_content('User Data')
					expect(page).to have_button('New')
				end
			end

			scenario "Correctly filling all validated fields creates new Paient" do
				within("#fUserAsideRt") do
						page.select('Pilgrim', :from =>'slt_user_Rt_facility')
						fill_in('ftx_user_Rt_firstname', with: 'Joseph')
						fill_in('ftx_user_Rt_lastname', with: 'Soap')
						fill_in('ftx_user_Rt_authen', with: 'pgjsoap')
						fill_in('ftx_user_Rt_email', with: 'some@email')
						fill_in('ftx_user_Rt_firstinitial', with: 'J')
						click_button('New')
						expect(page).not_to have_content('Please')
						# save_and_open_page
					end
				within("#divUserGrid") do
					# Will only be in this container if successfully added to database
					# And then found and entered into grid
					expect(page).to have_content('Joseph')
				end		
			end

			scenario "Failing to fill all validated fields raises client-side error" do
				within("#fUserAsideRt") do
					fill_in('ftx_user_Rt_firstname', with: 'Firstname')
					click_button('New')
					expect(page).to have_content('Please choose Facility')
					# save_and_open_page
				end
			end
		end

		context "Editing existing User" do
			background do
				# clicks jqGrid row with id=1111
				page.execute_script("$('#1111').click()")		
			end

			scenario "Edit User Form appears to Right of Select/Grid" do				
				within('#divUserAsideRt') do
					expect(page).to have_content('User Data')
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

			scenario "Failing to fill all validated fields raises client-side error" do
				within("#fUserAsideRt") do
					fill_in('ftx_user_Rt_firstname', with: '')
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
				@Auser = create(:user, lastname: 'Auser', authen: 'good_authen', facility: '0013')
				@Auser = @Auser.add_role('admin3')
				create(:user, lastname: 'Buser', authen: 'pgbuser', facility: '0013')
				create(:user, lastname: 'Cuser', authen: 'pgCuser', facility: '0013')
				create(:user, lastname: 'Buser', authen: 'chbuser', facility: '0025')
				create(:user, lastname: 'Cuser', authen: 'chCuser', facility: '0025')

				create(:for_select, code: 'facility', facility: '9999', value: '0013', text: 'Pilgrim' )
				create(:for_select, code: 'facility', facility: '9999', value: '0025', text: 'SCPS')
				create(:for_select, code: 'ward', facility: '0013', value: '81/101', text: '81/101')
				
				visit root_path
				click_link('admin')
				click_link('users')
			end
			context "In 'Search' form" do
				scenario "'Facility' populated with all facilities" do
					# expect(page).to have_content('Pilgrim')
					expect(page).to have_select('slt_user_S_facility', :with_options => ['Pilgrim', 'SCPS'])
				end

			end
			context "In 'Users' form (new, edit)" do
				scenario "'Facility' populated with all facilities" do
					page.execute_script("
							reset_ID();	
							user_clearFields();
							roles_clearFields();
							$('#divUserAsideRt, #b_user_Rt_Submit, #b_user_Rt_Back').show();
							$('#b_user_Rt_Submit').attr('value','New');
						")
					expect(page).to have_select('slt_user_Rt_facility', :with_options => ['Pilgrim', 'SCPS'])
				end			
			end
			
		end

		context "User does not have 'all-facility' privileges" do
			background do
				@Auser = create(:user, lastname: 'Auser', authen: 'good_authen', facility: '0013')
				@Auser = @Auser.add_role('admin1')
				create(:user, lastname: 'Buser', authen: 'pgbuser', facility: '0013')
				create(:user, lastname: 'Cuser', authen: 'pgCuser', facility: '0013')
				create(:user, lastname: 'Buser', authen: 'chbuser', facility: '0025')
				create(:user, lastname: 'Cuser', authen: 'chCuser', facility: '0025')

				create(:for_select, code: 'facility', facility: '9999', value: '0013', text: 'Pilgrim' )
				create(:for_select, code: 'facility', facility: '9999', value: '0025', text: 'SCPS')
				create(:for_select, code: 'ward', facility: '0013', value: '81/101', text: '81/101')
				
				visit root_path
				click_link('admin')
				click_link('users')
			end
			context "In 'Search' form" do
				scenario "'Facility' select is disabled. Shows users' facility only" do
					expect(page).to have_select('slt_user_S_facility', disabled: true)
					# If look at text - gives all options not just that selected
					expect(find(:css, 'select#slt_user_S_facility').value).to eq('0013')
					# save_and_open_page
				end
			end
			context "In 'Users' form (new, edit)" do
				scenario "'Facility' populated with all facilities" do
					page.execute_script("
							reset_ID();	
							user_clearFields();
							roles_clearFields();
							$('#divUserAsideRt, #b_user_Rt_Submit, #b_user_Rt_Back').show();
							$('#b_user_Rt_Submit').attr('value','New');
						")
					expect(page).to have_select('slt_user_Rt_facility', disabled: true)
					# If look at text - gives all options not just that selected
					expect(find(:css, 'select#slt_user_Rt_facility').value).to eq('0013')
				end		
			end
		end
	end

end