class RestaurantsController < ApplicationController
  include RestaurantsHelper

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user

    if @restaurant.save
      redirect_to '/restaurants'
    else
      render "new"
    end

  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @query_string = stringify(@restaurant.name, @restaurant.address)
    @stars_array = return_stars(@restaurant.average_rating)
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    if current_user.id != @restaurant.user.id
      flash[:alert] = "Sorry, you can only edit restaurants you have created"
      redirect_to "/restaurants/#{params[:id]}"
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to "/restaurants/#{params[:id]}"
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if current_user.id == @restaurant.user.id
      @restaurant.destroy
      redirect_to "/restaurants"
      flash[:notice] = "Restaurant deleted!"
    else
      redirect_to "/restaurants"
      flash[:alert] = "Sorry, you can only delete restaurants you have created"
    end
  end

end
