class Mission < ActiveRecord::Base
  belongs_to :mission_pack
  belongs_to :mission_category
  has_many :contracts

  scope :one_offs, -> { where(repeatable: false) }
  scope :repeatables, -> { where(repeatable: true) }


  def self.in_budget(budget)
    MissionCategory.where("minimum_balance <= ?", [budget, 1].sort[1]).
      includes(:missions).load.map do |c|
      c.missions.load
    end.flatten
  end

  def self.completed_one_offs(campaign)
    campaign.contracts.independent.includes(:mission).
      reload.load.inject([]) do |m, c|
      (c.mission.repeatable? or c.status.to_sym == :failed)? m : m.push(c.mission)
    end.flatten
  end
end
