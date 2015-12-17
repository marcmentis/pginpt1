class NsGroup < ActiveRecord::Base
	has_and_belongs_to_many :patients

	validates :duration, presence: true
	validates :groupname, presence: true
	validates :leader, presence: true
	validates :groupsite, presence: true
	validates :facility, presence: true
	validates :updated_by, presence: true
end
