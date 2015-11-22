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

	context "jqGrid OBJECT ('complex_search' jqGrid tables)" do
		before(:each) do
			@subject = build(:for_select)
			@subject1 = create(:for_select, 
										facility: '0013', 
										code: "ACode1",
										value: "Value1",
										text: 'Value1',
										grouper: 'grp1',
										option_order: 1)
			@subject2 = create(:for_select, 
										facility: '0025', 
										code: "ACode1",
										value: "Value1",
										text: 'Value1',
										grouper: 'grp1',
										option_order: 1)
							
			@subject3 = create(:for_select, 
										facility: '0013', 
										code: "ACode1",
										value: "Value2",
										text: 'Value2',
										grouper: 'grp1',
										option_order: 2)
			@subject4 = create(:for_select, 
										facility: '0013', 
										code: "BCode2",
										value: "Value1",
										text: 'Value1',
										grouper: 'grp2',
										option_order: 3)
			
		end
		context "has correct structure and page/record calculations" do
			# params = {"facility"=>"-1", "code"=>"", "value"=>"", "text"=>"", "grouper"=>"", "option_order"=>"", "_search"=>"false", "nd"=>"1447785710595", "rows"=>"15", "page"=>"1", "sidx"=>"code", "sord"=>"asc", "controller"=>"for_selects", "action"=>"complex_search"}
			# @jqGrid_obj = {"total"=>1, "page"=>1, "records"=>2, "rows"=>[{"id"=>10020, "cell"=>#<User id: 10020, firstname: "FirstTest1", lastname: "FirstLast1", authen: "pgtest1", facility: "0013", email: "pgtest@mail", firstinitial: "F", middleinitial: nil, updated_by: nil, created_at: "2015-11-05 16:57:18", updated_at: "2015-11-05 16:57:18">},{...}]}
			before(:each) do
				@params = {facility: "-1", 
							code: "", 
							value: "", 
							text: "", 
							grouper: "", 
							option_order: "", 
							rows: "15", 
							page: "1", 
							sidx: "code", 
							sord: "asc"
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
				expect(jqGrid_obj["rows"][1]["cell"][:facility]).to eq("0025")
			end
			it "'sidx' (ordering) is correct" do
				jqGrid_obj = @subject.get_jqGrid_obj(@params)
				expect(jqGrid_obj["rows"][3]["cell"][:code]).to eq("BCode2")
			end
		end
		context "Matching Parameters" do
			context "Correctly filters these single paramaters" do
				it "facility" do
					@params = {facility: "0013", 
								code: "", 
								value: "", 
								text: "",
								grouper: "",
								option_order: "",
								rows: "15", 
								page: "1", 
								sidx: "code", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(3)
				end 
				it "code" do
					@params = {facility: "-1",
								code: "AC", 
								value: "",  
								text: "",
								grouper: "",
								option_order: "",
								rows: "15", 
								page: "1", 
								sidx: "code", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(3)
					expect(jqGrid_obj["rows"][2]["cell"][:value]).to eq("Value2")
				end			
				it "value" do
					@params = {facility: "-1",
								code: "", 
								value: "Value2",  
								text: "",
								grouper: "",
								option_order: "",
								rows: "15", 
								page: "1", 
								sidx: "code", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:value]).to eq("Value2")
				end				
				it "text " do
					@params = {facility: "-1",
								code: "", 
								value: "",  
								text: "Value1",
								grouper: '',
								option_order: "",
								rows: "15", 
								page: "1", 
								sidx: "code", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(3)
					expect(jqGrid_obj["rows"][0]["cell"][:text]).to eq("Value1")
					expect(jqGrid_obj["rows"][2]["cell"][:code]).to eq("BCode2")
				end			
				it "grouper" do
					@params = {facility: "-1",
								code: "", 
								value: "",  
								text: "",
								grouper: "grp2",
								option_order: "",
								rows: "15", 
								page: "1", 
								sidx: "code", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:grouper]).to eq("grp2")
				end
				it "option_order" do
					@params = {facility: "-1", 
								code: "", 
								value: "", 
								text: "",
								grouper: '',
								option_order: "2",
								rows: "15", 
								page: "1", 
								sidx: "code", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:option_order]).to eq(2)
				end			
			end
			context "Correctly filters multiple parameters ('and') method" do
				it "i.e, given facility and code" do
					@params = {facility: "0013", 
								code: "ACode1", 
								value: "", 
								text: "",
								grouper: "",
								option_order: "",
								rows: "15", 
								page: "1", 
								sidx: "code", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(2)
					expect(jqGrid_obj["rows"][1]["cell"][:option_order]).to eq(2)
				end
			end
		end
		context "Non-Matching Parameters" do
			context "Returns no records in jqGrid object" do
				it "single parameter" do
					@params = {facility: "00", 
								code: "", 
								value: "", 
								text: "",
								grouper: '',
								option_order: "",
								rows: "15", 
								page: "1", 
								sidx: "code", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(0)
				end
				it "multiple parameters (any one parameter non-matching)" do
					@params = {facility: "-1", 
								code: "",  
								value: "V", 
								text: "Q",
								grouper: "",
								option_order: "",
								rows: "15", 
								page: "1", 
								sidx: "code", 
								sord: "asc" 
							}
					jqGrid_obj = @subject.get_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(0)
				end

			end
		end		
	end


	
end