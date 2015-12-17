class NsGroupPolicy
	attr_reader :current_user, :model

	def initialize(current_user, model)
		@current_user = current_user
		@ns_notes = model
	end

	def create?
		@current_user.has_role? :admin3 or
		@current_user.has_role? :nsgroup_crud or
		@current_user.has_role? :nsgroup_cru
	end

	def destroy?
		@current_user.has_role? :admin3 or
		@current_user.has_role? :nsgroup_crud
	end
end