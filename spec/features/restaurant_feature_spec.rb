require 'rails_helper'

feature 'restaurants' do

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

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit "/restaurants"
      click_link "Sign out"
      click_link "Sign in"
      fill_in('Email', with: 'Laura@troll.com')
      fill_in('Password', with: '123456')
      click_button('Log in')
      visit "/restaurants"
      click_link("KFC")
      click_link("Edit KFC")
      click_link("Delete listing")
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurant has been added' do
    scenario '' do
      Restaurant.create(name: "Burger King", user_id: user.id)
      visit '/restaurants'
      expect(page).to have_content("Burger King")
      expect(page).not_to have_content("No restaurants yet")
    end
  end

  context "restaurants are visible in the list of restaurants" do
    scenario "should display 2 restaurants after creating them" do
      Restaurant.create(name: "Pizza Express", address: "London", description: "pizza", user_id: user.id)
      Restaurant.create(name: "Burger King", address: "Bristol", description: "Burger", user_id: user.id)
      visit "/restaurants"
      expect(page).to have_content("Pizza Express")
      expect(page).to have_content("Burger King")
      expect(page).not_to have_content("No restaurants yet")
    end
  end

  context "user can add a new restaurant" do
    scenario 'adding a new restaurant' do
      visit '/restaurants'
      click_link "Add a restaurant"
      expect(page).to have_content('Name')
      fill_in('restaurant_name', :with => "Dirty Bones")
      fill_in('restaurant_description', :with => "Dirty")
      fill_in('restaurant_address', :with => "Kensington Church Street")
      click_button('Create Restaurant')
      expect(current_path).to eq '/restaurants'
    end

    context "invalid restaurant" do
      scenario "adding a new restaurant with a too short name" do
        visit "/restaurants"
        click_link "Add a restaurant"
        fill_in('restaurant_name', :with => "Mc")
        fill_in('restaurant_description', :with => "Dirty")
        fill_in('restaurant_address', :with => "Kensington Church Street")
        click_button('Create Restaurant')

        expect(page).not_to have_css("h2", text: "Mc")
        expect(page).to have_content("error")
      end
    end

  end

  context "viewing restaurants" do

    let!(:kfc){ Restaurant.create(name: "KFC", address: "London", description: "chicken", user_id: user.id) }

    scenario "user can view a restaurant page" do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content "KFC"
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context "editing restaurants" do

    let!(:kfc){ Restaurant.create(name: "KFC", address: "London", description: "chicken", user_id: user.id) }

    scenario "user can edit a restaurant" do
      visit "/restaurants"
      click_link "Sign out"
      click_link "Sign in"
      fill_in('Email', with: 'Laura@troll.com')
      fill_in('Password', with: '123456')
      click_button('Log in')

      visit '/restaurants'
      click_link 'KFC'
      click_link 'Edit KFC'
      fill_in('Name', with: "Dirty Bones")
      fill_in("Description", with: "Dirty American food")
      fill_in("Address", with: "West London")
      click_button 'Update Restaurant'
      expect(page).to have_content 'Dirty Bones'
      expect(current_path).to eq '/restaurants'
    end

    scenario "user cannot edit a restaurant owned by another use" do
      visit '/restaurants'
      click_link 'KFC'
      expect(current_path).to eq("/restaurants/#{kfc.id}")
      expect(page).not_to have_content("Edit KFC")
    end

  scenario "user cannot access the edit page of a restaurant owned by another user" do
    visit "/restaurants/#{kfc.id}/edit"
    fill_in('Name', with: "Dirty Bones")
    fill_in("Description", with: "Dirty American food")
    fill_in("Address", with: "West London")
    click_button 'Update Restaurant'
    expect(page).to have_content("Sorry, you can only edit restaurants you have created")
  end
end

  context "destroying restaurants" do
    scenario 'should delete restaurant from db when restaurant deletes in edit page' do
      visit '/restaurants/new'
      expect(page).to have_content('Name')
      fill_in('restaurant_name', :with => "Dirty Bones")
      fill_in('restaurant_description', :with => "Dirty")
      fill_in('restaurant_address', :with => "Kensington Church Street")
      click_button('Create Restaurant')
      expect(current_path).to eq '/restaurants'

      click_link('Dirty Bones')
      expect(current_path).to match(/restaurants\/\d+/)
      expect(page).to have_content("Dirty Bones")
      click_link("Edit Dirty Bones")
      expect(current_path).to match(/restaurants\/\d+\/edit/)
      click_link("Delete listing")
      expect(current_path).to eq '/restaurants'
      expect(page).to_not have_content('Dirty Bones')
      end
    end

    scenario "user cannot delete a restaurant owned by another user" do
      visit "/restaurants/#{kfc.id}/edit"
      expect(page).not_to have_content("Delete listing")
    end
end
