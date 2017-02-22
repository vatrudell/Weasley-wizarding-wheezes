class CategoriesController < ApplicationController

  def show
    @category = Category.friendly.find(params[:name])
    @items = @category.items
  end

end
