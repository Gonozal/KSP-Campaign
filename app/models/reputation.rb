class Reputation < ActiveRecord::Base
  belongs_to :institution
  belongs_to :contract
  belongs_to :campaign

end
