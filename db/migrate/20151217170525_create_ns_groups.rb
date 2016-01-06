class CreateNsGroups < ActiveRecord::Migration
  def change
    create_table :ns_groups do |t|
      t.string :duration
      t.string :groupname
      t.string :leader
      t.string :groupsite
      t.string :facility
      t.string :updated_by

      t.timestamps
    end
    add_index :ns_groups, :facility
    add_index(:ns_groups, [:facility, :groupname], name: 'facility-groupname')
  end
end
