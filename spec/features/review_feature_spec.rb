require "rails_helper"

feature "reviews" do

  let!(:kfc){ Restaurant.create(name: "KFC", address: "London", description: "chicken") }

  scenario "user can add a review to a restaurant" do
    visit "/restaurants/#{kfc.id}"
    click_link "Add review"
    select("4", from: "Rating")
    fill_in("Comment", with: "Tasty chicken")
    click_button "Create Review"

    expect(page).to have_content("Tasty chicken")
    expect(current_path).to eq "/restaurants/#{kfc.id}/reviews"
  end
end
