class WelcomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    @products = Product.last(12).reverse
  end
end
