require "rails_helper"

describe "MxAssessment Model:" do
	let(:mx_assessment) {build(:mx_assessment)}

	context "Validations:" do
		it "has a valid factory" do
			expect(build(:mx_assessment)).to be_valid
		end

		it "is valid with: hospitalized, medsLastChanged, medsNotChangedWhy, medsChangedWhy, psychLastChanged, psychNotChangedWhy, psychChangedWhy, meetingDate, patientID, dcDateYesNo, dcDateNoWhy, updatedBy" do
			expect(mx_assessment).to be_valid
		end

		it "is invalid without danger_yn" do
			mx_assessment.danger_yn = nil
			expect(mx_assessment).not_to be_valid
		end
	end

	context "Associations:" do
		it " 'belongs_to' Patient" do
			expect(mx_assessment).to belong_to :patient
		end
	end

	# context "class methods" do
	# 	it "returns patients with MxAssess notes for given date" do
			
	# 		a_note = create(:mx_assessment, meeting_date: '2015-11-10')
	# 		b_note = create(:mx_assessment, meeting_date: '2015-11-10')
	# 		c_note = create(:mx_assessment, meeting_date: '2015-11-11')

	# 		patient = create(:patient, id: '1')
	# 		mx_assessment = create(:mx_assessment, patient_id: '1')

	# 		match_assessment = create(:mx_assessment, :match_assessment)

	# 		byebug


	# 		params = {"site"=>"81/101", "new_date"=>"", "date_history"=>"2015-11-10"}
	# 		# params = {date_history: '2015-11-10'}
	# 		chosen_date = '2015-11-10'
	# 		facility = '0013'

	# 		expect(MxAssessment.pat_all_done(params, chosen_date, facility)).to match_array([])

	# 	end
	# end
end

