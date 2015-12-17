json.array!(@ns_groups) do |ns_group|
  json.extract! ns_group, :id, :duration, :groupname, :leader, :groupsite, :facility, :updated_by
  json.url ns_group_url(ns_group, format: :json)
end
