class Institution < ActiveRecord::Base
  has_many :contracts

  def reputation(campaign)
    @reputation ||= initial_reputation + 
      campaign.reputations.where("institution_id = ?", [campaign.id]).inject(0, :+)
  end

  def available_missions
    MissionCategory.where("minimum_reputation <= ?", [reputation]).all.map do |c|
      c.missions.all
    end.flatten!
  end
end
