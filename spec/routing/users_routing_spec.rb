require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/users/new").to route_to("users#new")
    end

    it "routes to #create" do
      expect(:post => "/users").to route_to("users#create")
    end

    it "routes to #update" do
      expect(:put => "/users/1").to route_to("users#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/users/1").to route_to("users#destroy", :id => "1")
    end


    it "routes to #complex_search (for users)" do
      expect(:get => "/users_search").to route_to("users#complex_search")
    end

    it  "routes to #users_roles" do
      expect(:get => "/users_roles/1").to route_to("users#user_roles", :id => "1")
    end

    it  "routes to #add_role (to user)" do
      expect(:post => "/users_add_role/1").to route_to("users#add_role", :id => "1")
    end

    it  "routes to #remove_role (from user)" do
      expect(:delete => "/users_remove_role/1").to route_to("users#remove_role", :id => "1")
    end

    it "routes to #all_roles (for a user)" do
      expect(:get => "/roles").to route_to("roles#all_roles")
    end  
  end
end