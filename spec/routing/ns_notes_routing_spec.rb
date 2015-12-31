require "rails_helper"

RSpec.describe NsNotesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ns_notes").to route_to("ns_notes#index")
    end

    it "routes to #new" do
      expect(:get => "/ns_notes/new").to route_to("ns_notes#new")
    end

    it "routes to #show" do
      expect(:get => "/ns_notes/1").to route_to("ns_notes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ns_notes/1/edit").to route_to("ns_notes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ns_notes").to route_to("ns_notes#create")
    end

    it "routes to #update" do
      expect(:put => "/ns_notes/1").to route_to("ns_notes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ns_notes/1").to route_to("ns_notes#destroy", :id => "1")
    end

  end
end
