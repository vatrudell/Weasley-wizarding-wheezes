class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper
  def create
    item = Item.find(params[:item_id])
    @cart = Cart.new(session[:cart])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents

    flash[:notice] = "#{item.title} added to cart"
    redirect_to root_path
  end

  def show
    # byebug
    @cart = Cart.new(session[:cart])
  end
end
