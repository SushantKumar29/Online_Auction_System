# frozen_string_literal: true

class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_one :bid
  has_one :image, as: :avatar, dependent: :destroy

  after_create :set_default, :create_bid

  private

  def set_default
    self.status = 'pending'
  end

  def create_bid
    self.bid = Bid.create(current_bid: price, status: 'pending', product: self)
  end
end
