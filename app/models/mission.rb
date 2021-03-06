class Mission < ActiveRecord::Base
  belongs_to :mission_pack
  belongs_to :mission_category
  has_many :contracts

  has_many :requirements
  has_many :required_missions, through: :requirements

  scope :one_offs, -> { where(repeatable: false) }
  scope :repeatables, -> { where(repeatable: true) }
  scope :active, -> { where(deleted: false) }

  default_scope { order("reward ASC") }

  attr_accessible :name, :description, :mission_category_id, :repeatable, :reward
  attr_accessible :minimal_time, :maximal_time, :mission_pack_id, :minimum_balance

  validates_presence_of :name, :description

  def self.category_selection
    MissionCategory.all.map do |c|
      [c.name, c.id]
    end
  end
end
