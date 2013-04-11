class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.integer :mission_category_id

      t.string :name
      t.text :description

      t.boolean :repeatable, default: false
      t.boolean :institution_only, default: false

      t.integer :reward
      t.integer :minimal_time
      t.integer :maximal_time

      t.timestamps
    end
  end
end
