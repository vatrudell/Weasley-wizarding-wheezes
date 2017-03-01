class ItemsController < ApplicationController

  def index
    @items = Item.all
    @popular_items = Item.most_popular
  end

  def show
    @item = Item.find(params[:id])
    @review = Review.new
    @reviews = @item.get_reviews
  end

  def sort_reviews
    @item = Item.find(params[:id])
    @review = Review.new
    @reviews = Review.filter_reviews(params[:review][:sort_rating], @item)
    render 'items/show'
  end
end
