class ItemsController < ApplicationController

  def index
    @items = Item.all
    @popular_items = Item.most_popular
  end

  def show
    @item = Item.find(params[:id])
    @review = Review.new
  end

  def sort_reviews
    @item = Item.find(params[:id])
    @review = Review.new
    @reviews = 
  end
end
