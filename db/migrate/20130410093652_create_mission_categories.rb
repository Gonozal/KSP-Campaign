class CreateMissionCategories < ActiveRecord::Migration
  def change
    create_table :mission_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
