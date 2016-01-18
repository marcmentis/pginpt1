# Create groups for ns_groups
namespace :db do
	desc "Fill ns_groups with data"
	task populate_ns_groups: :environment do
		10.times do |n| 
			duration = 1.0
			groupname = Faker::Lorem.word
			leader = Faker::Name.last_name
			groupsite = Faker::Lorem.word
			updated_by = Faker::Name.last_name

			NsGroup.create!(duration: duration,
							groupname: groupname,
							leader: leader,
							groupsite: groupsite,
							facility: '0013',
							updated_by: updated_by)
		end
		10.times do |n| 
			duration = 2.5
			groupname = Faker::Lorem.word
			leader = Faker::Name.last_name
			groupsite = Faker::Lorem.word
			updated_by = Faker::Name.last_name

			NsGroup.create!(duration: duration,
							groupname: groupname,
							leader: leader,
							groupsite: groupsite,
							facility: '0013',
							updated_by: updated_by)
		end
		10.times do |n| 
			duration = 1.0
			groupname = Faker::Lorem.word
			leader = Faker::Name.last_name
			groupsite = Faker::Lorem.word
			updated_by = Faker::Name.last_name

			NsGroup.create!(duration: duration,
							groupname: groupname,
							leader: leader,
							groupsite: groupsite,
							facility: '0025',
							updated_by: updated_by)
		end
		10.times do |n| 
			duration = 2.5
			groupname = Faker::Lorem.word
			leader = Faker::Name.last_name
			groupsite = Faker::Lorem.word
			updated_by = Faker::Name.last_name

			NsGroup.create!(duration: duration,
							groupname: groupname,
							leader: leader,
							groupsite: groupsite,
							facility: '0025',
							updated_by: updated_by)
		end
	end
end