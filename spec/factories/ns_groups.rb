FactoryGirl.define do
  factory :ns_group do
    duration {Faker::Number.number(4)}
	groupname {Faker::Name.name}
	leader {Faker::Name.last_name}
	groupsite {Faker::Name.name}
	facility {Faker::Name.name}
	updated_by {Faker::Name.last_name}

	factory :invalid_ns_group do
		groupname nil
	end
  end

end
