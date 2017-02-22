class CategoriesController < ApplicationController

  def show
    byebug
    @categories = Category.where_by_param(params[:name])
    @items = @category.items
  end

end
