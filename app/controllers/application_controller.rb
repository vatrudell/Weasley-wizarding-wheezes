class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart
  before_action :define_categories
  helper_method :current_user,
                :current_admin?


  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def admin_login
    redirect_to admin_dashboard_path if current_admin?
  end

  def define_categories
    @categories = Category.all
  end

end
