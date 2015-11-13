require 'rails_helper'

	feature 'Home Page' do
    	# given(:valid_session){{confirmed: 'authen_and_in_db'}}
    	session = {confirmed: 'authen_and_in_db'}
		scenario 'Visit Home Page' do
			visit root_path
			expect(page).to have_content "Inpatient"
		end
	end



# feature 'User management' do
# 	scenario "adds a new user" do
# 		visit users_path

# 		# save_and_open_page
# 	end
# end