class Api::V1::BarsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @bars = Bar.all
    render json: @bars
  end

  def show
    @bar = Bar.find(params[:id])
    @reviews = @bar.reviews
    @users = []
    @user = current_user
    @reviews.each do |review|
      @users << @user
    end
    render json: {reviews: @reviews, users: @users, currentUser: @user}
  end
end
