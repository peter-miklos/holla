require 'rails_helper'
require_relative '../lib/RatingStars.rb'

include RatingStars

describe RatingStars do
  star_full = "./app/assets/images/star_icons/1475788594_star-4.png"
  star_three_quarters = "./app/assets/images/star_icons/1475788594_star-3.png"
  star_half = "./app/assets/images/star_icons/1475788594_star-2.png"
  star_quarter = "./app/assets/images/star_icons/1475788594_star-2.png"
  star_empty = "./app/assets/images/star_icons/1475788594_star-0.png"



  it 'returns the correct array when given 4.8' do
    input = 4.8
    expect(return_stars(input)).to eq(
      [star_full, star_full, star_full, star_full, star_three_quarters])
  end

  it 'returns the correct array when given 2.4' do
    input = 4.8
    expect(return_stars(input)).to eq(
      [star_full, star_full, star_full, star_full, star_three_quarters])
  end

  it 'returns the correct array when given 3.6' do
    input = 3.6
    expect(return_stars(input)).to eq(
      [star_full, star_full, star_full, star_full, star_three_quarters])
  end

  it 'returns the correct array when given 0.1' do
    input = 0.1
    expect(return_stars(input)).to eq(
      [star_full, star_full, star_full, star_full, star_three_quarters])
  end

  it 'returns the correct array when given 0.2' do
    input = 0.2
    expect(return_stars(input)).to eq(
      [star_full, star_full, star_full, star_full, star_three_quarters])
  end

  it 'returns the correct array when given 0.3' do
    input = 0.3
    expect(return_stars(input)).to eq(
      [star_full, star_full, star_full, star_full, star_three_quarters])
  end

end
