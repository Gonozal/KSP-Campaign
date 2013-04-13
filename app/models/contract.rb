class Contract < ActiveRecord::Base
  has_many :flights, dependent: :destroy
  has_many :transactions, dependent: :destroy
  belongs_to :institution
  belongs_to :mission
  belongs_to :campaign

  scope :independent, -> {where(institution_id: nil)}
  scope :open, -> {where(status: nil)}
  scope :assigned, -> {where("status NOT NULL")}
  scope :successful, -> {where(status: 1)}

  after_save :handle_financials

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
    transactions.all.inject(0) do |sum, transaction|
      sum + transaction.amount
    end
  end

  # A contract can specify a maximum amount of expenses (rocket launches) that are covered
  # 75% percent of all expenses up to the limit specified by the contract are reimburesed
  # This includes multiple failed launch attemps
  def reimbursement
    expenses = transactions.investments.all.inject(0) do |sum, transaction|
      sum + transaction.amount * 0.75
    end
    [expenses, cost_plus_limit].sort[0] # return minimum of limit and expenses
  end

  private
  # Create transaction entries when contract changes status
  def handle_financials
    if status_changed?
      if status == 0 and transactions.advances.empty? 
        submit_transaction(reference: :advance, amount: advance)
      elsif status == 1 and transactions.rewards.empty?
        # when contract completed, grant mission reward and cost-plus reimburesement
        submit_transaction(reference: :reward, amount: payout)
        submit_transaction(reference: :reimbursement, amount: reimbursement)
        # If for some reason contract was created succesufl, also grant advance money
        if transactions.advances.empty?
          submit_transaction(reference: :advance, amount: advance)
        end
      elsif status == 2 and transactions.penalties.empty?
        submit_transaction(reference: :penalty, amount: - penalty)
      end
    end
  end

  # Creates a new transaction for this contract
  # Assigns reference-string and amount based on parameters
  # Copy of same method in flight.rb -> Refactor?
  def submit_transaction(args = {})
    t = transactions.new
    t.reference = args[:reference].to_s
    t.amount = args[:amount]
    t.campaign_id = campaign.id
    t.save
  end
end
