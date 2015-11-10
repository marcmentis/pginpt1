FactoryGirl.define do
	factory :for_select do
		code {Faker::Lorem.word}
		value {Faker::Lorem.word}
		text {Faker::Lorem.word}
		grouper {Faker::Lorem.word}
		option_order {Faker::Number.number(1)}
		facility {Faker::Name.name}
	end
end