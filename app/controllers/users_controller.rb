class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.admin?
      @user.destroy
      redirect_to '/users'
    else
      flash[:notice] = 'You do not have permission to delete users!'
      redirect_to '/'
    end
  end
end
