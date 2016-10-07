
module RestaurantsHelper

  def stringify(name, address)
    (name.to_s + " " + address.to_s).split(" ").join("+")
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :rating, :address)
  end

  def return_stars(input)
    star_full = "1475788591_star-4.png"
    star_three_quarters = "1475788594_star-3.png"
    star_half = "1475788597_star-2.png"
    star_quarter = "1475788601_star-1.png"
    star_empty = "1475788594_star-0.png"

    array = []

    if input == "No ratings yet for this restaurant"
      5.times {array.push(star_empty)}
      return array
    end

    input = (input / 0.25).round * 0.25

    5.times do
      if input - 1.0 >= 0
        array.push(star_full)
        input -= 1.0
      elsif input - 0.75 >= 0 #but less than 1
        array.push(star_three_quarters)
        input -= 0.75
      elsif input - 0.50 >= 0 #but less than .75
        array.push(star_half)
        input -= 0.50
      elsif input - 0.25 >= 0 #but less than .5
        array.push(star_quarter)
        input -= 0.25
      else
        array.push(star_empty)
      end
    end
    return array
  end

end
