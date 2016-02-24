class UsersController < ApplicationController
  def index
  end

  def new

  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash.now[:error] = user.errors.full_messages.join(', ')
      render :new
    end
  end

  def show

  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
