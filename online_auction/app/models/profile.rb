class Profile < ActiveRecord::Base
  include ProfilesHelper

  belongs_to :user
  has_one :image, :as => :avatar, dependent: :destroy

  validates_associated :image
  validates :name, persence: false, length: { in: 3..20 }, format: { with: /\A[a-zA-Z ]+\z/, message: "only allows letters" }, on: :update

end