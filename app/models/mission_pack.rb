class MissionPack < ActiveRecord::Base
  belongs_to :user
  has_many :missions
  has_and_belongs_to_many :campaigns

  validate :description, presence: true
  validate :name, presence: true

  scope :with_deleted, -> { unscoped.order("updated_at DESC") }
  default_scope { where(deleted: false).order("updated_at DESC") }

  attr_accessible :name, :description, :mods, :public

  validates_presence_of :name, :description

end
