class Campaign < ActiveRecord::Base
  belongs_to :user
  
  has_many :flights, dependent: :destroy
  has_many :transactions, through: :flights
  has_many :contracts, dependent: :destroy
  has_many :transactions, through: :contracts
  has_many :reputations, dependent: :destroy
  default_scope {includes(contracts: [:flights, :transactions]).includes(:reputations).includes(:flights)}

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
    missions = MissionCategory.where("minimum_balance <= ?", [balance]).all.map do |c|
      c.missions.all
    end.flatten
    completed_missions = contracts.all.map do |c|
      c.mission.repeatable?? c.mission : nil
    end.flatten
    missions
  end

  private
  # TODO: implement
  # Makes a new contract (semi-)ramdomly available to the player
  # Contract is picket out of all available contract missions
  def create_random_contract
    available_contract_missions.each do |m|
    end
  end

  # TODO: refine mission selection. Mission close to current budget?
  # TODO: regine mission selection. Mission already done multiple times?
  # Returns a list of missions available for assignment from institutions
  def available_contract_missions
    Institution.all.map do |i|
      i.available_missions
    end.flatten
  end

end
