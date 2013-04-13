class Flight < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :contract
  has_many :transactions

  scope :in_progress, -> { where(status: 0) }
  scope :successful, -> { where(status: 1) }
  scope :failed, -> { where(status: 2) }

  default_scope {order("created_at DESC")}

  after_save :handle_financials
  after_save :update_contract

  attr_accessor :result, :casualties, :debries, :extra_credits

  # Balance of this flight. Should only really be Rocket lauch costs
  def balance
    transactions.inject(0) do |sum, transaction|
      sum + transaction.amount
    end
  end

  private
  # Create transaction entr
  def handle_financials
    if transactions.investments.empty?
      submit_transaction(reference: :ship, amount: - ship_cost)
    end
    true
  end

  # Creates a new transaction for this contract
  # Assigns reference-string and amount based on parameters
  # Copy of same method in contract.rb -> Refactor?
  def submit_transaction(args = {})
    t = transactions.new
    t.reference = args[:reference].to_s
    t.amount = args[:amount]
    t.contract_id = contract.id
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
      case status.to_sym
      when :started then lock_contract
      when :successful then complete_contract
      when :failed then release_contract
      else lock_contract
      end
    end
    true
  end

  def revert_contract_changes
    if status.to_sym == :successful or status.to_sym == :started
      release_contract
    end
  end

  def lock_contract
    contract.status = :accepted # Set status to accepted
    contract.save
    true
  end

  def release_contract
    contract.status = :open
    contract.save
    true
  end

  def complete_contract
    contract.status = :successful # Set status to complete
    contract.save
    true
  end
end
