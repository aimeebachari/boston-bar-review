require 'rails_helper'

feature "user signs up for account" do
  let (:user) { User.create(
    first_name: "Sonic",
    last_name: "The Hedgehog",
    username: "Sonic The Hedgehog",
    email: "sonic@hedgehog.com",
    password: "password"
    ) }

  visit user_registration_path
  attach_file('Avatar', File.absolute_path("./public/uploads/user/avatar/5/eamonn.png"))
  click_on "Update"

  expect(page).to have_content("Your account has been updated successfully.")
end
