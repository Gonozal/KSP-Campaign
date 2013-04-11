class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :flight_id
      t.integer :institution_id
      t.integer :mission_id
      t.integer :campaign_id

      t.integer :reward
      t.integer :advance_percent, default: 0
      t.integer :penalty

      t.integer :time_limit

      t.string :status
      t.datetime :completed_at
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