context "jqGrid OBJECT ('complex_search' jqGrid tables)" do
		before(:each) do
			@mx_assessment = build(:mx_assessment)
			@subject = build(:patient, facility: "0013", lastname: "Adams", site: 'ward1', id: '678', doa: "2015-10-08")
			@subject2 = build(:patient, facility: "0013", lastname: "Baker", doa: "2015-10-09")
			@subject3 = build(:patient, facility: "0025", lastname: "Carey", id: '1234', doa: "2015-10-10")
			# 2.times.each { create(:mx_assessment, danger_yn: 'Y', patient: @subject)}
			# 2.times.each { create(:mx_assessment, danger_yn: 'N', pre_date: "2015-12-09", patient: @subject2)}

			create(:mx_assessment, danger_yn: 'N', pre_date: "2015-12-09", patient: @subject2)

			create(:mx_assessment, 
									meeting_date: '2015-11-08',
									pre_date: "2015-12-08",
									patient: @subject
									)
			create(:mx_assessment, danger_yn: 'Y', 
									drugs_last_changed: '0-8Weeks',
									psychsoc_last_changed: '0-3Months',
									pre_date_yesno: 'No',
									meeting_date: '2015-11-09',
									pre_date: "2015-12-08",
									patient: @subject
									)
			create(:mx_assessment, danger_yn: 'N', 
									drugs_last_changed: 'Gt8Weeks',
									psychsoc_last_changed: 'Gt3Months',
									pre_date_yesno: 'Yes',
									meeting_date: '2015-11-10',
									pre_date: "2015-12-08",
									patient: @subject
									)
			create(:mx_assessment, pre_date: "2015-12-10", patient: @subject3)
	
		end
		context "has correct structure and page/record calculations" do
			# 	# params = {"facility"=>"-1", "code"=>"", "value"=>"", "text"=>"", "grouper"=>"", "option_order"=>"", "_search"=>"false", "nd"=>"1447785710595", "rows"=>"15", "page"=>"1", "sidx"=>"code", "sord"=>"asc", "controller"=>"for_selects", "action"=>"complex_search"}
			# 	# @jqGrid_obj = {"total"=>1, "page"=>1, "records"=>2, "rows"=>[{"id"=>10020, "cell"=>#<User id: 10020, firstname: "FirstTest1", lastname: "FirstLast1", authen: "pgtest1", facility: "0013", email: "pgtest@mail", firstinitial: "F", middleinitial: nil, updated_by: nil, created_at: "2015-11-05 16:57:18", updated_at: "2015-11-05 16:57:18">},{...}]}
		
			before(:each) do
				@params = {facility: "0013", 
					allLatestNote: "All", 
					dma: "", 
					dmb: "", 
					dda: "", 
					ddb: "", 
					dpa: "", 
					dpb: "", 
					pid: "-1", 
					site: "-1", 
					danger_yn: "-1", 
					drugs_last_changed: "-1", 
					psychsoc_last_changed: "-1", 
					pre_date_yesno: "-1",
					rows: "15", 
					page: "1", 
					sidx: "lastname", 
					sord: "asc"
					}

			end
			it "'total' exists and has correct value" do
				jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
				expect(jqGrid_obj["total"]).to eq(1)
			end
			it "'page' exists and has correct value" do
				jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
				expect(jqGrid_obj["page"]).to eq(1)
			end
			it "'records' exists and have correct value" do
				jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
				expect(jqGrid_obj["records"]).to eq(4)
			end
			it "'rows' and 'cells' exists and have correct values" do
				jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
				expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
			end
			it "'sidx' (ordering) is correct" do
				jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
				expect(jqGrid_obj["rows"][3]["cell"][:lastname]).to eq("Baker")
			end
		end
		context "Matching Parameters" do
			context "Correctly filters these single paramaters" do
				it "shows rows if appropriate 'nul' value given for: site, patient, hospitalize,\
					drugs_last_changed, psychsoc_last_changed, dc_date_yn, meeting_date, doa," do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "-1", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(4)
				end 
				it "facility" do
					@params = {facility: "0025", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "-1", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Carey")
				end 
				it "site (i.e. ward)" do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "-1", 
								site: "ward1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(3)
					expect(jqGrid_obj["rows"][0]["cell"][:site]).to eq("ward1")
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
				end	
				it "patient_id (Patient name)" do
					@params = {facility: "0025", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "1234", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Carey")
				end	
				it "All notes" do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "678", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(3)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
				end	
				it "Latest note" do
					@params = {facility: "0013", 
								allLatestNote: "Latest", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "678", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
					expect(jqGrid_obj["rows"][0]["cell"][:drugs_last_changed]).to eq("Gt8Weeks")
				end	
				it "Remain in Hosp 'Yes'" do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "678", 
								site: "-1", 
								danger_yn: "Y", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
					expect(jqGrid_obj["rows"][0]["cell"][:drugs_last_changed]).to eq("0-8Weeks")
				end
				it "Remain in Hosp: 'No'" do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "678", 
								site: "-1", 
								danger_yn: "N", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
					expect(jqGrid_obj["rows"][0]["cell"][:drugs_last_changed]).to eq("Gt8Weeks")
				end 
				it "Drugs_last_changed: '0-8Weeks'" do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "678", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "0-8Weeks", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
					expect(jqGrid_obj["rows"][0]["cell"][:drugs_last_changed]).to eq("0-8Weeks")
				end
				it "Drugs_last_changed: 'Gt8Weeks'" do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "678", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "Gt8Weeks", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
					expect(jqGrid_obj["rows"][0]["cell"][:drugs_last_changed]).to eq("Gt8Weeks")
				end
				it "PsychSocial Treatment_last_changed: '0-3Months'" do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "678", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "0-3Months", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
					expect(jqGrid_obj["rows"][0]["cell"][:psychsoc_last_changed]).to eq("0-3Months")
				end	
				it "PsychSocial Treatment_last_changed: 'Gt3Months'" do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "678", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "Gt3Months", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
					expect(jqGrid_obj["rows"][0]["cell"][:psychsoc_last_changed]).to eq("Gt3Months")
				end	
				it "Discharge date set 'Yes'" do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "678", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "Yes",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
					expect(jqGrid_obj["rows"][0]["cell"][:pre_date_yesno]).to eq("Yes")
				end	
				it "Discharge date set 'No'" do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "678", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "No",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
					expect(jqGrid_obj["rows"][0]["cell"][:pre_date_yesno]).to eq("No")
				end	
				it "Meeting_date after 'after' date (excludes given date) " do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "2015-11-09", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "678", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
					expect(jqGrid_obj["rows"][0]["cell"][:meeting_date]).to eq("2015-11-10")
				end	
				it "Meeting_date before 'before' date (excludes given date) " do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "2015-11-09", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "678", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
					expect(jqGrid_obj["rows"][0]["cell"][:meeting_date]).to eq("2015-11-08")
				end	
				it "Meeting_date between 'before' and 'after' dates (excludes given dates) " do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "2015-11-08", 
								dmb: "2015-11-10", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "678", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
					expect(jqGrid_obj["rows"][0]["cell"][:meeting_date]).to eq("2015-11-09")
				end	
				it "Date of admission after 'after' date (excludes given date) " do
					@params = {facility: "0013", 
								allLatestNote: "Latest", 
								dma: "", 
								dmb: "", 
								dda: "2015-10-08", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "-1", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Baker")
				end	 	
				it "Date of admission before 'before' date (excludes given date) " do
					@params = {facility: "0013", 
								allLatestNote: "Latest", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "2015-10-09", 
								dpa: "", 
								dpb: "", 
								pid: "-1", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
					expect(jqGrid_obj["rows"][0]["cell"][:meeting_date]).to eq("2015-11-10")
				end	 
				it "Date of admission between 'after' and 'before' dates (excludes given dates) " do
					@params = {facility: "0013", 
								allLatestNote: "Latest", 
								dma: "", 
								dmb: "", 
								dda: "2015-10-07", 
								ddb: "2015-10-11", 
								dpa: "", 
								dpb: "", 
								pid: "-1", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(2)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
					expect(jqGrid_obj["rows"][1]["cell"][:lastname]).to eq("Baker")
				end	
				it "Date of discharge after 'after' date (excludes given date) " do
					@params = {facility: "0013", 
								allLatestNote: "Latest", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "2015-12-08", 
								dpb: "", 
								pid: "-1", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Baker")
				end
				it "Date of discharge before 'before' date (excludes given date) " do
					@params = {facility: "0013", 
								allLatestNote: "Latest", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "2015-12-09", 
								pid: "-1", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
				end
				it "Date of discharge between 'after' and 'before' date (excludes given date) " do
					@params = {facility: "0013", 
								allLatestNote: "Latest", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "2015-12-07", 
								dpb: "2015-12-09", 
								pid: "-1", 
								site: "-1", 
								danger_yn: "-1", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
				end	 		 	 	 	 	  	 	 		 				 				 											
			end
			context "Correctly filters multiple parameters ('and') method" do
				it "i.e, given 'latest', 'facility', 'site', drugs_last_changed, meeting_date" do
					@params = {facility: "0013", 
								allLatestNote: "Latest", 
								dma: "2015-11-09", 
								dmb: "2015-11-12", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "-1", 
								site: "ward1", 
								danger_yn: "-1", 
								drugs_last_changed: "Gt8Weeks", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(1)
					expect(jqGrid_obj["rows"][0]["cell"][:lastname]).to eq("Adams")
				end
			end
		end
		context "Non-Matching Parameters" do
			context "Returns no records in jqGrid object" do
				it "single parameter" do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "-1", 
								site: "-1", 
								danger_yn: "Rubbish", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(0)
				end
				it "multiple parameters (any one parameter non-matching)" do
					@params = {facility: "0013", 
								allLatestNote: "All", 
								dma: "", 
								dmb: "", 
								dda: "", 
								ddb: "", 
								dpa: "", 
								dpb: "", 
								pid: "-1", 
								site: "ward1", 
								danger_yn: "Rubbish", 
								drugs_last_changed: "-1", 
								psychsoc_last_changed: "-1", 
								pre_date_yesno: "-1",
								rows: "15", page: "1", sidx: "lastname", sord: "asc"
							}
					jqGrid_obj = @mx_assessment.get_mxaw_jqGrid_obj(@params)
					expect(jqGrid_obj["records"]).to eq(0)
				end

			end
		end		
end


