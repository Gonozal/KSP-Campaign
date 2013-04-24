class CreateMissionPacksUsers < ActiveRecord::Migration
  def change
    create_table :mission_packs_users, id: false do |t|
      t.integer :user_id
      t.integer :mission_pack_id
    end
  end
end
