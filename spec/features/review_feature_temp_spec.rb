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
      visit("/restaurants")
      click_link("KFC")
      click_link("Add review")

      expect(page).to have_content("Sorry, you cannot review your own restaurant")
      expect(current_path).to eq("/restaurants/#{kfc.id}")
    end
  end
end
