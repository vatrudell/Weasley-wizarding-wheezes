class Admin::OrdersController < Admin::BaseController
  include ActionView::Helpers::TextHelper

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(order_id_param)
  end

  def sort_orders
    if params[:order][:status] == "all"
      @orders = Order.all
      render "admin/orders/index"
    else
      @orders = Order.get_by_status(params[:order][:status]) #santize?
      render 'admin/orders/index'
    end
  end

  def update
    order = Order.find(order_id_param)
    if order.update_attribute(:status, params[:status]) #sanitize?
      flash[:notice] = "Updated order status"
      redirect_to admin_dashboard_path
    else
      flash[:notice] = "Something didn't happen"
      redirect_to admin_dashboard_path
    end
  end

  private

  def order_id_param
    params.require(:order).permit(:id)
  end
end
