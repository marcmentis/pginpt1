describe NsGroupPolicy do
	# Equivalent to: subject {described_class}
	subject {NsGroupPolicy}

	context "AUTHORIZATION for view/altering 'ns_group' table" do
		permissions :create? do
			context "Grants access of user has following roles/privileges" do
				it "admin3" do
					user_admin3 = create(:user)
					user_admin3.add_role("admin3")
					expect(subject).to permit(user_admin3)
				end
				it "nsgroup_crud" do
					user_nsgroup_crud = create(:user)
					user_nsgroup_crud.add_role("nsgroup_crud")
					expect(subject).to permit(user_nsgroup_crud)
				end
				it "nsgroup_cru" do
					user_nsgroup_cru = create(:user)
					user_nsgroup_cru.add_role("nsgroup_cru")
					expect(subject).to permit(user_nsgroup_cru)
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
			context "Grants access of user has following roles/privileges" do
				it "admin3" do
					user_admin3 = create(:user)
					user_admin3.add_role("admin3")
					expect(subject).to permit(user_admin3)
				end
				it "nsgroup_crud" do
					user_nsgroup_crud = create(:user)
					user_nsgroup_crud.add_role("nsgroup_crud")
					expect(subject).to permit(user_nsgroup_crud)
				end
			end
			context "Denies access if user has other roles/privileges:" do
				it "nsgroup_cru" do
					user_nsgroup_cru = create(:user)
					user_nsgroup_cru.add_role("nsgroup_cru")
					expect(subject).not_to permit(user_nsgroup_cru)
				end
				it "other" do
					user_other = create(:user)
					user_other.add_role("other")
					expect(subject).not_to permit(user_other)
				end
			end
		end
	end
end