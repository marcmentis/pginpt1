require "rails_helper"

RSpec.describe ForSelectsController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/for_selects/new").to route_to("for_selects#new")
    end

    it "routes to #create" do
      expect(:post => "/for_selects").to route_to("for_selects#create")
    end

    it "routes to #update" do
      expect(:put => "/for_selects/1").to route_to("for_selects#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/for_selects/1").to route_to("for_selects#destroy", :id => "1")
    end

    it "routes to #complex_search (for for_selects)" do
      expect(:get => "/for_selects_search").to route_to("for_selects#complex_search")
    end

    it "routes to #options_search" do
      expect(:get => "/for_selects_options_search").to route_to("for_selects#options_search")
    end
  end
end