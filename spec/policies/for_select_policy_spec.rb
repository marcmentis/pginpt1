describe ForSelectPolicy do
	# Equivalent to: subject {described_class}
	subject {ForSelectPolicy}

	context "AUTHORIZATION for view/altering 'for_selects' table" do

		permissions :complex_search? do
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
				it "for_select" do
					user_for_select = create(:user)
					user_for_select.add_role("for_select")
					expect(subject).to permit(user_for_select)
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

		permissions :destroy? do
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