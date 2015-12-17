class CreateJoinTableNsGroupPatient < ActiveRecord::Migration
  def change
    create_join_table :ns_groups, :patients do |t|
       t.index([:ns_group_id, :patient_id], name: 'ns-patient-id')
       t.index([:patient_id, :ns_group_id], name: 'patient-ns-id')
    end
  end
end
