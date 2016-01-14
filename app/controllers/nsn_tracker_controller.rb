class NsnTrackerController < ApplicationController
	# before_action :set_nsn_tracker, only: [:show]

	def index
		authorize NsNote, :track?
	end

	# GET /nsn_tracker_pat_notes/1.json
	def pat_notes_grps
		# byebug
		@pat_notes = NsNote.all

		respond_to do |format|
			format.json {render json: @pat_notes}
		end
	end


	private
    # Use callbacks to share common setup or constraints between actions.
    # def set_nsn_tracker
    #   @nsn_note = NsNote.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nsn_tracker_params
      params.require(:nsn_tracker).permit(:ns_group_id, :patient_id, :participate, :respond, 
                                      :interact_leader, :interact_peers, :discussion_init, 
                                      :discussion_understand, :comment, :updated_by, :group_date)
    end	

end
