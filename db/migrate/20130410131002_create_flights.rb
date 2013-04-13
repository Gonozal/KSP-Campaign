class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.integer :campaign_id
      t.integer :contract_id

      t.integer :ship_cost
      t.string :name
      t.integer :status, default: 0 # 1: succesful, 2: failed

      t.timestamps
    end
  end
end
