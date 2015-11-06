require 'rails_helper'

describe "Patient authentication" do
	it "is valid with a firstname, lastname, number, facility, ward, doa" do
		patient = Patient.new(
			firstname: 'Aaron',
			lastname: 'Sumner',
			identifier: '343256',
			facility: 'Pilgrim',
			site: '81/101',
			doa: '10/11/2015')
		expect(patient).to be_valid
	end
	
	it "is invalid without a firstname" do 
		patient = Patient.new(firstname: nil)
		patient.valid?
		expect(patient.errors[:firstname]).to include("can't be blank")
	end
	it "is invalid without a lastname" do
		patient = Patient.new(lastname: nil)
		patient.valid?
		expect(patient.errors[:lastname]).to include("can't be blank")
	end
	it "is invalid without a number (identifier)" do
		patient = Patient.new(identifier: nil)
		patient.valid?
		expect(patient.errors[:identifier]).to include("can't be blank")
	end
	it "is invalid without a facility" do
		patient = Patient.new(facility: nil)
		patient.valid?
		expect(patient.errors[:facility]).to include("can't be blank")
	end
	it "is invalid without a ward (site)" do
		patient = Patient.new(site: nil)
		patient.valid?
		expect(patient.errors[:site]).to include("can't be blank")
	end
	it "is invalid without a doa (date of admission)" do
		patient = Patient.new(doa: nil)
		patient.valid?
		expect(patient.errors[:doa]).to include("can't be blank")
	end
end