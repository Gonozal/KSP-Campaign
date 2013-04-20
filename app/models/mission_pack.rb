class MissionPack < ActiveRecord::Base
  belongs_to :user
  has_many :missions
  has_and_belongs_to_many :campaigns

  validate :description, presence: true
  validate :name, presence: true

  attr_accessible :name, :description, :mods, :public
end
