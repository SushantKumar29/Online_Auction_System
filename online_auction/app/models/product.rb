class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_one :image, :as => :avatar, dependent: :destroy
end
