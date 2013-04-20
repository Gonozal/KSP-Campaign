class Mission < ActiveRecord::Base
  belongs_to :mission_pack
  belongs_to :mission_category
  has_many :contracts

  scope :one_offs, -> { where(repeatable: false) }
  scope :repeatables, -> { where(repeatable: true) }

  attr_accessible :name, :description, :mission_category, :repeatable, :reward
  attr_accessible :minimal_time, :maximal_time

  validates_presence_of :name, :description, :mission_category_id, :reward
  validates_presence_of :minimal_time, :maximal_time

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

  def self.category_selection
    MissionCategory.all.map do |c|
      [c.name, c.id]
    end
  end
end
