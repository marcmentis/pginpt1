# describe StaticPagesPolicy do
# 	subject {StaticPagesPolicy}

# 	let (:current_user) { build(:user, user.name = 'admin3')}

# 	permissions :nav_notes? do
# 		it "denies access if not nav_notes" do

# 			expect(subject).not_to permit(current_user)
# 		end
# 	end
# end