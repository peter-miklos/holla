require "rails_helper"

describe Restaurant, type: :model do

  let!(:user){ User.create(email: "Laura@troll.com", password: "123456") }
  let!(:bk){ Restaurant.create(name: "Burger King", address: "London", description: "burger", user_id: user.id) }
  let!(:kfc_l){ Restaurant.create(name: "KFC London", address: "London", description: "chicken", user_id: user.id) }
  let!(:kfc_b){ Restaurant.create(name: "KFC Bristol", address: "Bristol", description: "chicken", user_id: user.id) }


  it "does not save the restaurant with a name of less than three chars " do
    restaurant = Restaurant.new(name: "Mc")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "does not allow duplicate restaurant names" do
    Restaurant.create(name: "Dirty Bones", user_id: user.id)
    restaurant = Restaurant.new(name: "Dirty Bones", user_id: 1)
    expect(restaurant).to have(1).error_on(:name)
  end

  it "returns the restaurants containing the keyword" do
    restults = Restaurant.search("KFC")
    expect(restults).to eq [kfc_l, kfc_b]
  end

  it "returns all the restaurants if no keyword is used" do
    restults = Restaurant.search("")
    expect(restults).to eq [bk, kfc_l, kfc_b]
  end
end
