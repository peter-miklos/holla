require 'rails_helper'

feature 'restaurants' do

  let!(:user1){ User.create(email: "laura@troll.com", password: "123456") }
  let!(:user2){ User.create(email: "test@example.com", password: "123456") }

  context "No restaurants exist yet" do

    scenario "It says that there are no restaurants yet" do
      sign_in
      visit '/restaurants'
      expect(page).to have_content("No restaurants yet")
      expect(page).to have_link("Add restaurant")
    end

  end

  context "A restaurant exists" do

    let!(:kfc){ Restaurant.create(name: "KFC", address: "London", description: "chicken and stuff 123", user_id: user1.id) }

    context "When no user is signed in -" do

      scenario "user can view a restaurant page" do
        visit_restaurant(kfc)

        expect(page).to have_content "KFC"
        expect(page).to have_content "chicken and stuff 123"
        expect(current_path).to eq "/restaurants/#{kfc.id}"
      end

    end

    context "When a user is signed in -" do
      before {sign_in(email: "test@example.com")}

      scenario "user can view a restaurant page" do
        visit_restaurant(kfc)

        expect(page).to have_content "KFC"
        expect(current_path).to eq "/restaurants/#{kfc.id}"
      end

      scenario 'adding a new restaurant' do
        visit '/restaurants'
        click_link "Add restaurant"
        expect(page).to have_content('Name')
        add_restaurant
        expect(current_path).to eq '/restaurants'
        expect(page).to have_content("Dirty Bones")
        expect(page).not_to have_content("No restaurants yet")
      end

      context "trying to add an invalid restaurant" do
        scenario "adding a new restaurant with a too short name" do
          add_restaurant(name: "Mc")
          expect(page).not_to have_css("h2", text: "Mc")
          expect(page).to have_content("error")
        end
      end

      context "When some reviews have been created" do

        before do
          visit_restaurant_and_add_review(rating: 5, comment: "Good food", restaurant: kfc)
          visit_restaurant_and_add_review(rating: 2, comment: "terrible food", restaurant: kfc)
        end

        scenario "You see the average rating for a restaurant" do
          visit_restaurant(kfc)
          expect(page).to have_content("Average rating: 2.5")
        end

      end
    end



    scenario "You can not edit a restaurant you do not own" do
      sign_in(email: "test@example.com")
      visit_restaurant(kfc)

      expect(page).not_to have_content("Edit KFC")
      expect(current_path).to eq("/restaurants/#{kfc.id}")
    end

    scenario "A user can edit a restaurant that she owns" do
      sign_in
      visit_restaurant(kfc)

      expect(page).to have_link("Edit KFC")
      edit_restaurant(restaurant: kfc)
      expect(page).to have_content 'Dirty Bones'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end

    scenario "A user can delete a restaurants that she owns" do
      sign_in
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
      sign_in(email: "test@example.com")
      visit "/restaurants/#{kfc.id}/edit"
      expect(page).not_to have_link("Delete listing")
    end
  end
end
