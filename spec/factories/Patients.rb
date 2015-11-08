FactoryGirl.define do 
	factory :patient do
		firstname {Faker::Name.first_name}
		lastname {Faker::Name.last_name}
		identifier {Faker::Number.number(7)}
		facility {Faker::Name.name}
		site {Faker::Name.name}
		doa {Faker::Date.backward(100)}
		dob {Faker::Date.backward(1000)}
		dod {Faker::Date.backward(14)}
		updated_by {Faker::Name.last_name}
	end
end