require "rails_helper"

feature "review" do
  let!(:user){ User.create(email: "laura@troll.com", password: "123456") }
  let!(:kfc){ Restaurant.create(name: "KFC", address: "London", description: "chicken", user_id: user.id) }

  context("Signed in") do
    before do
      visit('/')
      click_link('Sign in')
      fill_in('Email', with: 'laura@troll.com')
      fill_in('Password', with: '123456')
      click_button("Log in")
    end

    scenario "user cannot review their owned restaurant" do
      visit("/restaurants/#{kfc.id}/reviews/new")

      expect(page).to have_content("Sorry, you cannot review your own restaurant")
      expect(current_path).to eq("/restaurants/#{kfc.id}")
    end

    scenario "user cannot see the 'Add review' link at his/her own restaurant" do
      visit("/restaurants")
      click_link("KFC")

      expect(page).not_to have_content("Add review")
      expect(current_path).to eq("/restaurants/#{kfc.id}")
    end
  end


  context "deleting reviews" do

    let!(:review) {Review.create(rating: 3, comment: "Ok chicken",  user_id: user.id, restaurant_id: kfc.id)}

    scenario "user can delete a review" do
      visit('/')
      click_link('Sign in')
      fill_in('Email', with: 'laura@troll.com')
      fill_in('Password', with: '123456')
      click_button("Log in")


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
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')

      visit "/restaurants/#{kfc.id}/reviews"
      click_link "Edit review"
      click_link "Delete review"
      expect(current_path).to eq "/restaurants/#{kfc.id}/reviews"
      expect(page).to have_content "Ok chicken"
      expect(page).to have_content "Sorry, you can only delete reviews you have created"

    end

  end
end
