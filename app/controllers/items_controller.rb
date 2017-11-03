class ItemsController < ApplicationController

  def index
    @items = Item.all
    @popular_items = Item.most_popular 
  end

  def show
    @item = Item.find(item_id_param)
    @review = Review.new
    @reviews = @item.get_reviews
  end

  def sort_reviews
    @item = Item.find(item_id_param)
    @review = Review.new
    @reviews = Review.filter_reviews(params[:review][:sort_rating], @item) #sanitize?
    render 'items/show'
  end

  def jumbotron
    @items = Item.all
  end

  private

  def item_id_param
    params.require(:item).permit(:id)
  end
end
