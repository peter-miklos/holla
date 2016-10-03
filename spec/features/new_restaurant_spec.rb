require 'rails_helper'

feature 'restaurants' do
  scenario 'adding a new restaurant' do
    visit '/restaurants/new'
    expect(page).to have_content('Name')
     fill_in('restaurant_name', :with => "Dirty Bones")
     fill_in('restaurant_description', :with => "Dirty")
     fill_in('restaurant_address', :with => "Kensington Church Street")
     click_button('Create Restaurant')
     expect(current_path).to eq '/restaurants'

  end
end
