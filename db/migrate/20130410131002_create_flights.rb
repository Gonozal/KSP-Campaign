class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.integer :campaign_id
      t.integer :contract_id

      t.timestamps
    end
  end
end
