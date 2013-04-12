class Flight < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :contract

  scope :in_progress, -> {where(status: 0)}
  scope :successful, -> {where(status: 1)}
  scope :failed, -> {where(status: 2)}

  before_save :calculate_flight_data
  after_save :update_contract

  def status_s
    case status
    when 0 then "In Progress"
    when 1 then "Successful"
    when 2 then "Failed"
    else "unknown"
    end
  end

  # fraction of ship cost reimbursed on mission success
  def ship_roi
    @ship_roi ||= ship_cost / 2
  end

  private
  def set_payout
    self.payout = contract.reward - contract.advance
  end

  def set_profit
    if contract.advance_payed_id == id and contract.advance_payed_id.present?
      if status == 1
        self.profit = payout - ship_cost + ship_roi
      elsif status == 2 or status == 0
        self.profit = - ship_cost
      end
    else
      if status == 1
        self.profit = payout - ship_cost + contract.advance + ship_roi
        contract.advance_payed_id = id
        contract.save
      elsif status == 2 or status == 0
        self.profit = - ship_cost + contract.advance
        contract.advance_payed_id = true
        contract.save
      end
    end
  end

  def calculate_flight_data
    set_payout
    set_profit
  end

  def update_contract
    if status_changed?
      case status
      when 0 then lock_contract
      when 1 then complete_contract
      when 2 then release_contract
      else lock_contract
      end
    end
  end

  def lock_contract
    contract.status = 0 # Set status to accepted
    contract.save
  end

  def release_contract
    contract.status = nil
    contract.save
  end

  def complete_contract
    contract.status = 1 # Set status to complete
    contract.save
  end
end
