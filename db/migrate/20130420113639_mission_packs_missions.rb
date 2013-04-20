class MissionPacksMissions < ActiveRecord::Migration
  def change
    create_table :mission_packs_missions, id: false do |t|
      t.integer :mission_id
      t.integer :mission_pack_id
    end
  end
end
