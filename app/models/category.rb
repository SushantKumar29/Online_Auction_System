# frozen_string_literal: true

class Category < ActiveRecord::Base
  has_many :products, dependent: :destroy

  def get_color_class
    colours[name.parameterize.underscore.to_sym]
  end

  private

  def colours
    {
      cars: 'fa fa-car',
      house: 'fa fa-home',
      industry: 'fa fa-industry',
      motorcycle: 'fa fa-motorcycle',
      real_estate: 'fa fa-home'
    }
  end
end
