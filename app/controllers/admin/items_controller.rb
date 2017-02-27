class Admin::ItemsController < Admin::BaseController
  include ActionView::Helpers::TextHelper

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
  end

end
