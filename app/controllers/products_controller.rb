# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy update_bid]
  before_action :authenticate_user!
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @bid_user = if @product.bid.buyer_id
        User.find(@product.bid.buyer_id)
      else
        current_user
      end
    @bid_user_name = get_user_name(@bid_user)
  end

  # GET /products/new
  def new
    @product = current_user.products.build
  end

  # GET /products/1/edit
  def edit; end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update_bid
    respond_to do |format|
      if valid_bid
        if @product.bid.update(product_bid_params)
          format.html { redirect_to @product, notice: "Bid Placed Successfully." }
          format.json { render :show, status: :ok, location: @product }
        else
          format.html { redirect_to @product }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to @product, notice: { type: "error", message: "Bid Price Must Be Higher Than Previous Bid Price." } }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:category_id, :name, :price, :image, :description, :last_bidding_date)
  end

  def product_bid_params
    user_name = get_user_name(current_user)
    params.require(:bid).permit(:current_bid).merge!({ buyer_id: current_user.id, buyer_name: user_name })
  end

  def get_user_name(user)
    user.profile.name || user.email.split("@").first
  end

  def valid_bid
    @product.bid.current_bid.to_f < params[:bid][:current_bid].to_f
  end
end
