class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :user_id
      t.string :name
      t.integer :starting_balance
      t.string :player_name

      t.timestamps
    end
  end
end
