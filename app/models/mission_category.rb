class MissionCategory < ActiveRecord::Base
  has_many :missions
  has_many :active_missions, -> { where deleted: false }, class_name: "Mission"
end
