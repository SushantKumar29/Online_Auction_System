# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[edit show update destroy rank_request destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    if params[:val].present?
      @users = User.includes(:profile).where(role: params[:val])
      @role = @users.first.role unless @users.empty?
    else
      @users = User.includes(:profile).all
      @role = "user"
    end
  end

  def show
    @author = @profile.user
    @products_sold = @author.products.where(status: "sold").size
    @products_bought = Bid.where(status: "sold").where(buyer_id: @author.id).size
    render :show
  end

  def update
    @author = @profile.user
    @profile.update(image: image_params) if params[:profile][:image]
    if @profile.update(profile_params)
      redirect_to @profile, notice: "Profile Updated Successfully"
    else
      render :show
    end
  end

  def rank
    user = User.find_by_id(params[:id])
    if user.user?
      user.moderator!
    elsif user.moderator?
      user.user!
    end
    redirect_to(:back)
  end

  def rank_request
    user = User.find_by_id(params[:user_id])
    if user.update(moderator_request: true)
      respond_to do |format|
        format.html { redirect_to @profile, notice: "Your Request Sent Successfully" }
        format.js
      end
    end
  end

  def destroy; end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :location, :country, :bio, :mobile, :image)
  end

  def image_params
    params[:profile][:image]
  end

  def record_not_found
    # render partial: 'layouts/not_found', status: 404
  end

  def user_paginate
    @users = @users.paginate(page: params[:page], per_page: 20)
  end
end
