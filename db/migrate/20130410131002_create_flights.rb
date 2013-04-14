class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.integer :campaign_id
      t.integer :contract_id

      t.integer :ship_cost
      t.string :name
      t.string :status, default: :started

      t.timestamps
    end
  end
end
