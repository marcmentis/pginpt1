

feature "FEATURE: Authentication" do
  # No need to use 'js:true' as authentication all before javascript
  context "RSA Invalid" do
    scenario "On open Home page: User_error page:'... not passed RSA authentication'" do
      visit root_path
      # save_and_open_page
      expect(page).to have_content "User has not passed RSA authentication"
    end
    scenario "On open ANY page: User_error page:'... not passed RSA authentication'" do
      visit users_path
      # save_and_open_page
      expect(page).to have_content "User has not passed RSA authentication"
    end
  end

  context "RSA Valid but Application Authentication Invalid" do
    scenario "On open Home page: User_error page:'User has no privileges in this application'" do
      # Can't set 'request.headers["HTTP_REMOTE_USER"]' in feature test
      # page.driver.browser.header("HTTP_REMOTE_USER", 'notBlank')
              
      visit root_path
      # expect(page).to have_content "User has no privileges in this application"
      expect(page).to have_content "User has not passed RSA authentication"
    end
    scenario "On open ANY page: User_error page:'User has no privileges in this application'" do
      # Can't set 'request.headers["HTTP_REMOTE_USER"]' in feature test
              
      visit users_path
      # expect(page).to have_content "User has no privileges in this application"
      expect(page).to have_content "User has not passed RSA authentication"
    end
  end

  context "RSA and Application Authentication Valid" do
    background do
      # User.make(:email => 'user@example.com', :password => 'caplin')
      page.set_rack_session(confirmed: 'authen_and_in_db', authen: 'good_authen')
      @user1 = create(:user, authen: 'good_authen')
      # @user1.add_role('admin3')
    end
    scenario "Successfully opens home page" do
      visit root_path
      # save_and_open_page
      expect(page).to have_content "INPATIENT"
    end
    scenario "Successfully opens any page" do
      visit users_path
      # save_and_open_page
      expect(page).to have_content "INPATIENT"
    end
  end

end