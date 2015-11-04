class StaticPagesPolicy < Struct.new(:current_user, :static_pages)
	
	def notes?
		current_user.has_role? :admin3 or
		current_user.has_role? :notes_r
	end

	def trackers?
		current_user.has_role? :admin3 or
		current_user.has_role? :trackers_r
	end

	def admin?
		current_user.has_role? :admin3 or
		current_user.has_role? :admin2 or
		current_user.has_role? :admin1
	end
end