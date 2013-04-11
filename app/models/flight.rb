class Flight < ActiveRecord::Base
  belongs_to :campaign
  has_one :contract

  scope :in_progress, -> {where(status: 0)}
  scope :successful, -> {where(status: 1)}
  scope :failed, -> {where(status: 2)}

  def complete_time_left
    started_at - contract.time_limit.days
  end
end
