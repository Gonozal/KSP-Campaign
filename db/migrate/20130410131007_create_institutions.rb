class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name
      t.text :description
      t.float :time_modifier, default: 0
      t.float :penalty_modifier, default: 0
      t.float :reward_modifier, default: 0
      t.integer :initial_reputation

      t.timestamps
    end
  end
end
