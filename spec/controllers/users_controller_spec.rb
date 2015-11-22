require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  # This should return the minimal set of attributes required to create a valid
  # Patient. As you add validations to Patient, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for(:user)
  }

  let(:invalid_attributes) {
    attributes_for(:invalid_user)
  }

  # let(:pilgrim_attributes) {
  # 	attributes_for(:facility_site_patient)
  # }

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

  let(:invalid_session) {{
  	confirmed: 'rubbish'
  	}}

    describe "Authentication" do
    	context "RSA Authentication" do
    		it "Log in Successful with RSA authentication" do
	    		get :index, {}, valid_session
	    		expect(response.status).to eq 200
	    	end
	    	it "Log in Fails (for ALL ACTIONS) without RSA authentication" do
	    		# Don't use 'valid_session' as don't want to bypass authorization
	    		request.env["HTTP_REMOTE_USER"] = nil
	    		# Don't use 'valid_session' as don't want to bypass authorization
	    		get :index, {}
	    		expect(response.status).to eq 200
	    		expect(assigns(:error)).to eq("User has not passed RSA authentication")
	    	end
	    end
	    context "Post RSA Still need App Authentication" do
	    	it "After Successful RSA authentication, login fails with invalid App authentication" do
	    		user = create(:user, authen: 'bad_authen')
	    		request.env["HTTP_REMOTE_USER"] = 'good_authen'
	    		# Don't use 'valid_session' as don't want to bypass authorization
	    		get :index, {}
	    		expect(response.status).to eq 200
	    		expect(assigns(:error)).to eq("User has no privileges in this application")
	    	end
	    	it "After Successful RSA authentication, login successful with Valid App authentication" do
	    		user = create(:user, authen: 'good_authen')
	    		request.env["HTTP_REMOTE_USER"] = 'good_authen'
	    		# Don't use 'valid_session' as don't want to bypass authorization
	    		get :index, {}
	    		expect(response.status).to eq 200
	    		expect(assigns(:error)).to eq(nil)
	    	end
	    end
	    context "After successful authentication set session variable for repeat login" do
	    	it "Repeat login successful with valid authentication session variable" do
	    		get :index, {}, valid_session
	    		expect(response.status).to eq 200
	    		expect(assigns(:error)).to eq(nil)
	    	end
	    	it "Repeat login fails with invalid authentication session variable" do
	    		get :index, {}, invalid_session
	    		expect(response.status).to eq 200
	    		expect(assigns(:error)).to eq("User has not passed RSA authentication")
	    	end
	    end
    end
    describe "GET #index (json format)" do
    	it "assigns all users as @users" do
    		# Stub out 'authorize Patient'
    		# allow(controller).to receive(:policy).and_return double(index?: true)
    		smith = create(:user, lastname: 'Smith')
    		jones = create(:user, lastname: 'Jones')

    		get :index, {}, valid_session
    		expect(assigns(:users)).to eq([smith, jones])
    		# 'match_array' doesn't have to be in correct order
    		# expect(assigns(:patients)).to match_array([jones, smith])
    	end
    end

    describe "GET #new (json format)" do
    	it "assigns the new user as @user" do
    		get :new, {format: 'json'}, valid_session
    		expect(assigns(:user)).to be_a_new(User)
    	end
    end

    describe "GET #edit (json format)" do
    	it "assigns the requested user as @user" do
    		user = User.create! valid_attributes
    		get :edit, {format: 'json', id: user.to_param}, valid_session
    		expect(assigns(:user)).to eq(user)
    	end
    end

    describe "POST #create (json format)" do
		context "with valid params" do
		  it "creates a new User" do
		    expect {
		      post :create, {format: 'json', user: valid_attributes}, valid_session
		      }.to change(User, :count).by(1)
			end

			it "assigns a newly created user as @user" do
				post :create, {format: 'json', user: valid_attributes}, valid_session
				expect(assigns(:user)).to be_a(User)
				expect(assigns(:user)).to be_persisted
			end

			it "has response status 204 - no_content" do
				post :create, {format: 'json', user: valid_attributes}, valid_session
				expect(response.status).to eq 204
			end
		end

		context "with invalid params" do
			it "assigns a newly created but unsaved user as @user" do
				post :create, {format: 'json', user: invalid_attributes}, valid_session
				expect(assigns(:user)).to be_a_new(User)
			end
		end
	end

	describe "PATCH #update (json format)" do
		context "with valid params" do
			let(:new_attributes) {attributes_for(:user)}

			it "updates the requested user" do
				user = User.create! valid_attributes
				patch :update, {format: 'json', id: user.to_param, user: new_attributes}, valid_session
				user.reload
			end

			it "assigns the requested user as @user" do
				user = User.create! valid_attributes
				patch :update, {format: 'json', id: user.to_param, user: valid_attributes}, valid_session
				expect(assigns(:user)).to eq(user)
			end

			it "has response status 204 - no_content" do
				user = User.create! valid_attributes
				patch :update, {format: 'json', id: user.to_param, user: valid_attributes}, valid_session
				expect(response.status).to eq 204
			end
		end

		context "with invalid params" do
			it "assigns the unsaved user as @user" do
				user = create(:user)
				patch :update, {format: 'json', id: user.to_param, user: invalid_attributes}, valid_session
				expect(assigns(:user)).to eq(user)
			end

			# it "raises an error" do
			# 	skip("to do")
			# 	# user = User.create! valid_attributes
			# 	# patch :update, {format: 'json', id: user.to_param, user: invalid_attributes}, valid_session
			# 	# user2.valid?
			# 	# expect(user2.errors.full_messages).to include("unprocessable_entity")
			# end
		end
	end

	describe "DELETE #destroy" do
		it "destroys the requested user (json format) stub appropriate role" do
			# Stub out 'authorize @patient'
    		allow(controller).to receive(:policy).and_return double(destroy?: true)
    		user = create(:user) 
			expect {
				delete :destroy, {format: 'json', id: user.to_param}, valid_session
				}.to change(User, :count).by(-1)
		end
	end


 end