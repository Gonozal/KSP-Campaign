class MissionPack < ActiveRecord::Base
  belongs_to :user
  has_many :missions
  has_many :active_missions, -> { where deleted: false}, class_name: "Mission"
  has_and_belongs_to_many :campaigns
  has_and_belongs_to_many :customers, class_name: "User"

  validate :description, presence: true
  validate :name, presence: true

  scope :active, -> { where(deleted: false) }
  scope :populated, joins(:missions)

  default_scope { order("updated_at DESC") }

  attr_accessible :name, :description, :mods, :public, :user_id

  validates_presence_of :name, :description

  cattr_accessor :current_user
  attr_accessor :imported

  # label method for forms.
  # Uses campaign to deduce he identity of the user
  def label(campaign)
    html = ""
    html << (official?? "<span class='text-success'>" : "")
    html << "[#{missions.count} #{(missions.count == 1)? "Mission" : "Missions"}] "
    html << ((user_id == campaign.user_id)? " <i class='icon-user'></i> " : " ")
    html << "#{name} (by #{user.name})"
    html << (official?? "</span>" : "")
    html.html_safe
  end
end
