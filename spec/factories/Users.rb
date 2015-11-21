FactoryGirl.define do
	factory :user do
		firstname {Faker::Name.first_name}
		lastname {Faker::Name.last_name}
		authen {Faker::Lorem.word}
		facility {Faker::Name.name}
		email {Faker::Internet.email}
		firstinitial {Faker::Number.number(1)}
		middleinitial {Faker::Number.number(1)}
		updated_by {Faker::Name.last_name}

		factory :invalid_user do
			firstname nil
		end

		# factory :Arole do
		# 	after(:create) { |user| user.add_rle(:Arole)}
		# end

	end
end