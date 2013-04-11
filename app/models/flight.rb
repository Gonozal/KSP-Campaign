class Flight < ActiveRecord::Base
  belongs_to :campaign
  has_one :contract
end
