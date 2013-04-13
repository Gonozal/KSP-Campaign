class Flight < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :contract

  scope :in_progress, -> { where(status: 0) }
  scope :successful, -> { where(status: 1) }
  scope :failed, -> { where(status: 2) }

  after_save :update_contract
  after_save :handle_financials

  # Balance of this flight. Should only really be Rocket lauch costs
  def balance
    transactions.all.inject(0) do |sum, transaction|
      sum + transaction.amount
    end
  end

  private
  # Create transaction entr
  def handle_financials
    if status_changed? and status == 0 and transactions.investments.empty?
      submit_transaction(reference: :ship, amount: ship_cost)
    end
  end

  # Creates a new transaction for this contract
  # Assigns reference-string and amount based on parameters
  # Copy of same method in contract.rb -> Refactor?
  def submit_transaction(args = {})
    t = transactions.new
    t.reference = args[:reference]
    t.amount = args[:amount]
    t.campaign_id = campaign.id
    t.save
  end

  # If flight status changes, contract this flight was assigned to should be updated
  # A contract can only have one active flight at a time and is locked by a new flight
  # TODO: Is this sensible? Should multiple active flights ba allowed?
  # Once a flight failed, release contract for another try
  # Once a flight completes succesfully, assume contract was fulfilled
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
