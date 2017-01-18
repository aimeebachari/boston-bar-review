class BarsController < ApplicationController

  def index
    @bars = Bar.all
    @bar = Bar.new
  end

  def show
    @user = current_user
    @bar = Bar.find(params[:id])
  end

  def create
    @user = current_user
    @bar = Bar.new(bar_params)
    @bar.user = current_user
    if @bar.save
      flash[:notice] = "Bar created successfully!"
      redirect_to @bar
    else
      flash[:notice] = @bar.errors.full_messages.to_sentence
      redirect_to @bar
    end
  end

  private

  def bar_params
    params.require(:bar).permit(:name, :address, :city, :state, :zip, :url, :description)
  end

end
