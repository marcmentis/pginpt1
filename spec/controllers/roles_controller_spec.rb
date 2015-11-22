require 'rails_helper'

RSpec.describe RolesController, :type => :controller do
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

  describe "GET #all_roles (json format)" do
    it "assigns all roles as @roles" do
      role1 = create(:role, name: "Aname")
      role2 = create(:role, name: "Bname")
      get :all_roles, {format: 'json'}, valid_session
      expect(assigns(:roles)).to eq([role1, role2])
    end
    it "orders @roles by 'name' " do
      role1 = create(:role, name: "Bname")
      role2 = create(:role, name: "Aname")
      get :all_roles, {format: 'json'}, valid_session
      expect(assigns(:roles)[1].name).to eq("Bname")
    end
  end

  # describe "GET #all_users" do
  #   it "assigns all users that have a role to @role_users" do
  #     Auser = create(:user, lastname: "Auser", id: 1)
  #     Buser = create(:user, lastname: "Buser", id: 2)

  #     Arole = create(:role, name: "Arole", id: 1)
  #     Brole = create(:role, name: "Brole", id: 2)

  #     params = {name: "Arole"}

  #     get :all_users, {}, valid_session
  #     expect(assigns(:role_users).name).to eq("Auser")
  #   end
  # end



end