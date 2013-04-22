class MissionPack < ActiveRecord::Base
  belongs_to :user
  has_many :missions
  has_many :active_missions, class_name: "Mission", conditions: "deleted = 'f'"
  has_and_belongs_to_many :campaigns

  validate :description, presence: true
  validate :name, presence: true

  scope :active, -> { where(deleted: false) }

  default_scope { order("updated_at DESC") }

  attr_accessible :name, :description, :mods, :public

  validates_presence_of :name, :description

  cattr_accessor :current_user

  # label method for forms.
  def label
    html = ""
    html << (official?? "<span class='text-success'>" : "")
    html << "#{name} (by #{user.name})"
    html << (official?? "</span>" : "")
    html.html_safe
  end
end
