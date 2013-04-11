class Contract < ActiveRecord::Base
  belongs_to :flight
  belongs_to :institution
  belongs_to :mission
  belongs_to :campaign

  scope :independent, -> {where(institution_id: nil)}
  scope :accepted, -> {where("flight NOT NULL")}
  scope :open, -> {where(flight_id: nil)}
  scope :successful, -> {where(status: 1)}
  scope :failed, -> {where(status: 2)}

  def accept_limit
    started_at - 15.days
  end

  def payout
    reward - reward * advance_percent / 100
  end

  def advance
    reward * advance_percent / 100
  end
end
