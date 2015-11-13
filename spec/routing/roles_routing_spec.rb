require "rails_helper"

RSpec.describe RolesController, type: :routing do
  describe "routing" do

    it "routes to #all_roles (for a user)" do
      expect(:get => "/roles").to route_to("roles#all_roles")
    end

    it "routes to #all_users (for a role)" do
      expect(:get => "/roles_users").to route_to("roles#all_users")
    end

  end
end


    
    


    