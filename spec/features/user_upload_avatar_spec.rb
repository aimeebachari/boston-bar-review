require 'rails_helper'
require "database_cleaner"

DatabaseCleaner.strategy = :truncation

feature "user uploads image" do
  let (:user) { User.create(
    first_name: "Sonic",
    last_name: "The Hedgehog",
    username: "Sonic The Hedgehog",
    email: "sonic@hedgehog.com",
    password: "password"
    ) }

  scenario 'user uploads image and views changes' do
    login_as_user(user)
    visit edit_user_registration_path

    attach_file "Avatar", "#{Rails.root}/public/uploads/user/avatar/5/eamonn.png"
    fill_in "Current password", with: "password"
    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully.")

    click_on "Edit profile"
    expect(page).to have_css("img[src*='eamonn.png']")
  end

  scenario 'user uploads image at signin' do
    visit new_user_registration_path

    fill_in "First Name", with: "Sonic"
    fill_in "Last Name", with: "The Hedgehog"
    fill_in "Username", with: "Sonic The Hedgehog"
    fill_in "Email", with: "sonic@hedgehog.com"
    attach_file "Avatar", "#{Rails.root}/public/uploads/user/avatar/5/eamonn.png"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Create Account"

    expect(page).to have_content("Welcome! You have signed up successfully.")

    click_on "Edit profile"
    expect(page).to have_css("img[src*='eamonn.png']")
  end
end
