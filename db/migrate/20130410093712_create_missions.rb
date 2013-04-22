class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.integer :mission_category_id
      t.integer :mission_pack_id

      t.string :name
      t.text :description

      t.integer :minimum_balance, default: 0

      t.boolean :repeatable, default: false
      t.boolean :institution_only, default: false
      t.boolean :deleted, default: false

      t.integer :reward
      t.integer :minimal_time
      t.integer :maximal_time

      t.timestamps
    end
  end
end
