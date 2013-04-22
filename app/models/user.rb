class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  has_many :campaigns, dependent: :destroy
  has_many :mission_packs
  has_many :active_mission_packs, class_name: "MissionPack", conditions: "deleted = 'f'"

  validates_presence_of :name
end
