# frozen_string_literal: true

class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_one :bid, dependent: :destroy

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, 
                      default_url: "/images/:style/box.png",
                      dependent: :destroy
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  after_create :set_default, :create_bid

  private

  def set_default
    self.status = 'pending'
  end

  def create_bid
    self.bid = Bid.create(current_bid: price, status: 'pending', product: self)
  end
end
