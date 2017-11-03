class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    item = Item.find(item_id_param)
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    flash[:notice] = "#{item.title} added to cart"
    redirect_to items_path
  end

  def show
  end

  def update
    @cart.set_quantity(params[:session][:item_id], params[:session][:quantity].to_i)
    flash[:notice] = "Quantity changed to #{params[:session][:quantity]}"
    redirect_to cart_path
  end

  def remove #this isn't restful
    item = Item.find(item_id_param)
    @cart.remove_item(item_id_param) #sanitize
    redirect_to cart_path(@cart)
    flash[:danger] = "Sucessfully Removed #{view_context.link_to(item.title, item_path(item))} from your cart"
  end

  private

  def item_id_param
    params.require(:item).permit(:item_id)
  end
end
