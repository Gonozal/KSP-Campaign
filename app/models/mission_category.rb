class MissionCategory < ActiveRecord::Base
  has_many :missions
  has_many :active_missions, class_name: "Mission", conditions: "deleted = 'f'"
end
