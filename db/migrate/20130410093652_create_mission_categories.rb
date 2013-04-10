class CreateMissionCategories < ActiveRecord::Migration
  def change
    create_table :mission_categories do |t|

      t.timestamps
    end
  end
end
