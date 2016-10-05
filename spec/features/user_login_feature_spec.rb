require "rails_helper"

feature "user login" do

  context "user not signed in" do
    scenario "user can login and logout" do
      visit "/"
      expect(page).to have_content("Sign up")
      expect(page).to have_content("Sign in")
    end
  end

  scenario "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    scenario "should see 'sign out' link and user email in nav bar" do
      visit('/')
      expect(page).to have_link('Sign out')
      expect(page).to have_css("li", text: "Signed in as test@example.com")
    end

    scenario "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end
