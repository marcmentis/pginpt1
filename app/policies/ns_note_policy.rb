class NsNotePolicy
	attr_reader :current_user, :model

	def initialize(current_user, model)
		@current_user = current_user
		@ns_note = model
	end

	def create?
		@current_user.has_role? :admin3 or
		@current_user.has_role? :nsnote_crud or
		@current_user.has_role? :nsnote_cru
	end

	def destroy?
		@current_user.has_role? :admin3 or
		@current_user.has_role? :nsnote_crud
	end

	def track?
		@current_user.has_role? :admin3 or
		@current_user.has_role? :nsnote_track or
		@current_user.has_role? :nsnote_crud or
		@current_user.has_role? :nsnote_cru
	end
end