require "rails_helper"

describe "MxAssessment:" do
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

# 	context "Filtering MxAssessments:"
# 		let(:patient) {Patient.create(
# 			firstname: 'Aaron',
# 			lastname: 'Abot',
# 			identifier: '34245',
# 			facility: '0013',
# 			site: '81/101',
# 			doa: '2014-11-10',
# 			dob: '1987-11-10',
# 			dod: '2015-11-10',
# 			updated_by: 'mentis'
# 		)}
# 		let(:mx_assessment) {MxAssessment.create(
# 				danger_yn: "Y",
# 				drugs_last_changed: "Y",
# 				drugs_not_why: "Some drug reason",
# 				drugs_change_why: "",
# 				psychsoc_last_changed: "",
# 				psychsoc_not_why: "",
# 				psychsoc_change_why: "",
# 				meeting_date: "2015-11-10",
# 				patient_id: patient.id,
# 				pre_date_yesno: "",
# 				pre_date_no_why: "",
# 				pre_date: "",
# 				updated_by: ""
# 			)}
		

# 		it "filters correctly" do
# 			# params = {"mx_assessment"=>{"site"=>"81/101", "new_date"=>"", "date_history"=>"2015-11-10"}, "_"=>"1447177332822"}
# 			params = {site:"81/101", new_date: "", date_history: "2015-11-10"}
# 			chosen_date = "2015-11-10"
# 		 	facility = "0013"
# 		 	y = patient.mx_assessments
# 		 	x = MxAssessment.pat_all_done(params, chosen_date, facility)
# byebug
# 		 	expect(all_done).to eq []
# 		# expect(conditions).to include [firstname: "Aaron", lastname: "Abot", facility: "Pilgrim"]
# 	end
end

