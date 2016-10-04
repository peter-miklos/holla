require "rails_helper"

feature "reviews" do

  before { Restaurant.create name: 'KFC'}
  # let!(:kfc){ Restaurant.create(name: "KFC", address: "London", description: "chicken") }

  scenario "user can add a review to a restaurant" do
    visit "/restaurants"
    click_link "Review KFC"
    select("4", from: "Rating")
    fill_in("Comment", with: "Tasty chicken")
    click_button "Create Review"

    # expect(page).to have_content("Tasty chicken")
    expect(current_path).to eq "/restaurants"
  end
end
