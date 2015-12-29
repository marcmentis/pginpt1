class NsGroupsController < ApplicationController
  before_action :set_ns_group, only: [:show, :edit, :update, :destroy]

  # GET /ns_groups
  # GET /ns_groups.json
  # def index
  #   @ns_groups = NsGroup.all
  # end

  # GET /ns_groups_search
  def complex_search
    
    # Get instance of NsGroup so can run instance method 'get_jqGrid_obj'
    ns_group = NsGroup.new
    @jqGrid_obj = ns_group.get_jqGrid_obj(params)

    respond_to do |format|
      format.html
      format.json {render json: @jqGrid_obj}
    end
  end

  # GET /ns_groups/1
  # GET /ns_groups/1.json
  def show
  end

  # GET /ns_groups/new
  def new
    @ns_group = NsGroup.new
  end

  # GET /ns_groups/1/edit
  def edit
  end

  # POST /ns_groups
  # POST /ns_groups.json
  def create
    @ns_group = NsGroup.new(ns_group_params)

    respond_to do |format|
      if @ns_group.save
        format.html { redirect_to @ns_group, notice: 'Ns group was successfully created.' }
        format.json { render :show, status: :created, location: @ns_group }
      else
        format.html { render :new }
        format.json { render json: @ns_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ns_groups/1
  # PATCH/PUT /ns_groups/1.json
  def update
    respond_to do |format|
      if @ns_group.update(ns_group_params)
        format.html { redirect_to @ns_group, notice: 'Ns group was successfully updated.' }
        format.json { render :show, status: :ok, location: @ns_group }
      else
        format.html { render :edit }
        format.json { render json: @ns_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ns_groups/1
  # DELETE /ns_groups/1.json
  def destroy
    @ns_group.destroy
    respond_to do |format|
      format.html { redirect_to ns_groups_url, notice: 'Ns group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /ns_groups_ward_patients.json
  def ward_patients
    @patients = Patient.where('facility = :facility', {facility: ns_group_params[:facility]})
                        .where('site = :site', {site: ns_group_params[:site]})
                        .order(lastname: :asc)
    # byebug

    respond_to do |format|
      format.json {render json: @patients}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ns_group
      @ns_group = NsGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ns_group_params
      params.require(:ns_group).permit(:duration, :groupname, :leader, :groupsite, :facility, :updated_by,
                                        :site)
    end
end
