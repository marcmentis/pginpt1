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

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProductsController. Be sure to keep this updated too.
  let(:valid_session) { {
    confirmed: 'authen_and_in_db'
    # authen: 'pgmdmjm',
    # facility: '0013',
    # admin3: true,
    # user_name: 'mentis'
    } }

	describe "POST #create" do
		context "with valid params" do
		  it "creates a new Product" do
		    expect {
		      post :create, {:product => valid_attributes}, valid_session
		    }.to change(Product, :count).by(1)
			end
		end
	end


	# describe 'json output' do
	# 	Patient
	# 	it "responds successfully with HTTP 200 status code" do
	# 		PatientPolicy = double()
	# 		allow(PatientPolicy).to receive(:index?) {true}

	# 		get :index, {}, valid_session
	# 		expect(response).to be_success
	# 		expect(response).to have_http_status(200)
	# 	end
	# end
end


# describe PatientsController do
	
# 	# describe "POST #create" do
# 	# 	# let(:patient) {build(:patient)}

# 	# 	context "with valid attributes" do
# 	# 		it  "saves the new patient in the database" do
# 	# 			params = {"patient"=>{"updated_by"=>"Mentis M", "id"=>"", "firstname"=>"Aaaa", "lastname"=>"Aaalast", "identifier"=>"656743", "facility"=>"0013", "site"=>"81/101", "doa"=>"2015-11-10", "dob"=>"", "dod"=>""}}
# 	# 	# byebug
# 	# 			# post :create, format: :json
# 	# 			# expect(post :create, format: :json, patient: attributes_for(:patient)).to change(Patient, :count).by(1)
# 	# 			expect(post :create, format: :json, patient: params).to change(Patient, :count).by(1)
# 	# 		end
# 	# 	end
# 	# end
# 	describe 'json output' do
# 		it "returns a json file" do
# 			post :create, format: :json
# 			expect(response.code).to eq(200)
	
# 		end
# 	end

# end