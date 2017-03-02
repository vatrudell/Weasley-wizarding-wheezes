class ReviewsController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
    @review = @item.reviews.new(review_params)
    if @review.save
      @review.update_attributes(author: current_user.username)
      flash[:notice] = "You have submitted a review"
      redirect_to item_path(@item)
    else
      flash[:notice] = "You've entered the form incorrectly"
      render '/items/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
