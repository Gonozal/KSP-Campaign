class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :institution_id
      t.integer :mission_id
      t.integer :campaign_id

      t.integer :reward
      t.integer :advance_percent, default: 0
      t.integer :penalty

      t.integer :time_limit

      t.integer :advance_payed_id
      t.itneger :penalty_taken_id
      t.integer :status # nil: open 0: accepted, 1: successful, 2: failed

      # started-at: Ingame time when the contract was created
      t.datetime :issued_at
      t.datetime :completed_at
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
