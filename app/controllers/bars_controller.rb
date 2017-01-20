class BarsController < ApplicationController

  def index
    @bars = Bar.all
    @bar = Bar.new
  end

  def show
    @user = current_user
    @bar = Bar.find(params[:id])

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
      redirect_to @bar
    else
      @bars = Bar.all
      flash[:notice] = @bar.errors.full_messages.to_sentence
      render :index
    end
  end

  def edit
    @bar = Bar.find(params[:id])

    render :edit
  end

  def update
    @bar = Bar.find(params[:id])

    if @bar.update(bar_params)
      redirect_to bar_path
    else
      render :edit
    end
  end

  def destroy
    Bar.destroy(params[:id])
    redirect_to bars_path
  end

  private

  def bar_params
    params.require(:bar).permit(:name, :address, :city, :state, :zip, :url, :description)
  end

end
