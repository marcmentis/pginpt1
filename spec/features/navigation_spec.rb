

feature "FEATURE: Navigation" do
	background do
      page.set_rack_session(confirmed: 'authen_and_in_db', authen: 'good_authen')
      @user1 = create(:user, authen: 'good_authen')
      # @user1.add_role('admin3')
    end

    context "'home' menu item" do
    	scenario "Visible to user without any privileges" do
	    	# @user1.add_role('admin3')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('home')
	    end
	    scenario "Visible to user with any privilege" do
	    	@user1.add_role('nav_notes')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('home')
	    end    
    end

    context "'notes' menu item" do
	    scenario "Visible to user with 'nav_notes' privileges" do
	    	@user1.add_role('nav_notes')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('notes')
	    end
	    scenario "Visible to user with 'admin3' privileges" do
	    	@user1.add_role('admin3')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('notes')
	    end
	    scenario "Invisible to user without any of above privileges" do
	    	# @user1.add_role('admin3')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).not_to have_content('notes')
	    end
    end

    context "'trackers' menu item" do
	    scenario "Visible to user with 'nav_trackers' privileges" do
	    	@user1.add_role('nav_trackers')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('trackers')
	    end
	    scenario "Visible to user with 'admin3' privileges" do
	    	@user1.add_role('admin3')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('trackers')
	    end
	    scenario "Invisible to user without any of above privileges" do
	    	# @user1 has no privileges
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).not_to have_content('trackers')
	    end
    end
    
    context "'patients' menu item" do
	    scenario "Visible to user with 'pat_crud' privileges" do
	    	@user1.add_role('pat_crud')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('patients')
	    end
	    scenario "Visible to user with 'pat_cru' privileges" do
	    	@user1.add_role('pat_cru')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('patients')
	    end
	    scenario "Visible to user with 'admin3' privileges" do
	    	@user1.add_role('admin3')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('patients')
	    end
	    scenario "Invisible to user without any of above privileges" do
	    	# @user1.add_role('admin3')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).not_to have_content('patients')
	    end
    end

    context "'admin' menu item" do
	    scenario "Visible to user with 'nav_admin' privileges" do
	    	@user1.add_role('nav_admin')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('admin')
	    end
	    scenario "Visible to user with 'admin3' privileges" do
	    	@user1.add_role('admin3')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('admin')
	    end
	    scenario "Visible to user with 'admin2' privileges" do
	    	@user1.add_role('admin2')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('admin')
	    end
	    scenario "Visible to user with 'admin1' privileges" do
	    	@user1.add_role('admin1')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('admin')
	    end
	    scenario "Invisible to user without any of above privileges" do
	    	# @user1 has no privileges
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).not_to have_content('admin')
	    end
    end

    context "notes - BioPsychoSocial Assessment" do
    	scenario "Visible to user with 'bps_crud' privileges" do
	    	@user1.add_role('bps_crud')
	    	visit root_path
	    	expect(page.find('#notesBPSAssessment')).to have_content('BioPsychoSocial Assessment')
	    end
	    scenario "Visible to user with 'bps_cru' privileges" do
	    	@user1.add_role('bps_cru')
	    	visit root_path
	    	expect(page.find('#notesBPSAssessment')).to have_content('BioPsychoSocial Assessment')
	    end
	    scenario "Visible to user with 'admin3' privileges" do
	    	@user1.add_role('admin3')
	    	visit root_path
	    	expect(page.find('#notesBPSAssessment')).to have_content('BioPsychoSocial Assessment')
	    end
	    scenario "Visible to user with 'admin2' privileges" do
	    	@user1.add_role('admin2')
	    	visit root_path
	    	expect(page.find('#notesBPSAssessment')).to have_content('BioPsychoSocial Assessment')
	    end
	    scenario "Invisible to user without any of above privileges" do
	    	# @user1 has no privileges
	    	visit root_path
	    	expect(page.find('#notesBPSAssessment')).not_to have_content('BioPsychoSocial Assessment')
	    end
    end

    context "tracker - BioPsychoSocial Assessment" do
    	scenario "Visible to user with 'bps_track' privileges" do
	    	@user1.add_role('bps_track')
	    	visit root_path
	    	expect(page.find('#trackerBPSAssessment')).to have_content('BioPsychoSocial Assessment')
	    end
    	scenario "Visible to user with 'bps_crud' privileges" do
	    	@user1.add_role('bps_crud')
	    	visit root_path
	    	expect(page.find('#trackerBPSAssessment')).to have_content('BioPsychoSocial Assessment')
	    end
	    scenario "Visible to user with 'bps_cru' privileges" do
	    	@user1.add_role('bps_cru')
	    	visit root_path
	    	expect(page.find('#trackerBPSAssessment')).to have_content('BioPsychoSocial Assessment')
	    end
	    scenario "Visible to user with 'admin3' privileges" do
	    	@user1.add_role('admin3')
	    	visit root_path
	    	expect(page.find('#trackerBPSAssessment')).to have_content('BioPsychoSocial Assessment')
	    end
	    scenario "Visible to user with 'admin2' privileges" do
	    	@user1.add_role('admin2')
	    	visit root_path
	    	expect(page.find('#trackerBPSAssessment')).to have_content('BioPsychoSocial Assessment')
	    end

	    scenario "Invisible to user without any of above privileges" do
	    	# @user1 has no privileges
	    	visit root_path
	    	expect(page.find('#trackerBPSAssessment')).not_to have_content('BioPsychoSocial Assessment')
	    end
    end

    context "admin - users" do
	    scenario "Visible to user with 'admin3' privileges" do
	    	@user1.add_role('admin3')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('users')
	    end
	    scenario "Visible to user with 'admin2' privileges" do
	    	@user1.add_role('admin2')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('users')
	    end
	    scenario "Visible to user with 'admin1' privileges" do
	    	@user1.add_role('admin1')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('users')
	    end
	    scenario "Visible to user with 'for_select' privileges" do
	    	@user1.add_role('for_select')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('users')
	    end

	    scenario "Invisible to user without any of above privileges" do
	    	# @user1 has no privileges
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).not_to have_content('users')
	    end
    end
    context "admin - for_select" do
	    scenario "Visible to user with 'admin3' privileges" do
	    	@user1.add_role('admin3')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('for_select')
	    end
	    scenario "Visible to user with 'admin2' privileges" do
	    	@user1.add_role('admin2')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('for_select')
	    end
	    scenario "Visible to user with 'admin1' privileges" do
	    	@user1.add_role('admin1')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('for_select')
	    end
	    scenario "Visible to user with 'for_select' privileges" do
	    	@user1.add_role('for_select')
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).to have_content('for_select')
	    end

	    scenario "Invisible to user without any of above privileges" do
	    	# @user1 has no privileges
	    	visit root_path
	    	expect(page.find('#layoutNavigation')).not_to have_content('for_select')
	    end
    end
end