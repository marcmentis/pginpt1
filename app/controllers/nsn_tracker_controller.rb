class NsnTrackerController < ApplicationController
	before_action :set_nsn_tracker, only: [:show]

	def index
		authorize NsNote, :track?
	end

	# GET /nsn_tracker/1.json
	def show

		respond_to do |format|
			format.json {render json: @nsn_note}
		end
	end


	private
    # Use callbacks to share common setup or constraints between actions.
    def set_nsn_tracker
      @nsn_note = NsNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nsn_tracker_params
      params.require(:nsn_tracker).permit(:ns_group_id, :patient_id, :participate, :respond, 
                                      :interact_leader, :interact_peers, :discussion_init, 
                                      :discussion_understand, :comment, :updated_by, :group_date)
    end	

end
