require "rails_helper"

describe Restaurant, type: :model do
  it "does not save the restaurant with a name of less than three chars " do
    restaurant = Restaurant.new(name: "Mc")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "does not allow duplicate restaurant names" do
    Restaurant.create(name: "Dirty Bones", user_id: 1)
    restaurant = Restaurant.new(name: "Dirty Bones", user_id: 1)
    expect(restaurant).to have(1).error_on(:name)
  end
end
