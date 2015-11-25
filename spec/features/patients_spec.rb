# feature "FEATURE:'Patients' page" do
# 	background do
# 		page.set_rack_session(confirmed: 'authen_and_in_db', authen: 'good_authen')
# 	end
# 	context "User with Full Privileges" do
# 		background do
# 			@admin3 = create(:user, authen: 'good_authen')
# 			@admin3 = @admin3.add_role('admin3')
# 			create(:for_select, facility: '0013')
# 			create(:for_select, facility: '0025')
			
# 		end
# 		# scenario "can see Search Criteria and Patients Grid" do			
# 		# 	expect(page).to have_content('Search Criteria')
# 		# end

# 		scenario "can open 'new' patient form" do
# 			# find("#session-admin3", visible: false).set(true)

# 			visit patients_path
			
# 			save_and_open_page
# 			click_on('New')
# 			expect(page).to have_content('Patient Data')
# 		end
# 	end
# end