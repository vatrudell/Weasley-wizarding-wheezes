class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(slug: params[:name])
    @items = @category.items.paginate(:page => params[:page], :per_page => 30)
  end
end
