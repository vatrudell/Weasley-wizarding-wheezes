class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents

    flash[:notice] = "#{item.title} added to cart"
    redirect_to root_path
  end

  def show
    #item = Item.find_bu
  end

  def remove
    item = Item.find(params[:item_id])
    @cart.remove_item(params[:item_id])
    redirect_to cart_path(@cart)
    #link = "<a href='#{link_to(item.id}'>#{item.title}</a>"
    title = item.title
    flash[:danger] = "Sucessfully Removed #{view_context.link_to(item.title, item_path(item))} from your cart"
  end

end
