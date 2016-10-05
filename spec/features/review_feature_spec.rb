require "rails_helper"

feature "reviews" do
  let!(:user){ User.create(email: "laura@troll.com", password: "123456") }
  let!(:kfc){ Restaurant.create(name: "KFC", address: "London", description: "chicken", user_id: user.id) }

  before do
    visit('/')
    click_link('Sign in')
    fill_in('Email', with: 'laura@troll.com')
    fill_in('Password', with: '123456')
    click_button("Log in")
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

  scenario "users can see who review belongs to" do
    visit "/restaurants/#{kfc.id}"
    click_link "Add review"
    select("4", from: "Rating")
    fill_in("Comment", with: "Tasty chicken")
    click_button "Create Review"
    expect(page).to have_content("laura@troll.com")
  end

  scenario "A user can not add more than one review for any restaurant" do
    visit "/restaurants/#{kfc.id}"
    click_link "Add review"
    select("4", from: "Rating")
    fill_in("Comment", with: "Tasty chicken")
    click_button "Create Review"
    expect(page).to have_content("laura@troll.com")

    visit "/restaurants/#{kfc.id}"
    click_link "Add review"
    select("5", from: "Rating")
    fill_in("Comment", with: "Really tasty chicken")
    click_button "Create Review"
    expect(current_path).to eq "/restaurants/#{kfc.id}/reviews"
    expect(page).to_not have_content("Really tasty chicken")
    expect(page).to have_content("You have already reviewed this restaurant")
  end


end
