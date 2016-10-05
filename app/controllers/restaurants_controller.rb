class RestaurantsController < ApplicationController

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
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if current_user.id == @restaurant.user.id
      @restaurant.update(restaurant_params)
      redirect_to "/restaurants/#{params[:id]}"
    else
      flash[:alert] = "Sorry, you can only edit restaurants you have created"
      redirect_to "/restaurants/#{params[:id]}"
    end
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

  private

  def restaurant_params
   params.require(:restaurant).permit(:name)
  end

end
