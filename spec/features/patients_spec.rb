feature "FEATURE:'Patients' page", js: true do
	background do
		page.set_rack_session(confirmed: 'authen_and_in_db', authen: 'good_authen', admin3: true, facility: '0013', user_name: 'First Last')
		# page.set_rack_session(confirmed: 'authen_and_in_db', authen: 'good_authen')
	end
	context "User with Full Privileges" do
		background do
			@admin3 = create(:user, authen: 'good_authen')
			@admin3 = @admin3.add_role('admin3')
			create(:for_select, code: 'facility', facility: '9999', value: '0013', text: 'Pilgrim' )
			create(:for_select, code: 'facility', facility: '9999', value: '0025', text: 'SCPS')
			create(:for_select, code: 'ward', facility: '0013', value: '81/101', text: '81/101')
			visit patients_path
		end
		scenario "can see Search Criteria and Patients Grid" do			
			expect(page).to have_content('Search Criteria')
			expect(page).to have_content('Patients')
		end

		scenario " has 'Facility' populated with all facilities" do
			# expect(page).to have_content('Pilgrim')
			expect(page).to have_select('slt_S_facility', :with_options => ['Pilgrim', 'SCPS'])
		end

		scenario "can populate 'Ward' select after clicking in 'Facility'" do
			# See if can find a "RSpec selector for the select"
			page.select('Pilgrim', :from =>'slt_S_facility')			
			expect(page).to have_select('slt_S_ward', :with_options => ['81/101'])
		end

		# scenario "can open 'new' patient form" do

			
		# 	# find_field('New').click
		# 	# save_and_open_page

		# 	expect(page).to have_content('New')
		# 	expect(page).to have_content('Patient Data')
		# end
	end
end