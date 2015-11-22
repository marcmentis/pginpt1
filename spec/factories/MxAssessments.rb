FactoryGirl.define do
	factory :mx_assessment do
		# NB: Don't need explicit association for 'shoulda' matchers
			# association :patient, strategy: :build

		danger_yn {Faker::Lorem.word}
		drugs_last_changed {Faker::Lorem.word}
		drugs_not_why {Faker::Lorem.sentences}
		drugs_change_why {Faker::Lorem.sentences}
		psychsoc_last_changed {Faker::Lorem.word}
		psychsoc_not_why {Faker::Lorem.sentences}
		psychsoc_change_why {Faker::Lorem.sentences}
		meeting_date {Faker::Date.forward(14)}
		patient_id {Faker::Number.number(7)}
		pre_date_yesno {Faker::Lorem.word}
		pre_date_no_why  {Faker::Lorem.sentences}
		pre_date {Faker::Date.forward(14)}
		updated_by {Faker::Name.last_name}

		factory :invalid_mx_assessment do
			danger_yn nil
		end

		# patient

		# association :patient, factory: :facility_site_patient

		# trait :match_assessment do
		# 	patient_id do
		# 		Patient.find_by(id: "1") || FactoryGirl.create(:patient, id: "1")
		# 	end
		# end
	end
end