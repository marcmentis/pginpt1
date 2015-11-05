class PatientPolicy
	attr_reader :current_user, :model

	def initialize(current_user, model)
		@current_user = current_user
		@model = model
	end

	def index?
		@current_user.has_role? :admin3 or 
		@current_user.has_role? :pat_crud or
		@current_user.has_role? :pat_cru
	end

	def destroy?
		@current_user.has_role? :admin3 or 
		@current_user.has_role? :pat_crud
		
	end
end