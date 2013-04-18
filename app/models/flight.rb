class Flight < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :contract
  has_many :transactions, dependent: :destroy

  scope :in_progress, -> { where(status: :started) }
  scope :successful, -> { where(status: :successful) }
  scope :failed, -> { where(status: :failed) }

  default_scope {order("updated_at DESC")}

  after_save :handle_financials
  after_save :update_contract
  after_destroy :revert_contract_changes

  attr_accessor :result, :casualties, :debries, :extra_credits
  attr_accessible :campaign_id, :contract_id, :ship_cost, :name
  attr_accessible :status

  validate :ship_cost, presence: true

  # Balance of this flight. Should only really be Rocket lauch costs
  def balance
    transactions.inject(0) do |sum, transaction|
      sum + transaction.amount
    end
  end

  def complete(params)
    # update flight status
    case params[:result]
    when "success" then self.status = :successful
    when "failure" then self.status = :failed
    end

    # calculate penalties
    if params[:casualties].present? and params[:debries] != 0
      submit_transaction(reference: :crew_death, amount: - params[:casualties].to_i * 15000)
    end
    if params[:debries].present? and params[:debries].to_i != 0
      submit_transaction(reference: :debries, amount: - params[:debries].to_i * 10000)
    end
    if params[:extra_credits].present? and params[:extra_credits].to_i != 0
      reference = (params[:extra_credits].to_i < 0)? :gift : :deduction
      submit_transaction(reference: reference, amount: params[:extra_credits].to_i)
    end
  end

  # Some checking is needed when creating a new flight
  def defaults
    self.ship_cost ||= 0
    self.ship_cost = ship_cost.abs
    if name.blank?
      self.name = "#{contract.mission.name} ##{ contract.flights.all.count + 1 }"
    end
    self.campaign_id = contract.campaign_id
  end

  private
  # Create transaction entr
  def handle_financials
    if transactions.investments.empty?
      submit_transaction(reference: :ship, amount: - ship_cost.to_i)
    end
    true
  end

  # Creates a new transaction for this contract
  # Assigns reference-string and amount based on parameters
  # Copy of same method in contract.rb -> Refactor?
  def submit_transaction(args = {})
    return false if args[:amount] == 0
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
    case status.to_sym
    when :started then lock_contract
    when :successful then complete_contract
    when :failed then release_contract unless contract.flights.in_progress.any?
    else lock_contract
    end
    true
  end

  def revert_contract_changes
    if status.to_sym == :successful or status.to_sym == :started
      release_contract unless contract.flights.in_progress.any?
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
