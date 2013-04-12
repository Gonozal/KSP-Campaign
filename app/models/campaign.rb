class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :flights, dependent: :destroy
  has_many :contracts, dependent: :destroy
  has_many :reputations, dependent: :destroy
  default_scope {includes(:flights, :contracts, :reputations)}

  def balance
    @balance ||= starting_balance + flights.inject(0) do |result, element|
      result + element.profit
    end
  end

  private
  def create_random_contract
    available_contract_missions.each do |m|
    end
  end

  def available_contract_missions
    Institution.all.map do |i|
      i.available_missions
    end.flatten
  end

  def available_missions
    MissionCategory.where("minimum_balance <= ?", [balance]).all.map do |c|
      c.missions.all
    end.flatten
  end
end
