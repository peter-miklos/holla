require "rails_helper"

feature "Search" do

  let!(:user1){ User.create(email: "laura@troll.com", password: "123456") }
  let!(:user2){ User.create(email: "tim@troll.com", password: "123456") }
  let!(:bk){ Restaurant.create(name: "Burger King", address: "London", description: "burger", user_id: user1.id) }
  let!(:kfc_l){ Restaurant.create(name: "KFC London", address: "London", description: "chicken", user_id: user2.id) }
  let!(:kfc_b){ Restaurant.create(name: "KFC Bristol", address: "Bristol", description: "chicken", user_id: user2.id) }

  context("Start page") do

    scenario "search and find restaurants" do
      visit "/"
      fill_in('keyword', with: "KfC")
      click_button "Search"

      expect(current_path).to eq "/restaurants"
      expect(page).to have_content "KFC London"
      expect(page).to have_content "KFC Bristol"
      expect(page).not_to have_content "Burger King"
    end

    scenario "search and no restaurant found" do
      visit "/"
      fill_in('keyword', with: "Pizza Express")
      click_button "Search"

      expect(current_path).to eq "/restaurants"
      expect(page).to have_content "No restaurant found"
      expect(page).not_to have_content "Burger King"
      expect(page).not_to have_content "KFC"
    end

    scenario "search w/o keyword and list of all restaurants will be shown" do
      visit "/"
      click_button "Search"

      expect(current_path).to eq "/restaurants"
      expect(page).to have_content "KFC London"
      expect(page).to have_content "KFC Bristol"
      expect(page).to have_content "Burger King"
    end

  end


end
