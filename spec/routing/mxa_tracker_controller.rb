require "rails_helper"

RSpec.describe MxaTrackerController, type: :routing do
  describe "routing" do

    it "routes to #index" do
          expect(:get => "mxa_tracker/index").to route_to("mxa_tracker#index")
        end

    it "routes to #complex_search (latest meeting)" do
      expect(:get => "/mxa_tracker_search").to route_to("mxa_tracker#complex_search")
    end

    it  "routes to #complex_search_all (all meetings)" do
      expect(:get => "/mxa_tracker_search_all").to route_to("mxa_tracker#complex_search_all")
    end

    it  "routes to #get_reasons (for a patient)" do
      expect(:get => "/mxa_tracker_get_reasons/1").to route_to("mxa_tracker#get_reasons", :id => "1")
    end
  end
end