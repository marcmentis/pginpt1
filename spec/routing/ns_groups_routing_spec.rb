require "rails_helper"

RSpec.describe NsGroupsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ns_groups").to route_to("ns_groups#index")
    end

    it "routes to #new" do
      expect(:get => "/ns_groups/new").to route_to("ns_groups#new")
    end

    it "routes to #show" do
      expect(:get => "/ns_groups/1").to route_to("ns_groups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ns_groups/1/edit").to route_to("ns_groups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ns_groups").to route_to("ns_groups#create")
    end

    it "routes to #update" do
      expect(:put => "/ns_groups/1").to route_to("ns_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ns_groups/1").to route_to("ns_groups#destroy", :id => "1")
    end

  end
end
