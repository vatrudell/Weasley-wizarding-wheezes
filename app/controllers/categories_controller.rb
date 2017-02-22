class CategoriesController < ApplicationController

  def show
    # byebug
    @category = Category.find_by(slug: params[:name])
    @items = @category.items
  end

end
