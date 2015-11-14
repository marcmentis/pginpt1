# require 'rails_helper'

# 	feature 'Home Page' do
#     	# given(:valid_session){{confirmed: 'authen_and_in_db'}}
# 		scenario 'Visit Home Page' do
# 			page.set_rack_session(confirmed: 'authen_and_in_db')
# 			allow(view).to receive(:policy).and_return double(namv_notes?: true)
# 			visit root_path
# 			expect(page).to have_content "Inpatient"
# 		end
# 	end



# feature 'User management' do
# 	scenario "adds a new user" do
# 		visit users_path

# 		# save_and_open_page
# 	end
# end