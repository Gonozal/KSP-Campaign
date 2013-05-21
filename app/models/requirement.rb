class Requirement < ActiveRecord::Base
  belongs_to :mission
  belongs_to :required_mission, class_name: :mission
end
