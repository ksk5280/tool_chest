class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user.dashboard_path # model has the logic
    else
      flash.now[:errors] = "Invalid login."
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end
end
