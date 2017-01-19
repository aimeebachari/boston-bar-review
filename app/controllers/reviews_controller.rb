class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  def new
    @bar = Bar.find(params[:bar_id])
    @review = Review.new
  end

  def create
    @user = current_user
    @bar = Bar.find(params[:bar_id])
    @review = Review.new(review_params)
    @review.bar = @bar
    @review.user = @user
    if @review.save
      flash[:notice] = "Review created successfully!"
      redirect_to @bar
    else
      flash[:notice] = @review.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    binding.pry
    @bar = Bar.find(params[:bar_id])
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to bar_path
    else
      render :edit
    end
  end

  def destroy
    @review.destroy

    redirect_to bar_path
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end

end
