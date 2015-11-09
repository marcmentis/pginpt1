FactoryGirl.define do
	factory :role do
		name {Faker::Lorem.name}
		resource_id {Faker::Number.number(10)}
		# resource_type {Faker::Lorem.name}
	end
end