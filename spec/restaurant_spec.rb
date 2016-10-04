require "rails_helper"

describe Restaurant, type: :model do
  it "does not save the restaurant with a name of less than three chars " do
    restaurant = Restaurant.new(name: "Mc")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end
end
