class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    order = current_user.orders.create(total_price: @cart.total)
    order.submit_order(@cart)
    session.delete(:cart)
    flash[:success] = "Mischief is coming your way, you have successfully placed your order!"
    redirect_to orders_path
  end
end
