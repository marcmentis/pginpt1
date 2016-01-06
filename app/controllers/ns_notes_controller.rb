class NsNotesController < ApplicationController
  before_action :set_ns_note, only: [:show, :edit, :update, :destroy]

  # GET /ns_notes
  # GET /ns_notes.json
  def index
    @ns_notes = NsNote.all
  end

  # GET /ns_notes/1
  # GET /ns_notes/1.json
  def show
  end

  # GET /ns_notes/new
  def new
    @ns_note = NsNote.new
  end

  # GET /ns_notes/1/edit
  def edit

    respond_to do |format|
      format.json {render json: @ns_note}
    end
  end

  # POST /ns_notes
  # POST /ns_notes.json
  def create
    @ns_note = NsNote.new(ns_note_params)

    respond_to do |format|
      if @ns_note.save
        format.html { redirect_to @ns_note, notice: 'Ns note was successfully created.' }
        # format.json { render :show, status: :created, location: @ns_note }
        format.json {render json: @ns_note}
      else
        format.html { render :new }
        format.json { render json: @ns_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ns_notes/1
  # PATCH/PUT /ns_notes/1.json
  def update
    respond_to do |format|
      if @ns_note.update(ns_note_params)
        format.html { redirect_to @ns_note, notice: 'Ns note was successfully updated.' }
        format.json { render json: @ns_note }
      else
        format.html { render :edit }
        format.json { render json: @ns_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ns_notes/1
  # DELETE /ns_notes/1.json
  def destroy
    @ns_note.destroy
    respond_to do |format|
      format.html { redirect_to ns_notes_url, notice: 'Ns note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /ns_groups_pat_lists.json/
  def note_by_pat_group_date
    @ns_note = NsNote.where(patient_id: ns_note_params[:patient_id])
                      .where(ns_group_id: ns_note_params[:ns_group_id])
                      .where(group_date: ns_note_params[:group_date])

    respond_to do |format|
      format.json {render json: @ns_note}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ns_note
      @ns_note = NsNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ns_note_params
      params.require(:ns_note).permit(:ns_group_id, :patient_id, :participate, :respond, 
                                      :interact_leader, :interact_peers, :discussion_init, 
                                      :discussion_understand, :comment, :updated_by, :group_date)
    end
end
