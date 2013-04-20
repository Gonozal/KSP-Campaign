class Contract < ActiveRecord::Base
  has_many :flights, dependent: :destroy
  has_many :transactions, dependent: :destroy
  belongs_to :institution
  belongs_to :mission
  belongs_to :campaign

  scope :offered, -> {where(status: :offered)}
  scope :open, -> {where(status: :open)}
  scope :assigned, -> {where("status NOT NULL AND status <> 'open'")}
  scope :successful, -> {where(status: :successful)}
  scope :accepted, -> {where("status <> 'offered'")}
  scope :independent, -> {where(institution_id: nil)}

  default_scope {order("updated_at DESC")}

  after_save :handle_financials

  attr_accessible :institution_id, :mission_id, :campaign_id

  validate :mission_id, presence: true

  # Timee in days that this contract can exist without being accepted
  def accept_limit
    issued_at + 15.days - campaign.date
  end

  # Part of the reward that is awarded on successful completion of contract
  def payout
    reward - advance
  end

  # DB only stores advance percent, calculate actual Kerbs being payed in advance
  def advance
    reward * advance_percent / 100
  end

  # Remaining time to complete this contract (after being accepted)
  def time_left
    if accepted_at.present? and status == 0
      (accepted_at + time_limit.days.to_i - campaign.date).to_i
    end
  end

  # Balance of this contract. Also includes transactions created by owned flights
  def balance
    transactions.load.inject(0) do |sum, transaction|
      sum + transaction.amount
    end
  end

  def new_independant
    self.penalty = 0
    self.reward = mission.reward
    self.time_limit = mission.maximal_time
    self.issued_at = campaign.date
    self.accepted_at = campaign.date
  end

  # A contract can specify a maximum amount of expenses (rocket launches) that are covered
  # 75% percent of all expenses up to the limit specified by the contract are reimburesed
  # This includes multiple failed launch attemps
  def reimbursement
    expenses = transactions.investments.load.inject(0) do |sum, transaction|
      sum + transaction.amount * - 0.75
    end
    return expenses if cost_plus_limit == - 1
    [expenses, cost_plus_limit].sort[0] # return minimum of limit and expenses
  end

  private
  # Create transaction entries when contract changes status
  def handle_financials
    s = status.to_sym
    if s == :accepted and transactions.advances.empty? 
      submit_transaction(reference: :advance, amount: advance)
    elsif s == :successful and transactions.rewards.empty?
      handle_success
    elsif s == :failed and transactions.penalties.empty?
      handle_failed
    elsif s == :open
      handle_opened
    end
  end

  def handle_success
    # when contract completed, grant mission reward and cost-plus reimburesement
    submit_transaction(reference: :reward, amount: payout)
    submit_transaction(reference: :reimbursement, amount: reimbursement)
    add_reputation(reputation_gain)
    # If for some reason contract was created succesufl, also grant advance money
    if transactions.advances.empty?
      submit_transaction(reference: :advance, amount: advance)
    end
  end

  def handle_failed
    submit_transaction(reference: :penalty, amount: - penalty)
    add_reputation(- 0.8 * reputation_gain)
  end

  def handle_opened
    if transactions.advances.empty? 
      submit_transaction(reference: :advance, amount: advance)
    end
    # if contract status changed to "open", remove any previous rewards and penalties
    transactions.penalties.destroy_all
    transactions.rewards.destroy_all
    transactions.reimbursements.destroy_all
    if institution.present?
      Reputation.where(campaign_id: id, institution_id: institution.id).destroy_all
    end
  end

  # Creates a new transaction for this contract
  # Assigns reference-string and amount based on parameters
  # Copy of same method in flight.rb -> Refactor?
  def submit_transaction(args = {})
    return false if args[:amount] == 0
    t = transactions.new
    t.reference = args[:reference].to_s
    t.amount = args[:amount]
    t.campaign_id = campaign.id
    t.save
  end

  def reputation_gain
    0.1 * reward.to_f / Mission.order("reward DESC").first.reward
  end

  def add_reputation(amount)
    return false if institution.blank?
    r = institution.reputations.new
    r.contract_id = id
    r.change = amount
    r.campaign_id = campaign.id
    r.save
  end
end
