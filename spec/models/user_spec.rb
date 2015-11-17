require 'rails_helper'

describe "User Model:" do
	let(:user) {build(:user)}

	context "Validations:" do
		it "has a valid factory" do
			expect(build(:user)).to be_valid
		end

		it "is valid with firstname, lastname, authen, facility, email, firstinitial, middleinitial, updated_by" do
			user = build(:user)
			expect(user).to be_valid
		end

		it "is invalid without a firstname" do
			user.firstname = nil
			user.valid?
			expect(user.errors[:firstname]).to include("can't be blank")
		end

		it "is invalid without a lastname" do
			user.lastname = nil
			user.valid?
			expect(user.errors[:lastname]).to include ("can't be blank")
		end

		it "is invalid without authentication (authen)" do
			user.authen = nil
			user.valid?
			expect(user.errors[:authen]).to include ("can't be blank")
		end

		it "is invalid with deplicate authentication" do
			create(:user, authen: "authen1")
			user.authen = "authen1"
			user.valid?
			expect(user.errors[:authen]).to include ("has already been taken")
		end

		it "is invalid without a facility" do
			user.facility = nil
			user.valid?
			expect(user.errors[:facility]).to include ("can't be blank")
		end

		it "is invalid without an email" do
			user.email = nil
			user.valid?
			expect(user.errors[:email]).to include ("can't be blank")
		end

		it "is invalid with duplicate email" do
			create(:user, email: "test1@mail.com")
			user.email = "test1@mail.com"
			user.valid?
			expect(user.errors[:email]).to include("has already been taken")
		end

		it "is invalid without a first initial" do
			user.firstinitial = nil
			user.valid?
			expect(user.errors[:firstinitial]).to include ("can't be blank")
		end
	end

	context "Associations:" do
		it " 'many-to-many' with roles" do
			expect(user).to have_and_belong_to_many :roles
		end	
	end

	context "jqGrid OBJECT ('complex_search' jqGrid tables)" do
		before(:each) do
			@subject = build(:user)
			@patient1 = create(:user, facility: '0013', 
										lastname: "Adams",
										firstname: "Abigail",
										authen: '1',
										firstinitial: 'A',
										middleinitial: 'J')
			@subject2 = create(:user, facility: '0025', 
										lastname: "Davies",
										firstname: "Dora",
										authen: '4',
										firstinitial: 'D',
										middleinitial: 'P')
							
			@subject3 = create(:user, facility: '0013', 
										lastname: "Carey",
										firstname: "Chris",
										authen: '2',
										firstinitial: 'C',
										middleinitial: 'R')
			@subject4 = create(:user, facility: '0013', 
										lastname: "Beauford",
										firstname: "Ben",
										authen: '3',
										firstinitial: 'B',
										middleinitial: 'S')
			
		end
		context "has correct structure and page/record calculations" do
			# params = {"facility"=>"-1", "firstname"=>"", "lastname"=>"", "authen"=>"", "email"=>"undefined", "firstinitial"=>"", "middleinitial"=>"", "_search"=>"false", "nd"=>"1447777078042", "rows"=>"15", "page"=>"1", "sidx"=>"lastname", "sord"=>"asc", "controller"=>"users", "action"=>"complex_search"}
			# @jqGrid_obj = {"total"=>1, "page"=>1, "records"=>2, "rows"=>[{"id"=>10020, "cell"=>#<User id: 10020, firstname: "FirstTest1", lastname: "FirstLast1", authen: "pgtest1", facility: "0013", email: "pgtest@mail", firstinitial: "F", middleinitial: nil, updated_by: nil, created_at: "2015-11-05 16:57:18", updated_at: "2015-11-05 16:57:18">},{...}]}
			before(:each) do
				@params = {facility: "-1", 
							firstname: "", 
							lastname: "", 
							authen: "", 
							email: "undefined", 
							firstinitial: "", 
							middleinitial: "", 
							# "_search"=>"false", 
							# "nd"=>"1447777078042", 
							rows: "15", 
							page: "1", 
							sidx: "lastname", 
							sord: "asc" 
							# "controller"=>"users", 
							# "action"=>"complex_search"
						}

			end
			it "'total' exists and has correct value" do
				jqGrid_obj = @subject.get_jqGrid_obj(@params)
				expect(jqGrid_obj["total"]).to eq(1)
			end
			it "'page' exists and has correct value" do
				jqGrid_obj = @subject.get_jqGrid_obj(@params)
				expect(jqGrid_obj["page"]).to eq(1)
			end
			it "'records' exists and have correct value" do
				jqGrid_obj = @subject.get_jqGrid_obj(@params)
				expect(jqGrid_obj["records"]).to eq(4)
			end
			it "'rows' and 'cells' exists and have correct values" do
				jqGrid_obj = @subject.get_jqGrid_obj(@params)
				expect(jqGrid_obj["rows"][1]["cell"][:lastname]).to eq("Beauford")
			end
			it "'sidx' (ordering) is correct" do
				jqGrid_obj = @subject.get_jqGrid_obj(@params)
				expect(jqGrid_obj["rows"][3]["cell"][:lastname]).to eq("Davies")
			end
		end
		context "Matching Parameters" do
			context "Correctly filters these single paramaters" do
				it "facility" do
					@params = {firstname: "", 
								lastname: "", 
								authen: "", 
								facility: "0013", 
								firstinitial: "",
								middleinitial: "",
								rows: "15", 
								page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(3)
				end 
				it "lastname" do
					@params = {firstname: "", 
								lastname: "Da", 
								authen: "", 
								facility: "-1", 
								firstinitial: "",
								middleinitial: "",
								rows: "15", 
								page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Davies")
				end			
				it "firstname" do
					@params = {firstname: "Ch", 
								lastname: "", 
								authen: "", 
								facility: "-1", 
								firstinitial: "",
								middleinitial: "",
								rows: "15", 
								page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:firstname]).to eq("Chris")
				end				
				it "authen " do
					@params = {firstname: "", 
								lastname: "", 
								authen: "3", 
								facility: "-1", 
								firstinitial: "",
								middleinitial: '',
								rows: "15", 
								page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:authen]).to eq("3")
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Beauford")
				end			
				it "firstinitial" do
					@params = {firstname: "", 
								lastname: "", 
								authen: "", 
								facility: "-1", 
								firstinitial: "A",
								middleinitial: '',
								rows: "15", 
								page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
				end
				it "middleinitial" do
					@params = {firstname: "", 
								lastname: "", 
								authen: "", 
								facility: "-1", 
								firstinitial: "",
								middleinitial: 'R',
								rows: "15", 
								page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Carey")
				end			
			end
			context "Correctly filters multiple parameters ('and') method" do
				it "i.e, given lastname and facility" do
					@params = {firstname: "", 
								lastname: "A", 
								authen: "", 
								facility: "0013", 
								firstinitial: "",
								middleinitial: "",
								rows: "15", 
								page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
				end
			end
		end
		context "Non-Matching Parameters" do
			context "Returns no records in jqGrid object" do
				it "single parameter" do
					@params = {firstname: "", 
								lastname: "", 
								authen: "", 
								facility: "00", 
								firstinitial: "",
								middleinitial: '',
								rows: "15", page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(0)
				end
				it "multiple parameters (any one parameter non-matching)" do
					@params = {firstname: "", 
								lastname: "", 
								authen: "1", 
								facility: "-1", 
								firstinitial: "Q",
								middleinitial: "",
								rows: "15", page: "1", 
								sidx: "lastname", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(0)
				end

			end
		end		
	end
end