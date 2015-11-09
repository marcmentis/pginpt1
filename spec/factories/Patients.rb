FactoryGirl.define do 
	factory :patient do
		# NB: DON'T NEED and CAN'T create the 'has_many side'
			# association :mx_assessment, strategy: :build

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