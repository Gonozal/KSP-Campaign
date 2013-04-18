class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :user_id
      t.string :name
      t.integer :starting_balance, default: 0
      t.string :player_name

      t.datetime :date, default: DateTime.new(0, 1, 1)

      t.timestamps
    end
  end
end
