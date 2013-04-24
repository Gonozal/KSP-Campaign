class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model

  has_many :campaigns, dependent: :destroy
  has_many :mission_packs
  has_many :active_mission_packs, -> { where deleted: false }, class_name: "MissionPack"
  has_and_belongs_to_many :imported_packs, -> { where deleted: false, public: true },
    class_name: "MissionPack"

  validates_presence_of :name

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  def importable_packs
    MissionPack.where(deleted: false, public: true).to_a - mission_packs.to_a
  end
end
