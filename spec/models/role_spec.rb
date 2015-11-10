require 'rails_helper'

describe "Role:" do
	let(:role) {build(:role)}
	context "Validations:" do 
		it "has a valid factory" do
			expect(build(:role)).to be_valid
		end

		it "is valid with name, resource_id" do
			expect(role).to be_valid
		end
	end

	
	context "Associations:" do
		it " 'many_to_many' with users" do
			expect(role).to have_and_belong_to_many :users
		end
	end
end