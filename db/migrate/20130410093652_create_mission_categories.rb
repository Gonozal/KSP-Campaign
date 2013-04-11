class CreateMissionCategories < ActiveRecord::Migration
  def change
    create_table :mission_categories do |t|
      t.string :name
      t.integer :minimum_balance, default: 0
      t.integer :minimum_reputation, default: 0

      t.timestamps
    end
  end
end
