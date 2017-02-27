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

  def show
    @item = Item.find(params[:id])
  end
end
