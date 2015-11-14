class UserPolicy
	
	def destroy?
		@current_user.has_role? :admin3 or 
		@current_user.has_role? :admin2
	end
end