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
		it " 'has_and_belongs_to_many' (many-to-many with) ns_groups " do
			expect(patient).to have_and_belong_to_many :ns_groups
		end
	end

	context "jqGrid OBJECT ('complex_search' populates jqGrid tables)" do
		before(:each) do
			@patient = build(:patient)
			@patient1 = create(:patient, facility: '0013', 
										lastname: "Adams",
										firstname: "Abigail",
										identifier: '1',
										site: 'ward1')
			@patient2 = create(:patient, facility: '0025', 
										lastname: "Davies",
										firstname: "Dora",
										identifier: '4',
										site: 'ward1')
							
			@patient3 = create(:patient, facility: '0013', 
										lastname: "Carey",
										firstname: "Chris",
										identifier: '2',
										site: 'ward1')
			@patient4 = create(:patient, facility: '0013', 
										lastname: "Beauford",
										firstname: "Ben",
										identifier: '3',
										site: 'ward2')
			
		end
		context "has correct structure and page/record calculations" do
			# jqGrid_obj = {"total"=>1, "page"=>1, "records"=>1, "rows"=>[{"id"=>12275, "cell"=>#<Patient id: 12275, firstname: "Mack", lastname: "Champlin", identifier: "8799244", facility: "0013", site: "Raoul Stokes", doa: "2015-09-20 00:00:00", dob: "2015-03-29 00:00:00", dod: "2015-11-09 00:00:00", updated_by: "Konopelski", created_at: "2015-11-16 21:28:47", updated_at: "2015-11-16 21:28:47">}]}
			before(:each) do
				@params = {firstname: "", 
							lastname: "", 
							identifier: "", 
							facility: "-1", 
							site: "-1",
							rows: "15", page: "1", 
							sidx: "lastname", 
							sord: "asc" 
						}
			end
			it "'total' exists and has correct value" do
				jqGrid_obj = @patient.get_jqGrid_obj(@params)
				expect(jqGrid_obj["total"]).to eq(1)
			end
			it "'page' exists and has correct value" do
				jqGrid_obj = @patient.get_jqGrid_obj(@params)
				expect(jqGrid_obj["page"]).to eq(1)
			end
			it "'records' exists and have correct value" do
				jqGrid_obj = @patient.get_jqGrid_obj(@params)
				expect(jqGrid_obj["records"]).to eq(4)
			end
			it "'rows' and 'cells' exists and have correct values" do
				jqGrid_obj = @patient.get_jqGrid_obj(@params)
				expect(jqGrid_obj["rows"][1]["cell"][:lastname]).to eq("Beauford")
			end
			it "'sidx' (ordering) is correct" do
				jqGrid_obj = @patient.get_jqGrid_obj(@params)
				expect(jqGrid_obj["rows"][3]["cell"][:lastname]).to eq("Davies")
			end
		end
		context "Valid Parameters" do
			context "Correctly filters these single paramaters" do
				it "facility" do
					@params = {firstname: "", 
								lastname: "", 
								identifier: "", 
								facility: "0013", 
								site: "-1",
								rows: "15", page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @patient.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(3)
				end 
				it "site" do
					@params = {firstname: "", 
								lastname: "", 
								identifier: "", 
								facility: "-1", 
								site: "ward1",
								rows: "15", page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @patient.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(3)
				end
				it "firstname" do
					@params = {firstname: "A", 
								lastname: "", 
								identifier: "", 
								facility: "-1", 
								site: "-1",
								rows: "15", page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @patient.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:firstname]).to eq("Abigail")
				end
				it "lastname" do
					@params = {firstname: "", 
								lastname: "Davies", 
								identifier: "", 
								facility: "-1", 
								site: "-1",
								rows: "15", page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @patient.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Davies")
				end
				it "identifier (i.e., C#)" do
					@params = {firstname: "", 
								lastname: "", 
								identifier: "3", 
								facility: "-1", 
								site: "-1",
								rows: "15", page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @patient.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:identifier]).to eq("3")
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Beauford")
				end
			end
			context "Correctly filters multiple parameters ('and') method" do
				it "i.e, given facility and site" do
					@params = {firstname: "", 
								lastname: "", 
								identifier: "", 
								facility: "0013", 
								site: "ward1",
								rows: "15", page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @patient.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(2)
					expect(jqGrid_obj["rows"][1]["cell"][:lastname]).to eq("Carey")
				end
			end
		end
		context "Invalid Parameters" do
			context "Returns no records in jqGrid object" do
				it "single parameter" do
					@params = {firstname: "", 
								lastname: "", 
								identifier: "", 
								facility: "00", 
								site: "-1",
								rows: "15", page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @patient.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(0)
				end
				it "multiple parameters (any one parameter invalid)" do
					@params = {firstname: "", 
								lastname: "", 
								identifier: "", 
								facility: "00", 
								site: "ward1",
								rows: "15", page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @patient.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(0)
				end

			end
		end		
	end

	
end