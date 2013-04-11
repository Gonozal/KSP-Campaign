class Contract < ActiveRecord::Base
  belongs_to :flight
  belongs_to :institution
  belongs_to :mission
end
