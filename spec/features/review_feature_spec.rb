require "rails_helper"

feature "reviews" do
  let!(:kfc){ Restaurant.create(name: "KFC", address: "London", description: "chicken") }

  scenario "user can add a review to a restaurant" do
    visit "/restaurants/#{kfc.id}"
    click_link "Add review"
    # fill_in("Description", with: "Tasty chicken")
    # select("4", from: "Rating")
    # click_button "Submit"
    #
    # expect(page).to have_content("Tasty chicken")
    # expect(current_path).to eq "/restaurants/#{kfc.id}"
  end
end
