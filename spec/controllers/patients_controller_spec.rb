require "rails_helper"


describe PatientsController do
	
	# describe "POST #create" do
	# 	# let(:patient) {build(:patient)}

	# 	context "with valid attributes" do
	# 		it  "saves the new patient in the database" do
	# 			params = {"patient"=>{"updated_by"=>"Mentis M", "id"=>"", "firstname"=>"Aaaa", "lastname"=>"Aaalast", "identifier"=>"656743", "facility"=>"0013", "site"=>"81/101", "doa"=>"2015-11-10", "dob"=>"", "dod"=>""}}
	# 	# byebug
	# 			# post :create, format: :json
	# 			# expect(post :create, format: :json, patient: attributes_for(:patient)).to change(Patient, :count).by(1)
	# 			expect(post :create, format: :json, patient: params).to change(Patient, :count).by(1)
	# 		end
	# 	end
	# end

	describe 'json output' do
		it "returns a json file" do
			post :create, format: :json
			expect(response.headers['Content-Type']).to match 'application/json'
		end
	end

end