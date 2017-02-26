class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find_by(params[:order_id])
  end

  def create
    order = current_user.orders.create(total_price: @cart.total)
    submit_order(order)
    session.delete(:cart)
    flash[:success] = "Mischief is coming your way, you have successfully placed your order!"
    redirect_to orders_path
  end

  def submit_order(order)
    @cart.items.each do |item, quantity|
      order.order_items.create!(item_id: item.id,
                                quantity: quantity
                               )
    end
  end
end
