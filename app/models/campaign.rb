class Campaign < ActiveRecord::Base
  belongs_to :user
  
  has_many :flights, dependent: :destroy
  has_many :transactions, through: :flights
  has_many :contracts, dependent: :destroy
  has_many :transactions, through: :contracts
  has_many :reputations, dependent: :destroy
  default_scope {includes(contracts: [:flights, :transactions]).
                 includes(:reputations).includes(:flights).
                 order("updated_at DESC")}

  validate :name, presence: true
  validate :starting_balance, presence: true

  attr_accessible :starting_balance, :name

  # Balance of this Campaign. Funds availble to the player
  def balance
    @balance ||= starting_balance + transactions.inject(0) do |result, element|
      result + element.amount
    end
  end

  def new_missions_collection
    available_missions.map do |m|
      [m.name, m.id]
    end
  end

  # Returns an array of missions that can be attempted by the player
  # TODO: Update query to exclde one-off missions that are already completed. Scopes?
  # TODO: Make sure i.available_missions does not use this!
  def available_missions
    missions = MissionCategory.where("minimum_balance <= ?", [balance, 1].sort[1]).
      includes(:missions).load.map do |c|
      c.missions.load
    end.flatten
    completed_missions = contracts.independent.includes(:mission).
      reload.load.inject([]) do |m, c|
      (c.mission.repeatable? or c.status.to_sym == :failed)? m : m.push(c.mission)
    end.flatten
    missions - completed_missions
  end

  # TODO: implement
  # Makes a new contract (semi-)ramdomly available to the player
  # Contract is picket out of all available contract missions
  def create_random_contract
    return nil if contracts.offered.count > 3
    create_third_party_mission available_contract_missions.sample
  end

  # TODO: refine mission selection. Mission close to current budget?
  # TODO: refine mission selection. Mission already done multiple times?
  # Returns a list of missions available for assignment from institutions
  def available_contract_missions
    Institution.all.map do |i|
      i.campaign = self
      i.available_missions.map do |m|
        { institution: i, mission: m }
      end
    end.flatten
  end

  private
  def create_third_party_mission(mission_hash)
    i = mission_hash[:institution]
    i.campaign = self
    m = mission_hash[:mission]
    c = m.contracts.new
    # some defaults, inherited properties
    c.status = :offered
    c.campaign_id = id
    c.institution_id = i.id
    # Rewards, penalties etc. dependant on reputation to faction
    c.reward = (m.reward * i.reward_mod).round(-1)
    c.advance_percent = ((i.advance_mod).round(2) * 100).to_i
    c.penalty = (c.reward * i.penalty_mod).round(-1)
    time_span = (m.maximal_time - m.minimal_time)
    c.time_limit = m.minimal_time + (time_span * i.time_mod).round
    c.save

    c
  end
end
