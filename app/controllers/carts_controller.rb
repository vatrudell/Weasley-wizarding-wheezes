class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    item = Item.find(params[:item_id])
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

  def remove
    item = Item.find(params[:item_id])
    @cart.remove_item(params[:item_id])
    redirect_to cart_path(@cart)
    title = item.title
    flash[:danger] = "Sucessfully Removed #{view_context.link_to(item.title, item_path(item))} from your cart"
  end
end
