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
end

