module RatingStars

  star_full = "./app/assets/images/star_icons/1475788594_star-4.png"
  star_three_quarters = "./app/assets/images/star_icons/1475788594_star-3.png"
  star_half = "./app/assets/images/star_icons/1475788594_star-2.png"
  star_quarter = "./app/assets/images/star_icons/1475788594_star-2.png"
  star_empty = "./app/assets/images/star_icons/1475788594_star-0.png"

  def return_stars(input)

    array = []
    input = input.round(input * 4)/4

    5.times do
      if input - 1 >= 0
        array.push(star_full)
        input -= 1
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
