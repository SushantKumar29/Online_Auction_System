class Profile < ActiveRecord::Base
  include ProfilesHelper

  belongs_to :user
  
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, 
                      default_url: "/images/:style/avatar.jpg",
                      dependent: :destroy

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :name, persence: false, length: { in: 3..20 }, format: { with: /\A[a-zA-Z ]+\z/, message: "only allows letters" }, on: :update

end