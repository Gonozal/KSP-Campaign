class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.integer :campaign_id
      t.integer :contract_id

      t.string :name
      t.integer :status
      t.integer :ship_cost

      t.integer :profit

      t.timestamps
    end
  end
end
