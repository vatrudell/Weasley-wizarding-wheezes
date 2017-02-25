class Admin::OrdersController < Admin::BaseController

  def index
    # user = User.find_by(username: params[:session][:username])
    # if user.current_admin
    # @orders = Order.all
    session[:orders] = nil
    @orders = get_orders
    # byebug
      # byebug
    # else
    #   render:
    # end
    @status = Order.group(:status).count
  end

  def sort_orders
    # status = params[:order][:status]
      session[:orders] = Order.get_by_status(params[:order][:status])
      # byebug
      redirect_to admin_dashboard_path
    # else
      # session[:orders] = nil
    # end
  end

  def get_orders
    if session[:orders] == nil || session[:orders] == []
      Order.all
    else
      # byebug
      session[:orders]
    end
  end
end
