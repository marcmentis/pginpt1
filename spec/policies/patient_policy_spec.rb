describe PatientPolicy do
	# Equivalent to: subject {described_class}
	subject {PatientPolicy}

	context "AUTHORIZATION for view/altering 'patients' table" do

		permissions :index? do
			context "Grants access if user has following roles/privileges:" do
				it "admin3" do
					user_admin3 = create(:user)
					user_admin3.add_role("admin3")
					expect(subject).to permit(user_admin3)
				end
				it "pat_crud" do
					user_pat_crud = create(:user)
					user_pat_crud.add_role("pat_crud")
					expect(subject).to permit(user_pat_crud)
				end
				it "pat_cru" do
					user_pat_cru = create(:user)
					user_pat_cru.add_role("pat_cru")
					expect(subject).to permit(user_pat_cru)
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
				it "pat_crud" do
					user_pat_crud = create(:user)
					user_pat_crud.add_role("pat_crud")
					expect(subject).to permit(user_pat_crud)
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