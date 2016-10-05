class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to "/restaurants/#{params[:restaurant_id]}/reviews"
    else
      if @review.errors[:user]
        redirect_to "/restaurants/#{params[:restaurant_id]}/reviews", alert: "You have already reviewed this restaurant"
      else
        render "new"
      end
    end

  end

  def show
    @review = Review.find(params[:id])
  end

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reviews = Review.where(restaurant_id: params[:restaurant_id])
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end

end
