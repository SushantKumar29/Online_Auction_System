# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true, uniqueness: true, on: :create
  validates :email, presence: true, uniqueness: true, on: :update
  validates :password, presence: true, length: { in: 6..20 }, confirmation: true, on: :create
  validates :password, presence: true, length: { in: 6..20 }, confirmation: false, on: :update, if: :password_changed?

  enum role: %i[admin moderator user]
  has_one :profile, dependent: :destroy
  has_many :products
  # ratyrate_rater

  after_create :default_role, :create_profile

  def password_changed?
    !password.blank?
  end

  private

  def default_role
    user!
  end

  def create_profile
    self.profile = Profile.create(user: self)
    profile.image = Image.create
  end
end
