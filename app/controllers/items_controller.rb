class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def jumbotron
    @items = Item.all
    render layout: false
  end
end
