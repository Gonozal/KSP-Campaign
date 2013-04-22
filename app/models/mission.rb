class Mission < ActiveRecord::Base
  belongs_to :mission_pack
  belongs_to :mission_category
  has_many :contracts

  scope :one_offs, -> { where(repeatable: false) }
  scope :repeatables, -> { where(repeatable: true) }
  scope :active, -> { where(deleted: false) }

  default_scope { order("updated_at DESC") }

  attr_accessible :name, :description, :mission_category_id, :repeatable, :reward
  attr_accessible :minimal_time, :maximal_time, :mission_pack_id, :minimum_balance

  validates_presence_of :name, :description, :mission_category_id, :reward
  validates_presence_of :minimal_time, :maximal_time

  def self.category_selection
    MissionCategory.all.map do |c|
      [c.name, c.id]
    end
  end
end
