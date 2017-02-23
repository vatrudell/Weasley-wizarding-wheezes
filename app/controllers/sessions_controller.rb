 class SessionsController < ApplicationController
   def new
   end

   def create
    user = User.find(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged In Sucessfully"
    else
      flash.now[:notice] = "Your email or password"
      redirect_to login_path
    end

    def destory
      session.clear
      flash[:notice] = "Logged Out"
      redirect_to login_path
    end
 end
