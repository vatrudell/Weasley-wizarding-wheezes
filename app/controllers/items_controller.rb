class ItemsController < ApplicationController

  def index
    # byebug
    @items = Item.all
  end

end
