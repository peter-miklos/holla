require "rails_helper"

feature "reviews" do
  let!(:user1){ User.create(email: "laura@troll.com", password: "123456") }
  let!(:user2){ User.create(email: "tim@troll.com", password: "123456") }
  let!(:bk){ Restaurant.create(name: "Burger King", address: "London", description: "burger", user_id: user1.id) }
  let!(:kfc){ Restaurant.create(name: "KFC", address: "London", description: "chicken", user_id: user2.id) }

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

    scenario "user cannot review their owned restaurant" do
      visit("/restaurants/#{bk.id}/reviews/new")

      expect(page).to have_content("Sorry, you cannot review your own restaurant")
      expect(current_path).to eq("/restaurants/#{bk.id}")
    end

    scenario "user cannot see the 'Add review' link at his/her own restaurant" do
      visit("/restaurants")
      click_link("Burger King")

      expect(page).not_to have_content("Add review")
      expect(current_path).to eq("/restaurants/#{bk.id}")
    end

    context "deleting reviews" do

      let!(:review) {Review.create(rating: 3, comment: "Ok chicken",  user_id: user1.id, restaurant_id: kfc.id)}

      scenario "user can delete a review" do
        visit "/restaurants/#{kfc.id}/reviews"
        click_link "Edit review"

        expect(current_path).to eq "/restaurants/#{kfc.id}/reviews/#{review.id}/edit"

        click_link "Delete review"

        expect(current_path).to eq "/restaurants/#{kfc.id}/reviews"
        expect(page).to_not have_content "Ok chicken"
        expect(page).to have_content "Review successfully deleted!"

      end

      scenario "user cannot delete another user's review" do
        visit('/')
        click_link("Sign out")
        sign_in(email: 'tim@troll.com', password: '123456')

        visit "/restaurants/#{kfc.id}/reviews"
        click_link "Edit review"
        click_link "Delete review"
        expect(current_path).to eq "/restaurants/#{kfc.id}/reviews"
        expect(page).to have_content "Ok chicken"
        expect(page).to have_content "Sorry, you can only delete reviews you have created"

      end
    end
  end

  context "not signed in" do

    scenario "The user will be redirected to the log in page if she tries to leave a review when not signed in" do
      visit "/restaurants/#{kfc.id}"
      visit "/restaurants/#{kfc.id}/reviews/new"
      expect(current_path).to eq("/users/sign_in")
      expect(page).to have_content("Please log in to add a review.")
    end
  end

end
