require 'rails_helper'

feature 'restaurants' do

  let!(:user1){ User.create(email: "laura@troll.com", password: "123456") }
  let!(:user2){ User.create(email: "test@example.com", password: "123456") }

  context "No restaurants exist yet" do

    scenario "It says that there is no restaurant" do
      sign_in
      visit '/restaurants'
      expect(page).to have_content("No restaurant found")
      expect(page).to have_link("Add restaurant")
    end

  end

  context "A restaurant exists" do

    let!(:bk){ Restaurant.create(name: "Burger King", address: "London", description: "burger", user_id: user1.id) }
    let!(:kfc){ Restaurant.create(name: "KFC", address: "London", description: "chicken and stuff 123", user_id: user2.id) }

    context "When no user is signed in -" do

      scenario "user can view a restaurant page" do
        visit_restaurant(kfc)

        expect(page).to have_content "KFC"
        expect(page).to have_content "chicken and stuff 123"
        expect(current_path).to eq "/restaurants/#{kfc.id}"
      end

    end

    context "When a user is signed in -" do

      before {sign_in(email: "laura@troll.com")}

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
        expect(page).not_to have_content("No restaurant found")
      end

      scenario "user can quit from adding a new restaurant w/o saving it" do
        visit '/restaurants'
        click_link("Add restaurant")
        expect(page).to have_content("Cancel")

        click_link("Cancel")
        expect(current_path).to eq("/restaurants")
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
          sign_out
          sign_up(email: "james@gmail.com")
          visit_restaurant_and_add_review(rating: 2, comment: "terrible food", restaurant: kfc)
          sign_out
        end

        scenario "You see the average rating for a restaurant" do
          visit_restaurant(kfc)
          expect(page).to have_content("Average rating: 3.5")
        end

        scenario "You will see 'No ratings yet for this restaurant' if there are no ratings for a restaurant" do
          sign_up(email: "james5@gmail.com")
          add_restaurant(name: "Windows", address: "London")
          visit("/restaurants")
          click_link("Windows")
          expect(page).to have_content("No ratings yet for this restaurant")
        end

      end

      context "Edit restaurant" do

        scenario "A user can edit a restaurant that she owns" do
          visit_restaurant(bk)

          expect(page).to have_link("Edit Burger King")
          edit_restaurant(restaurant: bk)
          expect(page).to have_content 'Dirty Bones'
          expect(current_path).to eq "/restaurants/#{bk.id}"
        end

        scenario "user can quit from editing a restaurant w/o saving it" do
          visit_restaurant(bk)
          click_link("Edit Burger King")
          expect(page).to have_content("Cancel")

          click_link("Cancel")
          expect(current_path).to eq("/restaurants/#{bk.id}")
        end

        scenario "You can not edit a restaurant you do not own" do
          visit_restaurant(kfc)

          expect(page).not_to have_content("Edit KFC")
          expect(current_path).to eq("/restaurants/#{kfc.id}")
        end
      end

      context "Delete restaurant" do

        scenario "A user can delete a restaurants that she owns" do
          visit_restaurant(bk)
          expect(page).to have_link("Edit Burger King")
          click_link 'Edit Burger King'

          expect(page).to have_link("Delete listing")
          click_link("Delete listing")

          expect(current_path).to eq '/restaurants'
          expect(page).to_not have_content('Burger King')
        end

        scenario "A user can not delete a restaurant that he does not own" do
          visit "/restaurants/#{kfc.id}/edit"
          expect(page).not_to have_link("Delete listing")
        end
      end
    end
  end
end
