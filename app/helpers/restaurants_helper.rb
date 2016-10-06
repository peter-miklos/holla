module RestaurantsHelper

  def stringify(name, address)
    (name.to_s + " " + address.to_s).split(" ").join("+")
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :rating, :address)
  end

end
