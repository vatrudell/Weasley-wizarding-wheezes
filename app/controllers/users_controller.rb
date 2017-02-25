class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.username}"
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show
    render file: 'app/views/errors/not_found.html.erb' unless current_user
  end

  private

  def user_params
    params.require(:user).permit(:username,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :first_name,
                                 :last_name)
  end

end
