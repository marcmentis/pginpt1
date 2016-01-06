class NsNote < ActiveRecord::Base
	belongs_to :ns_group
	belongs_to :patient

	validates :ns_group_id, presence: true
	validates :patient_id, presence: true
	validates :participate, presence: true
	validates :respond, presence: true
	validates :interact_leader, presence: true
	validates :interact_peers, presence: true
	validates :discussion_init, presence: true
	validates :discussion_understand, presence: true
	validates :comment, presence: true
	validates :updated_by, presence: true
	validates :group_date, presence: true
end
