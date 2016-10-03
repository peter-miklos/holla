require "rails_helper"

feature "restaurants" do
  context "restaurants are visible in the list of restaurants" do
    scenario "should display 2 restaurants after creating them" do
      Restaurant.create(name: "KFC", rating: 4, address: "London", description: "chicken")
      Restaurant.create(name: "Burger King", rating: 3, address: "Bristol", description: "Burger")
      visit "/restaurants"
      expect(page).to have_content("KFC")
      expect(page).to have_content("Burger King")
      expect(page).not_to have_content("No restaurants yet")
    end
  end
end
