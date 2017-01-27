class BarsController < ApplicationController

  def index
    if params[:term]
      @bars = Bar.search(params[:term])
    else
      @bars = Bar.all
    end
    @bar = Bar.new
  end

  def show
    @user = current_user
    @bar = Bar.find(params[:id])
    @reviews = @bar.reviews

    rating = 0
    count = 0
    @bar.reviews.each do |review|
      rating += review.rating
      count += 1
    end

    @average = rating.to_f / count.to_f
  end

  def create
    @user = current_user
    @bar = Bar.new(bar_params)
    @bar.user = current_user

    if @bar.save
      flash[:notice] = "Bar created successfully!"
      redirect_to bars_path
    else
      @bars = Bar.all
      flash.now[:notice] = @bar.errors.full_messages.to_sentence
      render :index
    end
  end

  def edit
    @bar = Bar.find(params[:id])
    @user = current_user
    if @user.id == @bar.user_id || @user.admin?
      render :edit
    else
      flash[:notice] = "You don't have permission to edit this bar!"
      redirect_to @bar
    end
  end

  def update
    @bar = Bar.find(params[:id])

    if @bar.update(bar_params)
      redirect_to bar_path
    else
      flash[:notice] = @bar.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @bar = Bar.find(params[:id])
    @user = current_user

    if @user.id == @bar.user_id || @user.admin?
      Bar.destroy(params[:id])
      redirect_to bars_path
    else
      flash[:notice] = "You don't have permission to delete this bar!"
      redirect_to @bar
    end
  end

  private

  def bar_params
    params.require(:bar).permit(:name, :address, :city, :state, :zip, :url, :description, :term)
  end

end
