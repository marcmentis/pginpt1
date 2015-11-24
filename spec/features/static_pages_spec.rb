# require 'rails_helper'

feature "Home Page and NAVIGATION" do
  background do
    # User.make(:email => 'user@example.com', :password => 'caplin')
    page.set_rack_session(confirmed: 'authen_and_in_db', authen: 'pgauthen')
    @user1 = create(:user, authen: 'pgauthen')
    @user1.add_role('admin3')
  end

  scenario "Opening home page", js: true do
  	page.set_rack_session(admin3: true)
  	visit root_path
  	save_and_open_page
	expect(page).to have_content "INPATIENT"
   
  end

  # given(:other_user) { User.make(:email => 'other@example.com', :password => 'rous') }

  # scenario "Signing in as another user" do
  #   visit '/sessions/new'
  #   within("#session") do
  #     fill_in 'Email', :with => other_user.email
  #     fill_in 'Password', :with => other_user.password
  #   end
  #   click_button 'Sign in'
  #   expect(page).to have_content 'Invalid email or password'
  # end
end


	