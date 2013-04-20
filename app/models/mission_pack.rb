class MissionPack < ActiveRecord::Base
  has_many :missions
  has_and_belongs_to_many :campaigns
end
