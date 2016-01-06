class CreateNsNotes < ActiveRecord::Migration
  def change
    create_table :ns_notes do |t|
      t.integer :ns_group_id
      t.integer :patient_id
      t.string :participate
      t.string :respond
      t.string :interact_leader
      t.string :interact_peers
      t.string :discussion_init
      t.string :discussion_understand
      t.text :comment
      t.string :updated_by
      t.date :group_date

      t.timestamps null: false
    end
    add_index(:ns_notes, :ns_group_id, name: 'nsnote-groupid')
    add_index(:ns_notes, :patient_id, name: 'nsnote-patientid')
    add_index(:ns_notes, :group_date, name: 'nsnote-groupdate')
    add_index(:ns_notes, [:ns_group_id, :group_date], name: 'nsnote-groupid-date')
    add_index(:ns_notes, [:patient_id, :ns_group_id], name: 'nsnote-patid-groupid')
  end
end
