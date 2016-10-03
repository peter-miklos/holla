require 'rails_helper'

feature 'restaurants' do
  scenario 'should delete restaurant from db when restaurant deltes in edit page' do
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
    
    end
end
