FactoryGirl.define do
	factory :user do
		firstname {Faker::Name.first_name}
		lastname {Faker::Name.last_name}
		authen {Faker::Lorem.word}
		facility {Faker::Name.name}
		email {Faker::Internet.email}
		firstinitial {Faker::Internet.password(1)}
		middleinitial {Faker::Internet.password(1)}
		updated_by {Faker::Name.last_name}
		id {Faker::Number.number(4)}

		factory :invalid_user do
			firstname nil
		end

		# factory :Arole do
		# 	after(:create) { |user| user.add_rle(:Arole)}
		# end

	end
end