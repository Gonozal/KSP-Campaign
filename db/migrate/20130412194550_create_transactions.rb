class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :campaign_id
      t.integer :flight_id
      t.integer :contract_id
      t.integer :amount
      t.integer :reference

      t.timestamps
    end
  end
end
