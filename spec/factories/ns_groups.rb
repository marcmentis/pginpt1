FactoryGirl.define do
  factory :ns_group do
    duration {Faker::Number.number(4)}
	groupname {Faker::Name.name}
	leader {Faker::Name.last_name}
	site {Faker::Name.name}
  end

end
