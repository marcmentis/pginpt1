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
  	attributes_for(:facility_site_patient)
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
    		smith = create(:facility_site_patient, lastname: 'Smith')
    		adams = create(:facility_site_patient, lastname: 'Adams')
    		jones = create(:patient)
    		get :patients_site_search, {format: 'json', site: "Ward1"}, valid_session
    		# expect(assigns(:patients)).to match_array([smith])
    		expect(assigns(:patients)).to eq([adams, smith])
    	end

    	it "does not include patients from a different site" do
    		smith = create(:facility_site_patient, lastname: 'Smith')
    		adams = create(:facility_site_patient, lastname: 'Adams')
    		jones = create(:patient, lastname: 'Jones')
    		get :patients_site_search, {format: 'json', site: "Ward1"}, valid_session
    		# expect(assigns(:patients)).to match_array([smith])
    		expect(assigns(:patients)).not_to eq([adams, jones, smith])
    	end

    	it "does not order patients other than by lastname ascending" do
    		smith = create(:facility_site_patient, lastname: 'Smith')
    		adams = create(:facility_site_patient, lastname: 'Adams')
    		jones = create(:patient, lastname: 'Jones')
    		get :patients_site_search, {format: 'json', site: "Ward1"}, valid_session
    		# expect(assigns(:patients)).to match_array([smith])
    		expect(assigns(:patients)).not_to eq([jones, adams])
    	end

    	it "returns null array if no patients at the site" do
    		smith = create(:facility_site_patient, lastname: 'Smith')
    		adams = create(:facility_site_patient, lastname: 'Adams')
    		jones = create(:patient, lastname: 'Jones')
    		get :patients_site_search, {format: 'json', site: "Other"}, valid_session
    		# expect(assigns(:patients)).to match_array([smith])
    		expect(assigns(:patients)).to eq([])
    	end

    end

  #   describe "GET #complex_search (json format)" do

  #   	it "assigns patients into @jqGrid" do
  #   		params = {"firstname"=>"", "lastname"=>"", "identifier"=>"", "facility"=>"-1", "site"=>"-1", "_search"=>"false", "nd"=>"1447519814861", "rows"=>"15", "page"=>"1", "sidx"=>"lastname", "sord"=>"asc", "controller"=>"patients", "action"=>"complex_search"}
  #   		 # @jqGrid_obj = {"total"=>21, "page"=>1, "records"=>301, "rows"=>[
  #   		 # 			{"id"=>10360, "cell"=>#<Patient id: 10360, firstname: "Aaa", lastname: "AaaLast", identifier: "8787765", facility: "0013", site: "81/101", doa: "2015-11-02 00:00:00", dob: nil, dod: nil, updated_by: "Mentis M", created_at: "2015-11-13 20:40:25", updated_at: "2015-11-13 20:46:57">},
  #   		 # 			 {id: 10360, firstname: "Aaaa", ...}
  #   		 # 			 ]}
  #   		 session[:admin] = true
		# 	smith = create(:facility_site_patient, lastname: 'Smith')
		# 	adams = create(:facility_site_patient, lastname: 'Adams')
		# 	jones = create(:patient, lastname: 'Jones')
		# 	get :complex_search, {format: 'json', params: params}, valid_session
			
		# 	expect(response.status).to eq 204
		# 	# expect(assigns(:jqGrid_obj)).to include("Smith")
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
