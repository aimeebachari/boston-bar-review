class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
    respond_to do |format|
      format.html
      format.json { render json: @reviews}
    end
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
    @review = Review.find(params[:id])
    @bar = @review.bar
  end

  def update
    @review = Review.find(params[:id])
    @bar = @review.bar
    if @review.update(review_params)
      redirect_to @bar
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @bar = @review.bar
    @review.destroy

    redirect_to @bar
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end

end
