class Admin::ItemsController < Admin::BaseController
  include ActionView::Helpers::TextHelper

  def new
    @item = Item.new
    @categories = Category.all
  end

end
