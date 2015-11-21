class UserPolicy
	attr_reader :current_user, :model

	def initialize(current_user, model)
		@current_user = current_user
		@for_select = model
	end
	
	def destroy?
		@current_user.has_role? :admin3 or 
		@current_user.has_role? :admin2
	end
end