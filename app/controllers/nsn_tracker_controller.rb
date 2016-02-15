class NsnTrackerController < ApplicationController

	def index
		authorize NsNote, :track?
	end

	# GET /nsn_tracker_pat_notes/1.json
	def pat_notes_grps
		# byebug
		@pat_notes = NsNote.joins(:ns_group)
							.select('ns_groups.*', 'ns_notes.*')
							.where(patient_id: params[:patient_id])
							.where("group_date > :date_after AND group_date < :date_before", 
						 		{date_before: params[:date_before], date_after: params[:date_after]})
							.order('groupname ASC', 'group_date DESC')
						
		respond_to do |format|
			format.json {render json: @pat_notes}
		end
	end

end
