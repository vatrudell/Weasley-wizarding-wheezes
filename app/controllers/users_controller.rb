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

  def edit
    if User.find(params[:id]).admin?
      @user = current_user
    else
      render file: 'app/views/errors/not_found.html.erb'
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:notice] = "Account Info Updated"
      redirect_to dashboard_path
    else
      render :edit
    end
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
