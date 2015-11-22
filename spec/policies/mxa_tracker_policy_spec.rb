describe MxaTrackerPolicy do
	# Equivalent to: subject {described_class}
	subject {MxaTrackerPolicy}

	context "AUTHORIZATION for viewing 'mx assessment' table" do

		permissions :index? do
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
				it "bps_crud" do
					user_bps_crud = create(:user)
					user_bps_crud.add_role("bps_crud")
					expect(subject).to permit(user_bps_crud)
				end
				it "bps_cru" do
					user_bps_cru = create(:user)
					user_bps_cru.add_role("bps_cru")
					expect(subject).to permit(user_bps_cru)
				end
				it "bps_track" do
					user_bps_track = create(:user)
					user_bps_track.add_role("bps_track")
					expect(subject).to permit(user_bps_track)
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