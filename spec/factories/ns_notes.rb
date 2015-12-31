FactoryGirl.define do
  factory :ns_note do
    ns_group_id {Faker::Number.number(4)}
	patient_id {Faker::Number.number(4)}
	participate {Faker::Lorem.word}
	respond {Faker::Lorem.word}
	interact_leader {Faker::Lorem.word}
	interact_peers {Faker::Lorem.word}
	discussion_init {Faker::Lorem.word}
	discussion_understand {Faker::Lorem.word}
	comment {Faker::Lorem.paragraph}
	updated_by {Faker::Name.last_name}
	group_date {Faker::Date.backward(50)}
  end

end


