class Admin::ItemsController < Admin::BaseController
  include ActionView::Helpers::TextHelper

  def new
    @item = Item.new

  end

  def create
    @item = Item.new(item_params)
  end

  private
  def item_params
    
  end

end
