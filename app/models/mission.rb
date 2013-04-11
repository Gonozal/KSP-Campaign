class Mission < ActiveRecord::Base
  belongs_to :mission_category
  has_many :contracts
end
