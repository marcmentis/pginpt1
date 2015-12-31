class NsGroup < ActiveRecord::Base
	include Jqgridconcern
	has_and_belongs_to_many :patients
	has_many :ns_notes, dependent: :destroy

	validates :duration, presence: true
	validates :groupname, presence: true
	validates :leader, presence: true
	validates :groupsite, presence: true
	validates :facility, presence: true
	validates :updated_by, presence: true

	def self.get_pat_lists(params)
		# byebug
		# Get all patients who have a note for given group and date
		all_done = NsGroup.pat_all_done(params)
		# Get all patients without a note for given group and date
		all_to_do = NsGroup.pat_all_to_do(params, all_done)

		return {pat_all_done: all_done, pat_all_to_do: all_to_do}
	end

	def self.pat_all_done(params)
		# Get all notes for given group and date
		notes = NsNote.where(ns_group_id: params[:ns_group_id])
						.where(group_date: params[:group_date])

		# Create an array of patient_id's to use in .where IN in all_done
		pat_ids = notes.each.map{|n| n.patient_id}

		# Get Patients from the pat_ids array
		all_done =Patient.where(id: pat_ids)
							.order(lastname: :asc)
	end

	def self.pat_all_to_do(params, all_done)
		#Create an array of Patient.id to use in .where IN in all_to_do
		not_these_ids = all_done.each.map{|p| p.id}

		# Get the group from its id
		group = NsGroup.find(params[:ns_group_id])
		# Get all the patients in the group using the has-and-belongs-to-many relationship
		all_pat_in_group = group.patients
		# Make an array of all the patients in the group
		all_pat_ids = all_pat_in_group.each.map{|p| p.id}
		# Get patients in group excluding those with notes
		all_to_do = Patient.where(id: all_pat_ids)
							.where.not(id: not_these_ids)
							.order(lastname: :asc)
	end

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
