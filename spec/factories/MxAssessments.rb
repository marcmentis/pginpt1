FactoryGirl.define do
	factory :mx_assessment do
		association :patient
		danger_yn {Faker::Lorem.word}
		drugs_last_changed {Faker::Lorem.word}
		drugs_not_why {Faker::Lorem.sentences}
	end
end