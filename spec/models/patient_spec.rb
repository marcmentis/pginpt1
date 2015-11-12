require 'rails_helper'

describe "Patient Model:" do
	let(:patient) {build(:patient)}
	context "Validations:" do
		it "has a valid factory" do
			expect(build(:patient)).to be_valid		
		end

		it "is valid with a firstname, lastname, number, facility, ward, doa, dob, dod, updated_by" do
			expect(patient).to be_valid
		end
		
		it "is invalid without a firstname" do 
			patient.firstname = nil
			patient.valid?
			expect(patient.errors[:firstname]).to include("can't be blank")
		end
		it "is invalid without a lastname" do
			patient = build(:patient, lastname: nil)
			patient.valid?
			expect(patient.errors[:lastname]).to include("can't be blank")
		end
		it "is invalid without a number (identifier)" do
			patient = build(:patient, identifier: nil)
			patient.valid?
			expect(patient.errors[:identifier]).to include("can't be blank")
		end
		it "is invalid with duplicate identifier (number)" do
			create(:patient, identifier: '123456')
			patient = build(:patient, identifier: '123456')
			patient.valid?
			expect(patient.errors[:identifier]).to include("has already been taken")
		end

		it "is invalid without a facility" do
			patient = build(:patient, facility: nil)
			patient.valid?
			expect(patient.errors[:facility]).to include("can't be blank")
		end
		it "is invalid without a ward (site)" do
			patient = build(:patient, site: nil)
			patient.valid?
			expect(patient.errors[:site]).to include("can't be blank")
		end
		it "is invalid without a doa (date of admission)" do
			patient =  build(:patient, doa: nil)
			patient.valid?
			expect(patient.errors[:doa]).to include("can't be blank")
		end
	end

	context "Associations:" do
		it " 'has_many' mx_assessments" do
			expect(patient).to have_many :mx_assessments
		end
	end

	
end