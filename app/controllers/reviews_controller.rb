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
      UserMailer.review_email(@bar.user,@bar).deliver_now
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
    @user = current_user

    if @user.id == @review.user_id || @user.admin?
      render :edit
    else
      flash[:notice] = "You don't have permission to edit this review!"
      redirect_to @bar
    end
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
    @user = current_user

    if @user.id == @review.user_id || @user.admin?
      @review.destroy
      redirect_to @bar
    else
      flash[:notice] = "You don't have permission to delete this review!"
      redirect_to @bar
    end
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end

end
