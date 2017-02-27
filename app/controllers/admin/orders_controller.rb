class Admin::OrdersController < Admin::BaseController
  include ActionView::Helpers::TextHelper

  before_action :set_status

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def sort_orders
    if params[:order] == "all"
      @orders = Order.all
      render "admin/orders/index"
    else
      @orders = Order.get_by_status(params[:order][:status])
      render 'admin/orders/index'
    end
  end
end
