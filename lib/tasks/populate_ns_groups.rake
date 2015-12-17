# Create groups for ns_groups
namespace :db do
	desc "Fill ns_groups with data"
	task populate_ns_groups: :environment do
		20.times do |n| 
			duration = Faker::Number.number(1)
			groupname = Faker::Name.name
			leader = Faker::Name.last_name
			groupsite = Faker::Name.name
			updated_by = Faker::Name.last_name

			NsGroup.create!(duration: duration,
							groupname: groupname,
							leader: leader,
							groupsite: groupsite,
							facility: '0013',
							updated_by: updated_by)
		end
		20.times do |n| 
			duration = Faker::Number.number(1)
			groupname = Faker::Name.name
			leader = Faker::Name.last_name
			groupsite = Faker::Name.name
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