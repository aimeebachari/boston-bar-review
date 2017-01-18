require 'rails_helper'

feature "user signs up for account" do
  scenario "successfully" do
    visit "/users/sign_up"

    fill_in "First Name", with: "Sonic"
    fill_in "Last Name", with: "The Hedgehog"
    fill_in "Username", with: "Sonic The Hedgehog"
    fill_in "Email", with: "sonic@hedgehog.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Sign up"
    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario "unsuccessfully - passwords don't match" do
    visit "/users/sign_up"

    fill_in "First Name", with: "Sonic"
    fill_in "Last Name", with: "The Hedgehog"
    fill_in "Username", with: "Sonic The Hedgehog"
    fill_in "Email", with: "sonic@hedgehog.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "e;vpkmefklvnr"

    click_on "Sign up"
    expect(page).to have_content "Passwords must match"
  end

  scenario "unsuccessfully - missing field" do
    visit "/users/sign_up"

    fill_in "First Name", with: "Sonic"
    fill_in "Last Name", with: "The Hedgehog"
    fill_in "Username", with: "Sonic The Hedgehog"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Sign up"
    expect(page).to have_content "Email can't be blank"
  end
end
