require "rails_helper"

feature "reviews" do
  let!(:user){ User.create(email: "Laura@troll.com", password: "123456") }
  let!(:kfc){ Restaurant.create(name: "KFC", address: "London", description: "chicken", user_id: user.id) }

  before do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

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
