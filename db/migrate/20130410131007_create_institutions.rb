class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name
      t.text :description
      # modifiers are float-values that get multiplied on penalty. time etc.
      t.float :time_modifier, default: 1.0
      t.float :penalty_modifier, default: 1.0
      t.float :reward_modifier, default: 1.0
      t.integer :initial_reputation, default: 0

      t.timestamps
    end
  end
end
