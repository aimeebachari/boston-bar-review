require 'rails_helper'

feature "user signs up for account" do
  xscenario "successfully" do
    visit "/users/sign_up"

    fill_in "First Name", with: "Sonic"
    fill_in "Last Name", with: "The Hedgehog"
    fill_in "Username", with: "Sonic The Hedgehog"
    fill_in "Email", with: "sonic@hedgehog.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Create Account"
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

    click_on "Create Account"
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  scenario "unsuccessfully - missing field" do
    visit "/users/sign_up"

    fill_in "First Name", with: "Sonic"
    fill_in "Last Name", with: "The Hedgehog"
    fill_in "Username", with: "Sonic The Hedgehog"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Create Account"
    expect(page).to have_content "Email can't be blank"
  end

  scenario "successfully signs out" do
    visit "/users/sign_up"

    fill_in "First Name", with: "Sonic"
    fill_in "Last Name", with: "The Hedgehog"
    fill_in "Username", with: "Sonic The Hedgehog"
    fill_in "Email", with: "sonic@hedgehog.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Create Account"
    visit edit_user_registration_path

    click_on "Logout"
    expect(page).to have_content "You need to sign in or sign up before continuing."
  end

  scenario "successfully edits user information" do
    visit edit_user_registration_path

    click_on "Edit"

    fill_in "First Name", with: "Sam"
    fill_in "Last Name", with: "Cole"
    fill_in "Username", with: "samcole"
    fill_in "email", with: "samcole@hello.com"

    click_on "Update"
    expect(user.first_name).to_be "Sam"
    expect(user.last_name).to_be "Cole"
    expect(user.username).to_be "samcole"
    expect(user.email).to_be "samcole@hello.com"
  end

  scenario "successfully deletes account" do
    visit "/users/sign_up"

    fill_in "First Name", with: "Sonic"
    fill_in "Last Name", with: "The Hedgehog"
    fill_in "Username", with: "Sonic The Hedgehog"
    fill_in "Email", with: "sonic@hedgehog.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Sign up"
    visit edit_user_registration_path
    click "Edit Account"

    # save_and_open_page

    click_on "Cancel my account"
    expect(user).not_to exist
    expect(page).to have_content "Account Deleted"
  end
end
