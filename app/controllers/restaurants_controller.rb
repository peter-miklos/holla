class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    # raise 'Hello from the index action'
  end

  def new
    @restaurant = Restaurant.new
    # this is going to need to be changed when user functionality is implimented
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    redirect_to '/restaurants'
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to '/restaurants'
  end

  private

  def restaurant_params
   params.require(:restaurant).permit(:name)
  end

end
