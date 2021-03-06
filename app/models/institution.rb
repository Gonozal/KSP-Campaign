class Institution < ActiveRecord::Base
  has_many :contracts
  has_many :reputations

  attr_accessor :campaign, :advance, :time, :penalty, :reward

  def reputation
    raise Exceptions::CampaignNotSetError unless campaign.present?
    @reputation ||= initial_reputation + 
    accumulated = reputations.where("campaign_id = ?", [campaign.id]).inject(0) do |s, r|
      s + r.change
    end
    [@reputation + accumulated.to_i, 100, 0].sort[1]
  end

  def available_missions
    raise Exceptions::CampaignNotSetError unless campaign.present?
    campaign.budget_missions
  end

  # returns a value between 0 and 0.55. Ranges between 30 and 55 for 100 reputation
  # Ranges between 0 and 0.05 for 0 reputation
  def advance_mod
    self.advance ||= ((1.5 * rand + 3.to_f) *
      (reputation.to_f + rand(20)) / 1000).round(3)
  end

  def penalty_mod
    self.penalty ||= (read_attribute(:penalty_modifier) * (rand + 2) *
      (100 + rand(20) - reputation) / 1000).round(2) + advance_mod
  end

  def time_mod
    self.time ||= (read_attribute(:time_modifier) * (reputation + rand(20)) /
      (90 + rand(20))).round(2)
  end

  def reward_mod
    self.reward ||= (read_attribute(:reward_modifier) * (90 + reputation + rand(20)) / 
      (90 + rand(20))).round(2)
  end
end
