class CreateMissionPacks < ActiveRecord::Migration
  def change
    create_table :mission_packs do |t|
      t.integer :user_id

      t.string :name
      t.string :mods, default: ""
      t.text :description, default: ""

      t.boolean :official, default: false
      t.boolean :public, default: false
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
