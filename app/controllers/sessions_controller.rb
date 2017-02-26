 class SessionsController < ApplicationController
   before_action :admin_login, only: [:create]

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in as #{user.username}"
      redirect_to dashboard_path
    else
      flash.now[:notice] = "Your username or password is incorrect"
      render :new
    end
  end

  def destroy
    session.clear
    flash[:notice] = "Logged Out"
    redirect_to login_path
  end
end
