class Admin::OrdersController < Admin::BaseController

  def index
    # user = User.find_by(username: params[:session][:username])
    # if user.current_admin
    # @orders = Order.all
    @orders = Order.all
    # byebug
      # byebug
    # else
    #   render:
    # end
    @status = Order.group(:status).count
    byebug
  end

  def sort_orders
    # status = params[:order][:status]
      @orders = Order.get_by_status(params[:order][:status])
      @status =Order.all.group(:status).count
      # byebug
      render 'admin/orders/index'
    # else
      # session[:orders] = nil
    # end
  end


end
