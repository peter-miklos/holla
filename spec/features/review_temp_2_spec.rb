require 'rails_helper'

feature 'reviews' do

  context "updating reviews" do

    let!(:user){ User.create(email: "laura@troll.com", password: "123456") }
    let!(:user_two){ User.create(email: "james@troll.com", password: "123456") }
    let!(:kfc){ Restaurant.create(name: "KFC", address: "London", description: "chicken", user_id: user.id) }
    let!(:review) {Review.create(rating: 3, comment: "Ok chicken",  user_id: user_two.id, restaurant_id: kfc.id)}

    scenario "user cannot see edit review button for other users review" do
      sign_in(email: "laura@troll.com", password: "123456")
      visit("/restaurants/#{kfc.id}/reviews/")
      expect(page).to_not have_content("Edit review")

      visit "/restaurants/#{kfc.id}/reviews/#{review.id}/edit"

      expect(current_path).to eq "/restaurants/#{kfc.id}/reviews"
      expect(page).to have_content "Sorry, you can only edit reviews you have created"
    end

    scenario 'a user can edit their own review' do
      sign_in(email: "james@troll.com", password: "123456")
      visit("/restaurants/#{kfc.id}/reviews/")
      click_link("Edit review")
      fill_in("Comment", with: "awesome")
      select(5, from: "Rating")
      click_button("Update Review")
      expect(current_path).to eq("/restaurants/#{kfc.id}/reviews")
      expect(page).to_not have_content("Ok chicken")
      expect(page).to have_content("awesome")
    end
  end
end
