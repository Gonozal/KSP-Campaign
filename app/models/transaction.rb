class Transaction < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :flight
  belongs_to :contract

  scope :advances, -> { where(reference: :advance) }
  scope :penalties, -> { where(reference: :penalty) }
  scope :investments, -> { where(reference: :ship) }
  scope :rewards, -> { where(reference: :reward) }
  scope :reimbursements, ->{ where(reference: :reimbursement) } 

  default_scope {order("created_at DESC")}

end
