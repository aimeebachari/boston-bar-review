require 'rails_helper'

feature "user signs up for account" do

  let (:user) {User.create(first_name: "Sonic", last_name: "The Hedgehog",
      username: "Sonic The Hedgehog", email: "sonic@hedgehog.com", password: "password") }

  scenario "successfully" do
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
    login_as_user(user)

    visit edit_user_registration_path

    click_on "Logout"
    expect(page).to have_content "You need to sign in or sign up before continuing."
  end

  scenario "successfully edits user information" do
    login_as_user(user)

    visit edit_user_registration_path

    fill_in "First Name", with: "Sam"
    fill_in "Last Name", with: "Cole"
    fill_in "Username", with: "samcole"
    fill_in "Email", with: "samcole@hello.com"
    fill_in "Current password", with: "password"

    click_on "Update"

    click_on "Edit profile"
    expect(find_field("First Name").value).to eq "Sam"
    expect(find_field("Last Name").value).to eq "Cole"
    expect(find_field("Username").value).to eq "samcole"
    expect(find_field("Email").value).to eq "samcole@hello.com"

  end

  scenario "successfully deletes account" do
    login_as_user(user)

    visit edit_user_registration_path

    click_on "Cancel my account"

    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
end
