require 'rails_helper'

# RSpec.describe NsNote, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe "NsNote Model:" do
	let(:ns_note) {build(:ns_note)}
	context "Validations:" do
	  	it "has a valid factory" do
	  		expect(build(:ns_note)).to be_valid
	  	end
	  	it "is valid with a ns_group_id, patient_id, participate, respond, interact_leader, interact_peers, discussion_init, discussion_understand, comment, updated_by, group_date" do
	  		expect(ns_note).to be_valid
	  	end
	  	it "is invalid without ns_group_id" do
	  		ns_note.ns_group_id = nil
	  		expect(ns_note).not_to be_valid
	  	end
	  	it "is invalid without patient_id" do
	  		ns_note.patient_id = nil
	  		expect(ns_note).not_to be_valid
	  	end
	  	it "is invalid without participate" do
	  		ns_note.participate = nil
	  		expect(ns_note).not_to be_valid
	  	end
	  	it "is invalid without respond" do
	  		ns_note.respond = nil
	  		expect(ns_note).not_to be_valid
	  	end
	  	it "is invalid without interact_leader" do
	  		ns_note.interact_leader = nil
	  		expect(ns_note).not_to be_valid
	  	end
	  	it "is invalid without interact_peers" do
	  		ns_note.interact_peers = nil
	  		expect(ns_note).not_to be_valid
	  	end
	  	it "is invalid without discussion_init" do
	  		ns_note.discussion_init = nil
	  		expect(ns_note).not_to be_valid
	  	end
	  	it "is invalid without discussion_understand" do
	  		ns_note.discussion_understand = nil
	  		expect(ns_note).not_to be_valid
	  	end
	  	it "is invalid without comment" do
	  		ns_note.comment = nil
	  		expect(ns_note).not_to be_valid
	  	end
	  	it "is invalid without updated_by" do
	  		ns_note.updated_by = nil
	  		expect(ns_note).not_to be_valid
	  	end
	  	it "is invalid without group_date" do
	  		ns_note.group_date = nil
	  		expect(ns_note).not_to be_valid
	  	end
	end
	context "Associations:" do
		it " 'belongs_to' (many-to-one with) ns_group " do
			expect(ns_note).to belong_to :ns_group
		end
	end
end
