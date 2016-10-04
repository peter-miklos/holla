require "rails_helper"

feature "reviews" do
  let!(:user){ User.create(email: "Laura@troll.com", password: "123456") }
  let!(:kfc){ Restaurant.create(name: "KFC", address: "London", description: "chicken", user_id: user.id) }

  scenario "user can add a review to a restaurant" do
    visit "/restaurants/#{kfc.id}"
    click_link "Add review"
    select("4", from: "Rating")
    fill_in("Comment", with: "Tasty chicken")
    click_button "Create Review"

    expect(current_path).to eq "/restaurants/#{kfc.id}/reviews"
    expect(page).to have_content("Tasty chicken")

  end
end
