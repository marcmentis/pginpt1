describe NsNotePolicy do
	# Equivalent to: subject {described_class}
	subject {NsNotePolicy}

	context "AUTHORIZATION for view/altering 'ns_note' note" do
		permissions :create? do
			context "Grants access if user has following roles/privileges" do
				it "admin3" do
					user_admin3 = create(:user)
					user_admin3.add_role("admin3")
					expect(subject).to permit(user_admin3)
				end
				it "nsnote_crud" do
					user_nsnote_crud = create(:user)
					user_nsnote_crud.add_role("nsnote_crud")
					expect(subject).to permit(user_nsnote_crud)
				end
				it "nsnote_cru" do
					user_nsnote_cru = create(:user)
					user_nsnote_cru.add_role("nsnote_cru")
					expect(subject).to permit(user_nsnote_cru)
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
			context "Grants access if user has following roles/privileges" do
				it "admin3" do
					user_admin3 = create(:user)
					user_admin3.add_role("admin3")
					expect(subject).to permit(user_admin3)
				end
				it "nsnote_crud" do
					user_nsnote_crud = create(:user)
					user_nsnote_crud.add_role("nsnote_crud")
					expect(subject).to permit(user_nsnote_crud)
				end
			end
			context "Denies access if user has other roles/privileges:" do
				it "nsnote_cru" do
					user_nsnote_cru = create(:user)
					user_nsnote_cru.add_role("nsnote_cru")
					expect(subject).not_to permit(user_nsnote_cru)
				end
				it "other" do
					user_other = create(:user)
					user_other.add_role("other")
					expect(subject).not_to permit(user_other)
				end
			end
		end

		permissions :track? do
			context "Grants access if user has following roles/privileges" do
				it "admin3" do
					user_admin3 = create(:user)
					user_admin3.add_role("admin3")
					expect(subject).to permit(user_admin3)
				end
				it "nsnote_crud" do
					user_nsnote_crud = create(:user)
					user_nsnote_crud.add_role("nsnote_crud")
					expect(subject).to permit(user_nsnote_crud)
				end
				it "nsnote_cru" do
					user_nsnote_cru = create(:user)
					user_nsnote_cru.add_role("nsnote_cru")
					expect(subject).to permit(user_nsnote_cru)
				end
				it "nsnote_track" do
					user_nsnote_track = create(:user)
					user_nsnote_track.add_role("nsnote_track")
					expect(subject).to permit(user_nsnote_track)
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