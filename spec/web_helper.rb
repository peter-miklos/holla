def sign_in(email: "Laura@troll.com", password: "123456")
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

def add_rating(rating)
  fill_in('Comment', with: rating[:comment])
  select(rating[:number], from: "Rating")
  click_button "Create Review"
end

def add_restaurant(restaurant)
  visit('/restaurants')
  click_link('Add restaurant')
  fill_in('restaurant_name', with: restaurant[:name])
  fill_in('restaurant_description', with: restaurant[:description])
  fill_in('restaurant_address', with: restaurant[:address])
  click_button('Create Restaurant')
end
