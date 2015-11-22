require "rails_helper"

RSpec.describe MxAssessmentsController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/mx_assessments/new").to route_to("mx_assessments#new")
    end

    it "routes to #create" do
      expect(:post => "/mx_assessments").to route_to("mx_assessments#create")
    end

    it "routes to #update" do
      expect(:put => "/mx_assessments/1").to route_to("mx_assessments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/mx_assessments/1").to route_to("mx_assessments#destroy", :id => "1")
    end


    it "routes to #date_history (mx_assessment meetings)" do
      expect(:get => "/mxa_date_history/").to route_to("mx_assessments#date_history")
    end

    it  "routes to #patient_lists (done, to-do)" do
      expect(:get => "/mxa_pat_lists").to route_to("mx_assessments#patient_lists")
    end

    it  "routes to #get_pat_data" do
      expect(:get => "/mxa_pat_data").to route_to("mx_assessments#get_pat_data")
    end
  end
end