def sign_in(email: "laura@troll.com", password: "123456")
  visit('/')
  click_link('Sign in')
  fill_in('user_email', with: email)
  fill_in('user_password', with: password)
  click_button('Log in')
end

def sign_up(email: "test@example.com", password: "123456", password_confirmation: "123456")
  visit('/')
  click_link('Sign up')
  fill_in('user_email', with: email)
  fill_in('user_password', with: password)
  fill_in('user_password_confirmation', with: password_confirmation)
  click_button('Sign up')
end

def sign_out
  click_link('Sign out')
end

def visit_restaurant(restaurant)
  visit("/restaurants")
  click_link(restaurant.name)
end

def visit_restaurant_and_add_review(rating: "4", comment: "Tasty chicken", restaurant: )
  visit_restaurant(restaurant)
  click_link "Add review"
  add_review(rating: rating, comment: comment, restaurant: restaurant)
end

def add_review(rating: "4", comment: "Tasty chicken", restaurant: )
  fill_in('Comment', with: comment)
  select(rating, from: "Rating")
  click_button "Create Review"
end

def visit_restaurant_and_click_edit_review(restaurant)
  visit("/restaurants/#{restaurant.id}/reviews/")
  click_link("Edit review")
end

def visit_restaurant_and_edit_review(rating: "5", comment: "awesome", restaurant: )
  visit_restaurant_and_click_edit_review(restaurant)
  fill_in("Comment", with: comment)
  select(rating, from: "Rating")
  click_button("Update Review")
end

def add_restaurant(name: "Dirty Bones", address: "Kensington Church Street", description: "Dirty-filthy")
  visit('/restaurants')
  click_link('Add restaurant')
  fill_in('restaurant_name', with: name)
  fill_in('restaurant_description', with: description)
  fill_in('restaurant_address', with: address)
  click_button('Create Restaurant')
end

def edit_restaurant(name: "Dirty Bones", address: "West London", description: "Dirty American food", restaurant: )
  visit_restaurant(restaurant)
  click_link "Edit #{restaurant.name}"
  fill_in('restaurant_name', with: name)
  fill_in('restaurant_description', with: description)
  fill_in('restaurant_address', with: address)
  click_button 'Update Restaurant'
end
