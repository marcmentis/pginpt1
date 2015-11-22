require "rails_helper"

RSpec.describe PatientsController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/patients/new").to route_to("patients#new")
    end

    it "routes to #create" do
      expect(:post => "/patients").to route_to("patients#create")
    end

    it "routes to #update" do
      expect(:put => "/patients/1").to route_to("patients#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/patients/1").to route_to("patients#destroy", :id => "1")
    end

    it "routes to #complex_search (for patients)" do
      expect(:get => "/patients_search").to route_to("patients#complex_search")
    end

    it "routes to #patients_site_search" do
      expect(:get => "/patients_site_search").to route_to("patients#patients_site_search")
    end
  end
end