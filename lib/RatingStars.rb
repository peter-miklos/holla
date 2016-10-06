class RatingStars

  def return_stars(input)
    star_full = "./app/assets/images/star_icons/1475788594_star-4.png"
    star_three_quarters = "./app/assets/images/star_icons/1475788594_star-3.png"
    star_half = "./app/assets/images/star_icons/1475788594_star-2.png"
    star_quarter = "./app/assets/images/star_icons/1475788594_star-2.png"
    star_empty = "./app/assets/images/star_icons/1475788594_star-0.png"

    input = input.round(input * 4)/4
    case
    when input < 0.25
      return [star_quarter, star_empty, star_empty, star_empty, star_empty]
    when input < 0.5
      return [star_half, star_empty, star_empty, star_empty, star_empty]
  end

end
