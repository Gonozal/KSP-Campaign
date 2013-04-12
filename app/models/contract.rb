class Contract < ActiveRecord::Base
  has_many :flights, dependent: :destroy
  belongs_to :institution
  belongs_to :mission
  belongs_to :campaign

  scope :independent, -> {where(institution_id: nil)}
  scope :open, -> {where(status: nil)}
  scope :not_open, -> {where("status NOT NULL")}
  scope :accepted, -> {where(status: 0)}
  scope :successful, -> {where(status: 1)}
  scope :failed, -> {where(status: 2)}

  after_save :deduct_penalty

  def accept_limit
    issued_at + 15.days - campaign.date
  end

  def payout
    reward - reward * advance_percent / 100
  end

  def advance
    reward * advance_percent / 100
  end

  def time_left
    if accepted_at.present? and status == 0
      (accepted_at + time_limit.days.to_i - campaign.date).to_i
    end
  end

  def status_s
    case status
    when nil then "Open"
    when 0 then "Accepted"
    when 1 then "Successful"
    when 2 then "Failed"
    else "unknown"
    end
  end

  private
  def deduct_penalty
    if status_changed?
      if status == 2 # status changed to failed -> deduct penalty
        if flights.failed.any?
          flight = flights.failed.last
          flights.failed.last.update_column(:profit, flight.profit - penalty)
        end
      end
    end
  end
end
