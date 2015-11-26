require "rails_helper"

RSpec.describe MxAssessmentsController, :type => :controller do
  # This should return the minimal set of attributes required to create a valid
  # Patient. As you add validations to Patient, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for(:mx_assessment)
  }

  let(:invalid_attributes) {
    attributes_for(:invalid_mx_assessment)
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProductsController. Be sure to keep this updated too.
  let(:valid_session) { {
    confirmed: 'authen_and_in_db',
    # authen: 'pgmdmjm',
    # facility: '0013',
    # user_name: 'mentis'
    } }

	describe "GET #new (json format)" do
		it "assigns the new mx_assessment as @mx_assessment" do
			get :new, {format: 'json'}, valid_session
			expect(assigns(:mx_assessment)).to be_a_new(MxAssessment)
		end
	end

	describe "GET #edit (json format)" do
		it "assigns the requested mx_assessment as @mx_assessment" do
			mx_assessment = create(:mx_assessment)
			get :edit, {format: 'json', id: mx_assessment.to_param}, valid_session
			expect(assigns(:mx_assessment)).to eq(mx_assessment)
		end
	end

	describe "POST #create (json format)" do	
		# before(:each) do
		# 	allow(controller).to receive(:policy).and_return double(create?: true)
		# end	
		let(:allow_policy_create) {allow(controller).to receive(:policy).and_return double(create?: true)}
		let(:post_create_url) {post :create, {format: 'json', mx_assessment: valid_attributes}, valid_session}
		let(:post_create_url_invalid) {post :create, {format: 'json', mx_assessment: invalid_attributes}, valid_session}
		context "with valid params" do
			it "creates a new MxAssessment" do
				allow_policy_create
				expect {post_create_url}.to change(MxAssessment, :count).by(1)
				# expect {
				# 	post :create, {format: 'json', mx_assessment: valid_attributes}, valid_session
				# }.to change(MxAssessment, :count).by(1)
			end
			it "assigns a newly created mx_assessment as @mx_assessment" do
				allow_policy_create
				post_create_url
				expect(assigns(:mx_assessment)).to be_a(MxAssessment)
			end
			it "will save valid @mx_assessment" do
				allow_policy_create
				post_create_url
				expect(assigns(:mx_assessment)).to be_persisted
			end
			it "has response status 204 - no_content" do
				allow_policy_create
				post_create_url
				expect(response.status).to eq 204
			end
		end
		context "with invalid params" do
			it "assigns a newly create but unsaved mx_assessment as @mx_assessment" do
				allow_policy_create
				post_create_url_invalid
				expect(assigns(:mx_assessment)).to be_a_new(MxAssessment)
			end

			it "will not save the newly created but invalid @mx_assessment" do
				allow_policy_create
				post_create_url_invalid
				expect(assigns(:mx_assessment)).not_to be_persisted
			end


		end
	end

	describe "PATCH #update (json format)" do
		context "with valid params" do
			let(:new_attributes) {attributes_for(:mx_assessment)}
			it "updates the requested mx_assessment" do
				mx_assessment = create(:mx_assessment)
				patch :update, {format: 'json', id: mx_assessment.to_param, mx_assessment: new_attributes}, valid_session
				mx_assessment.reload
			end

			it "assigns the requested mx_assessment as @mx_assessment" do
				mx_assessment = create(:mx_assessment)
				patch :update, {format: 'json', id: mx_assessment.to_param, mx_assessment: valid_attributes}, valid_session
				expect(assigns(:mx_assessment)).to eq(mx_assessment)
			end

			it "saves requested mx_assessment" do
		        mx_assessment = create(:mx_assessment)
		        patch :update, {format: 'json', id: mx_assessment.to_param, mx_assessment: valid_attributes}, valid_session
		        expect(assigns(:mx_assessment)).to be_persisted
		    end
		    it "has response status 204 - no_content" do
				mx_assessment = create(:mx_assessment)
				patch :update, {format: 'json', id: mx_assessment.to_param, mx_assessment: valid_attributes}, valid_session
				expect(response.status).to eq 204
			end
		end
		context "with invalid params" do
			it "assigns the unsaved mx_assessment as @mx_assessment" do
				mx_assessment = create(:mx_assessment)
				patch :update, {format: 'json', id: mx_assessment.to_param, mx_assessment: invalid_attributes}, valid_session
				expect(assigns(:mx_assessment)).to eq(mx_assessment)
			end
		end
	end

	describe "DELETE #destroy" do
		it "destroys the requested mx_assessment (json format) stub appropriate role" do
			# Stub out 'authorize @mx_assessment'
    		allow(controller).to receive(:policy).and_return double(destroy?: true)
			mx_assessment = create(:mx_assessment)
			expect {
				delete :destroy, {format: 'json', id: mx_assessment.to_param}, valid_session
				}.to change(MxAssessment, :count).by(-1)
		end
	end
end