class Api::V1::ReviewsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @bar = Bar.find(params[:bar_id])
    @reviews = @bar.reviews
    render json: @reviews
  end

  def show
    @bar = Bar.find(params[:bar_id])
    @review = @bar.reviews.find(params[:id])
    render json: @review
  end

  def create
    data = JSON.parse(request.body.read)
    @review = Review.new(rating: data["rating"], body: data["body"])
    if @review.save!
      @bar = Bar.find(params[:bar_id])
      @reviews = @bar.reviews
      @reviews.order(:id)
      render json: @reviews
    else
      render json: {message: "Did not work"}, status: 404
    end
  end

  def destroy
    data = JSON.parse(request.body.read)
    review = Review.find(data["id"])
    if review.delete
      @bar = Bar.find(params[:bar_id])
      @reviews = @bar.reviews
      @reviews.order(:id)
      render json: @reviews
    end
  end

  def update
    data = JSON.parse(request.body.read)
    review = Review.find(data["id"])
    if data["type"] == "up_votes"
      review.up_votes += 1
      review.save
      @reviews = Review.order(:id)
      render json: @reviews
    elsif data["type"] == "down_votes"
      review.down_votes += 1
      review.save
      @reviews = Review.order(:id)
      render json: @reviews
    end
  end
end
