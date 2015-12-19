require 'rails_helper'

RSpec.describe ForSelectsController, :type => :controller do
  # This should return the minimal set of attributes required to create a valid
  # Patient. As you add validations to Patient, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for(:for_select)
  }

  let(:invalid_attributes) {
    attributes_for(:invalid_for_select)
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

  describe "GET #index (json format)" do
    it "assigns all for_selects as @for_selects" do
      # Stub out 'authorize Patient'
      # allow(controller).to receive(:policy).and_return double(index?: true)
      animals = create(:for_select, code: 'Animals')
      babies = create(:for_select, code: 'Babies')

      get :index, {format: 'json'}, valid_session
      expect(assigns(:for_selects)).to eq([animals, babies])
    end
  end

  describe "GET #new (json format)" do
    it "assigns the new for_select as @for_select" do
      get :new, {format: 'json'}, valid_session
      expect(assigns(:for_select)).to be_a_new(ForSelect)
    end
  end

  describe "POST #create (json format)" do
    context "with valid params" do
      it "creates a new ForSelect" do
        expect {
          post :create, {format: 'json', for_select: valid_attributes}, valid_session
          }.to change(ForSelect, :count).by(1)
      end

      it "assigns a newly created for_select as @for_select" do
        post :create, {format: 'json', for_select: valid_attributes}, valid_session
        expect(assigns(:for_select)).to be_a(ForSelect)
        expect(assigns(:for_select)).to be_persisted
      end

      it "has response status 204 - no_content" do
        post :create, {format: 'json', for_select: valid_attributes}, valid_session
        expect(response.status).to eq 204
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved for_select as @for_select" do
        post :create, {format: 'json', for_select: invalid_attributes}, valid_session
        expect(assigns(:for_select)).to be_a_new(ForSelect)
      end
    end
  end

  describe "PATCH #update (json format)" do
    context "with valid params" do
      let(:new_attributes) {attributes_for(:for_select)}
      let(:for_select) {for_select = create(:for_select)}

      it "updates the requested patient" do
        patch :update, {format: 'json', id: for_select.to_param, for_select: new_attributes}, valid_session
        for_select.reload
      end

      it "assigns the requested patient as @patient" do
        patch :update, {format: 'json', id: for_select.to_param, for_select: valid_attributes}, valid_session
        expect(assigns(:for_select)).to eq(for_select)
      end

      it "has response status 204 - no_content" do
        patch :update, {format: 'json', id: for_select.to_param, for_select: valid_attributes}, valid_session
        expect(response.status).to eq 204
      end
    end

    context "with invalid params" do
      it "assigns the unsaved for_select as @for_select" do
        for_select = create(:for_select)
        patch :update, {format: 'json', id: for_select.to_param, for_select: invalid_attributes}, valid_session
        expect(assigns(:for_select)).to eq(for_select)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested for_select (json format) stub appropriate role" do
      # Stub out 'authorize @patient'
        allow(controller).to receive(:policy).and_return double(destroy?: true)
      # patient = Patient.create! valid_attributes
      for_select = create(:for_select)
      expect {
        delete :destroy, {format: 'json', id: for_select.to_param}, valid_session
        }.to change(ForSelect, :count).by(-1)
    end
  end

end