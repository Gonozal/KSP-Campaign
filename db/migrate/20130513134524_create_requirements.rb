class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.integer :mission_id
      t.integer :requirement_id

      t.timestamps
    end
  end
end
