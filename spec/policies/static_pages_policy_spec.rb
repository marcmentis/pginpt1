describe StaticPagesPolicy do
	# Equivalent to: subject {described_class}
	subject {StaticPagesPolicy}

	context "AUTHORIZATION for Navigation" do

		permissions :nav_notes? do
			context "Grants access if user has following roles/privileges:" do
				it "admin3" do
					user_admin3 = create(:user)
					user_admin3.add_role("admin3")
					expect(subject).to permit(user_admin3)
				end
				it "nav_notes" do
					user_nav_notes = create(:user)
					user_nav_notes.add_role("nav_notes")
					expect(subject).to permit(user_nav_notes)
				end
			end
			context "Denies access if user has other roles/privileges:" do
				it "other" do
					user_other = create(:user)
					user_other.add_role("other")
					expect(subject).not_to permit(user_other)
				end
			end
		end

		permissions :nav_trackers? do
			context "Grants access if user has following roles/privileges:" do
				it "admin3" do
					user_admin3 = create(:user)
					user_admin3.add_role("admin3")
					expect(subject).to permit(user_admin3)
				end
				it "nav_trackers" do
					user_nav_trackers = create(:user)
					user_nav_trackers.add_role("nav_trackers")
					expect(subject).to permit(user_nav_trackers)
				end
			end
			context "Denies access if user has other roles/privileges:" do
				it "other" do
					user_other = create(:user)
					user_other.add_role("other")
					expect(subject).not_to permit(user_other)
				end
			end
		end

		permissions :nav_patients? do
			context "Grants access if user has following roles/privileges:" do
				it "admin3" do
					user_admin3 = create(:user)
					user_admin3.add_role("admin3")
					expect(subject).to permit(user_admin3)
				end
				it "nav_patients" do
					user_nav_patients = create(:user)
					user_nav_patients.add_role("nav_patients")
					expect(subject).to permit(user_nav_patients)
				end
			end
			context "Denies access if user has other roles/privileges:" do
				it "other" do
					user_other = create(:user)
					user_other.add_role("other")
					expect(subject).not_to permit(user_other)
				end
			end
		end

		permissions :nav_admin? do
			context "Grants access if user has following roles/privileges:" do
				it "admin3" do
					user_admin3 = create(:user)
					user_admin3.add_role("admin3")
					expect(subject).to permit(user_admin3)
				end
				it "admin2" do
					user_admin2 = create(:user)
					user_admin2.add_role("admin2")
					expect(subject).to permit(user_admin2)
				end
				it "admin1" do
					user_admin1 = create(:user)
					user_admin1.add_role("admin1")
					expect(subject).to permit(user_admin1)
				end
				it "nav_admin" do
					user_nav_admin = create(:user)
					user_nav_admin.add_role("nav_admin")
					expect(subject).to permit(user_nav_admin)
				end
			end
			context "Denies access if user has other roles/privileges:" do
				it "other" do
					user_other = create(:user)
					user_other.add_role("other")
					expect(subject).not_to permit(user_other)
				end
			end
		end
	end
end