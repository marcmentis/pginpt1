require 'rails_helper'

# RSpec.describe NsGroup, type: :model do
describe "NsGroup Model:" do
	let(:ns_group) {build(:ns_group)}
	context "Validations:" do
	  	it "has a valid factory" do
	  		expect(build(:ns_group)).to be_valid
	  	end
	  	it "is valid with a duration, groupname, leader, groupsite, facility, updated_by" do
	  		expect(ns_group).to be_valid
	  	end
	  	it "is invalid without duration" do
	  		ns_group.duration = nil
	  		expect(ns_group).not_to be_valid
	  	end
	  	it "is invalid without groupname" do
	  		ns_group.groupname = nil
	  		expect(ns_group).not_to be_valid
	  	end
	  	it "is invalid without leader" do
	  		ns_group.leader = nil
	  		expect(ns_group).not_to be_valid
	  	end
	  	it "is invalid without groupsite" do
	  		ns_group.groupsite = nil
	  		expect(ns_group).not_to be_valid
	  	end
	  	it "is invalid without facility" do
	  		ns_group.facility = nil
	  		expect(ns_group).not_to be_valid
	  	end
	  	it "is invalid without duration" do
	  		ns_group.updated_by = nil
	  		expect(ns_group).not_to be_valid
	  	end
	end
	context "Associations:" do
		it " 'has-and-belongs-to-many' (many-to-many with) patients " do
			expect(ns_group).to have_and_belong_to_many :patients
		end
		it " 'has-many (many-to-one) with ns_notes" do
			expect(ns_group).to have_many :ns_notes
		end
	end
end
