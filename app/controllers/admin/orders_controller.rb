class Admin::OrdersController < Admin::BaseController

  def index
    @orders = Order.all
    @status = Order.group(:status).count
  end

  def sort_orders
    @orders = Order.get_by_status(params[:order][:status])
    @status =Order.all.group(:status).count
    render 'admin/orders/index'
  end
end
