class Institution < ActiveRecord::Base
  has_many :contracts
  has_many :reputations

  def reputation(campaign)
    return 0 if true==true
    @reputation ||= initial_reputation + 
      campaign.reputations.where("institution_id = ?", [campaign.id]).inject(0, :+)
    [@reputation, 100, 0].sort[1]
  end

  def available_missions(campaign)
    where_string = "minimum_reputation <= ? AND minimum_balance <= ?"
    MissionCategory.where(where_string, reputation(campaign), campaign.balance).map do |c|
      c.missions.to_a
    end.flatten!
  end
end
