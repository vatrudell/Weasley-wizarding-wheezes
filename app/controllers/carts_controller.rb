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
    @range = (0..10).to_a.map{ |i| i.to_s }
  end
end
