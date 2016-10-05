require "rails_helper"

feature "reviews" do
  let!(:user){ User.create(email: "laura@troll.com", password: "123456") }
  let!(:kfc){ Restaurant.create(name: "KFC", address: "London", description: "chicken", user_id: user.id) }

  context("Signed in") do

    before do
      sign_in(email: 'laura@troll.com', password: '123456')
    end

    scenario "user can add a review to a restaurant" do
      visit "/restaurants/#{kfc.id}"
      click_link "Add review"
      add_rating(number: "4", comment: "Tasty chicken")

      expect(current_path).to eq "/restaurants/#{kfc.id}/reviews"
      expect(page).to have_content("Tasty chicken")
    end

    scenario "users can see who review belongs to" do
      visit "/restaurants/#{kfc.id}"
      click_link "Add review"
      add_rating(number: "4", comment: "Tasty chicken")
      expect(page).to have_content("laura@troll.com")
    end

    scenario "A user can not add more than one review for any restaurant" do
      visit "/restaurants/#{kfc.id}"
      click_link "Add review"
      add_rating(number: "4", comment: "Tasty chicken")
      expect(page).to have_content("laura@troll.com")

      visit "/restaurants/#{kfc.id}"
      click_link "Add review"
      add_rating(number: "5", comment: "Really tasty chicken")
      expect(current_path).to eq "/restaurants/#{kfc.id}/reviews"
      expect(page).to_not have_content("Really tasty chicken")
      expect(page).to have_content("You have already reviewed this restaurant")
    end
  end

  context "not signed in" do

    scenario "The user will be redirected to the log in page if she tries to leave a review when not signed in" do
      visit "/restaurants/#{kfc.id}"
      click_link "Add review"
      expect(current_path).to eq("/users/sign_in")
      expect(page).to have_content("Please log in to add a review.")
    end
  end

end
