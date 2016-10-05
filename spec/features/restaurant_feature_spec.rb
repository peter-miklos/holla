require 'rails_helper'

feature 'restaurants' do

  context "No restaurants exist yet" do

    scenario "It says that there are no restaurants yet" do
      sign_up(email: "test@example.com", password: "testtest")
      visit '/restaurants'
      expect(page).to have_content("No restaurants yet")
      expect(page).to have_link("Add restaurant")
    end

  end

  context "A restaurant exists" do
    let!(:user){ User.create(email: "Laura@troll.com", password: "123456") }
    let!(:kfc){ Restaurant.create(name: "KFC", address: "London", description: "chicken", user_id: user.id) }

    context "When no user is signed in -" do

      scenario "user can view a restaurant page" do
        visit '/restaurants'
        click_link 'KFC'
        expect(page).to have_content "KFC"
        expect(current_path).to eq "/restaurants/#{kfc.id}"
      end

    end

    context "When a user is signed in -" do
      before do
        sign_up(email: "test@example.com", password: "testtest")
      end

      scenario "user can view a restaurant page" do
        visit '/restaurants'
        click_link 'KFC'
        expect(page).to have_content "KFC"
        expect(current_path).to eq "/restaurants/#{kfc.id}"
      end

      scenario 'adding a new restaurant' do
        visit '/restaurants'
        click_link "Add restaurant"
        expect(page).to have_content('Name')
        add_restaurant(name: "Dirty Bones", address: "Kensington Church Street", description: "Dirty-filthy")
        expect(current_path).to eq '/restaurants'
        expect(page).to have_content("Dirty Bones")
        expect(page).not_to have_content("No restaurants yet")
      end

      context "trying to add an invalid restaurant" do
        scenario "adding a new restaurant with a too short name" do
          add_restaurant(name: "Mc", address: "Street", description: "Dirty")
          expect(page).not_to have_css("h2", text: "Mc")
          expect(page).to have_content("error")
        end
      end
    end

    scenario "You can not edit a restaurant you do not own" do
      sign_up(email: "test@example.com", password: "testtest")
      visit '/restaurants'
      click_link 'KFC'
      expect(page).not_to have_content("Edit KFC")
      expect(current_path).to eq("/restaurants/#{kfc.id}")
    end

    scenario "A user can edit a restaurant that she owns" do
      sign_in(email: 'Laura@troll.com', password: '123456')
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_link("Edit KFC")
      click_link 'Edit KFC'

      fill_in('Name', with: "Dirty Bones")
      fill_in("Description", with: "Dirty American food")
      fill_in("Address", with: "West London")
      click_button 'Update Restaurant'
      expect(page).to have_content 'Dirty Bones'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end

    scenario "A user can delete a restaurants that she owns" do
      sign_in(email: 'Laura@troll.com', password: '123456')
      visit '/restaurants'
      click_link 'KFC'

      expect(page).to have_link("Edit KFC")
      click_link 'Edit KFC'

      expect(page).to have_link("Delete listing")
      click_link("Delete listing")

      expect(current_path).to eq '/restaurants'
      expect(page).to_not have_content('KFC')
    end

    scenario "A user can not delete a restaurant that he does not own" do
      sign_up(email: "test@example.com", password: "testtest")
      visit "/restaurants/#{kfc.id}/edit"
      expect(page).not_to have_link("Delete listing")
    end
  end
end
