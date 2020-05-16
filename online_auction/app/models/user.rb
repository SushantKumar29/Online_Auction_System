# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true, uniqueness: true, on: :create
  validates :password, presence: true, length: { minimum: 8 }, confirmation: true, on: :create

  enum role: %i[admin moderator user]

  # ratyrate_rater

  after_create :default_role, :create_profile

  private

  def default_role
    user!
  end

  def create_profile
    profile = Profile.create(user: self)
    profile.image = Image.create
  end
end
