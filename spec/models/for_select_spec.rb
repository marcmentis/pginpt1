require 'rails_helper'

describe "ForSelect Model:" do
	let(:forselect) {build(:for_select)}

	context "Validations:" do
		it "has a valid factory" do
			expect(build(:for_select)).to be_valid
		end

		it "is valid with code, value, text, grouper, option_order, facility" do
			forselect = build(:for_select)
			forselect.valid?
			expect(forselect).to be_valid
		end

		it "is invalid without code" do
			forselect = build(:for_select, code: nil)
			forselect.valid?
			expect(forselect.errors[:code]).to include ("can't be blank")
		end

		it "is invalid without value" do
			forselect = build(:for_select, value: nil)
			forselect.valid?
			expect(forselect.errors[:value]).to include ("can't be blank")
		end

		it "is invalid without text" do
			forselect = build(:for_select, text: nil)
			forselect.valid?
			expect(forselect.errors[:text]).to include ("can't be blank")
		end

		it "is invalid without order (option_order)" do
			forselect = build(:for_select, option_order: nil)
			forselect.valid?
			expect(forselect.errors[:option_order]).to include ("can't be blank")
		end

		it "is invalid without facility" do
			forselect = build(:for_select, facility: nil)
			forselect.valid?
			expect(forselect.errors[:facility]).to include ("can't be blank")
		end
	end



	
end