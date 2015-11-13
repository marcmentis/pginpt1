require 'rails_helper'

RSpec.describe PatientsController, :type => :controller do
  # This should return the minimal set of attributes required to create a valid
  # Patient. As you add validations to Patient, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for(:patient)
  }

  let(:invalid_attributes) {
    attributes_for(:invalid_patient)
  }

  let(:pilgrim_attributes) {
  	attributes_for(:pilgrim_patient)
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProductsController. Be sure to keep this updated too.
  let(:valid_session) { {
    confirmed: 'authen_and_in_db',
    # authen: 'pgmdmjm',
    # facility: '0013',
    admin3: true,
    # user_name: 'mentis'
    } }

    describe "GET #index (json format)" do
    	it "assigns all patients as @patients" do
    		# Stub out 'authorize Patient'
    		allow(controller).to receive(:policy).and_return double(index?: true)
		
    		smith = create(:patient, lastname: 'Smith')
    		jones = create(:patient, lastname: 'Jones')
    		get :index, {format: 'json'}, valid_session
    		expect(assigns(:patients)).to eq([smith, jones])
    		# 'match_array' doesn't have to be in correct order
    		# expect(assigns(:patients)).to match_array([jones, smith])
    	end
    end

    describe "GET #patients_site_search (json format)" do
    	it "assigns all site patients as @patients ordered lastname ascending" do
    		# patient = Patient.create! valid_attributes
    		smith = create(:pilgrim_patient, lastname: 'Smith')
    		adams = create(:pilgrim_patient, lastname: 'Adams')
    		jones = create(:patient)
    		get :patients_site_search, {format: 'json', site: "Pilgrim"}, valid_session
    		# expect(assigns(:patients)).to match_array([smith])
    		expect(assigns(:patients)).to eq([adams, smith])
    	end

    	it "does not include patients from a different site" do
    		smith = create(:pilgrim_patient, lastname: 'Smith')
    		adams = create(:pilgrim_patient, lastname: 'Adams')
    		jones = create(:patient, lastname: 'Jones')
    		get :patients_site_search, {format: 'json', site: "Pilgrim"}, valid_session
    		# expect(assigns(:patients)).to match_array([smith])
    		expect(assigns(:patients)).not_to eq([adams, jones, smith])
    	end

    	it "does not order patients other than by lastname ascending" do
    		smith = create(:pilgrim_patient, lastname: 'Smith')
    		adams = create(:pilgrim_patient, lastname: 'Adams')
    		jones = create(:patient, lastname: 'Jones')
    		get :patients_site_search, {format: 'json', site: "Pilgrim"}, valid_session
    		# expect(assigns(:patients)).to match_array([smith])
    		expect(assigns(:patients)).not_to eq([jones, adams])
    	end

    	it "returns null array if no patients at the site" do
    		smith = create(:pilgrim_patient, lastname: 'Smith')
    		adams = create(:pilgrim_patient, lastname: 'Adams')
    		jones = create(:patient, lastname: 'Jones')
    		get :patients_site_search, {format: 'json', site: "Other"}, valid_session
    		# expect(assigns(:patients)).to match_array([smith])
    		expect(assigns(:patients)).to eq([])
    	end

    end

  #   describe "GET #complex_search (json format)" do

  #   	it "assigns patients into @jqGrid" do
		# 	smith = create(:pilgrim_patient, lastname: 'Smith')
		# 	adams = create(:pilgrim_patient, lastname: 'Adams')
		# 	jones = create(:patient, lastname: 'Jones')
		# 	get :patients_site_search, {format: 'json', params: {lastname: 'Smith'}}, valid_session
	
		# 	expect(assigns(:jqGrid_obj)).to include("Smith")
		# 	# expect(assigns(:jqGrid_obj)).to match_array([adams, smith])
		# 	# expect(assigns(:jqGrid_obj)).to eq(smith)
		# end
  #   end

    describe "GET #new (json format)" do
    	it "assigns the new patient as @patient" do
    		get :new, {format: 'json'}, valid_session
    		expect(assigns(:patient)).to be_a_new(Patient)
    	end
    end

    describe "GET #edit (json format)" do
    	it "assigns the requested patient as @patient" do
    		patient = Patient.create! valid_attributes
    		get :edit, {format: 'json', id: patient.to_param}, valid_session
    		expect(assigns(:patient)).to eq(patient)
    	end
    end

	describe "POST #create (json format)" do
		context "with valid params" do
		  it "creates a new Patient" do
		    expect {
		      post :create, {format: 'json', patient: valid_attributes}, valid_session
		      }.to change(Patient, :count).by(1)
			end

			it "assigns a newly created patient as @patient" do
				post :create, {format: 'json', patient: valid_attributes}, valid_session
				expect(assigns(:patient)).to be_a(Patient)
				expect(assigns(:patient)).to be_persisted
			end

			it "has response status 204 - no_content" do
				post :create, {format: 'json', patient: valid_attributes}, valid_session
				expect(response.status).to eq 204
			end
		end

		context "with invalid params" do
			it "assigns a newly created but unsaved patient as @patient" do
				post :create, {format: 'json', patient: invalid_attributes}, valid_session
				expect(assigns(:patient)).to be_a_new(Patient)
			end
		end
	end

	describe "PATCH #update (json format)" do
		context "with valid params" do
			let(:new_attributes) {attributes_for(:patient)}

			it "updates the requested patient" do
				patient = Patient.create! valid_attributes
				patch :update, {format: 'json', id: patient.to_param, patient: new_attributes}, valid_session
				patient.reload
			end

			it "assigns the requested patient as @patient" do
				patient = Patient.create! valid_attributes
				patch :update, {format: 'json', id: patient.to_param, patient: valid_attributes}, valid_session
				expect(assigns(:patient)).to eq(patient)
			end

			it "has response status 204 - no_content" do
				patient = Patient.create! valid_attributes
				patch :update, {format: 'json', id: patient.to_param, patient: valid_attributes}, valid_session
				expect(response.status).to eq 204
			end
		end

		context "with invalid params" do
			it "assigns the unsaved patient as @patient" do
				# patient = Patient.create! valid_attributes
				patient = create(:patient)
				patch :update, {format: 'json', id: patient.to_param, patient: invalid_attributes}, valid_session
				expect(assigns(:patient)).to eq(patient)
			end

			# it "raises an error" do
			# 	skip("to do")
			# 	# patient = Patient.create! valid_attributes
			# 	# patch :update, {format: 'json', id: patient.to_param, patient: invalid_attributes}, valid_session
			# 	# patient2.valid?
			# 	# expect(patient2.errors.full_messages).to include("unprocessable_entity")
			# end
		end
	end

	describe "DELETE #destroy" do
		it "destroys the requested patient (json format) stub appropriate role" do
			# Stub out 'authorize @patient'
    		allow(controller).to receive(:policy).and_return double(destroy?: true)
			patient = Patient.create! valid_attributes
			expect {
				delete :destroy, {format: 'json', id: patient.to_param}, valid_session
				}.to change(Patient, :count).by(-1)
		end
	end

end
