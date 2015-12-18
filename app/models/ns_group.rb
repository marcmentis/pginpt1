class NsGroup < ActiveRecord::Base
	include Jqgridconcern
	has_and_belongs_to_many :patients

	validates :duration, presence: true
	validates :groupname, presence: true
	validates :leader, presence: true
	validates :groupsite, presence: true
	validates :facility, presence: true
	validates :updated_by, presence: true

	def get_jqGrid_obj(params)
		# ActiveRecord relations are lazy loaders and can be chained
	    # Therefore, sequental .where searches IF PARAM not zero will filter with an 'AND' relationship
	    # Database will not be hit (lazy loading) until data needed by app
		# session_admin3 ? (puts "SESSION_ADMIN3: truish") : (puts "SESSION_ADMIN3: false")
	    conditions = NsGroup.all
	    conditions = conditions.where("facility = :facility", {facility: params[:facility]}) if params[:facility]!= '-1'
	    conditions = conditions.where("groupname LIKE ?", ''+params[:groupname]+'%') if params[:groupname]!= ''
	    conditions = conditions.where("leader LIKE ?", ''+ params[:leader]+'%') if params[:leader]!= ''

	    return jqGrid_obj = create_jqGrid_obj(conditions, params)
	end
end
