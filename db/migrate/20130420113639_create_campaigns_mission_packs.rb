class CreateCampaignsMissionPacks < ActiveRecord::Migration
  def change
    create_table :campaigns_mission_packs, id: false do |t|
      t.integer :campaign_id
      t.integer :mission_pack_id
    end
  end
end
