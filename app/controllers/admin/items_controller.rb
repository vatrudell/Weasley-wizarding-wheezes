class Admin::ItemsController < Admin::BaseController
  include ActionView::Helpers::TextHelper

  def new
    @item = Item.new

  end

  def create
  end 

end
