class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(slug: params[:name])
    @items = @category.items
  end
end
