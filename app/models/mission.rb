class Mission < ActiveRecord::Base
  belongs_to :mission_category
  has_many :contracts

  scope :one_offs, -> { where(repeatable: false) }
  scope :repeatables, -> { where(repeatable: true) }
end
