class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :institution_id
      t.integer :mission_id
      t.integer :campaign_id

      t.integer :reward, default: 10000
      t.integer :advance_percent, default: 0
      t.integer :cost_plus_limit, default: -1
      t.integer :penalty

      t.integer :time_limit

      t.string :status, default: :open

      # started-at: Ingame time when the contract was created
      t.datetime :issued_at
      t.datetime :completed_at
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
