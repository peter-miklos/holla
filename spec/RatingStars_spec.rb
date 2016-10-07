require 'rails_helper'
require_relative '../app/helpers/restaurants_helper.rb'

include RestaurantsHelper

describe RestaurantsHelper do
  star_full = "1475788591_star-4.png"
  star_three_quarters = "1475788594_star-3.png"
  star_half = "1475788597_star-2.png"
  star_quarter = "1475788601_star-1.png"
  star_empty = "1475788594_star-0.png"

  it 'returns the correct array when given 4.8' do
    input = 4.8
    expect(return_stars(input)).to eq(
      [star_full, star_full, star_full, star_full, star_three_quarters])
  end

  it 'returns the correct array when given 2.4' do
    input = 2.4
    expect(return_stars(input)).to eq(
      [star_full, star_full, star_half, star_empty, star_empty])
  end

  it 'returns the correct array when given 3.65' do
    input = 3.65
    expect(return_stars(input)).to eq(
      [star_full, star_full, star_full, star_three_quarters, star_empty])
  end

  it 'returns the correct array when given 0.1' do
    input = 0.1
    expect(return_stars(input)).to eq(
      [star_empty, star_empty, star_empty, star_empty, star_empty])
  end

  it 'returns the correct array when given 0.2' do
    input = 0.2
    expect(return_stars(input)).to eq(
      [star_quarter, star_empty, star_empty, star_empty, star_empty])
  end

  it 'returns the correct array when given 0.3' do
    input = 0.3
    expect(return_stars(input)).to eq(
      [star_quarter, star_empty, star_empty, star_empty, star_empty])
  end

  it 'returns the correct array when given 0.4' do
    input = 0.4
    expect(return_stars(input)).to eq(
      [star_half, star_empty, star_empty, star_empty, star_empty])
  end

end
