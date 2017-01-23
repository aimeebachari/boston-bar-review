require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

feature "Admin permissions" do
  let(:user_one) { User.create(
    first_name: "Sam",
    last_name: "Cole",
    username: "Sammo",
    email: "123@gmail.com",
    password: "password",
    admin: "true"
    )
  }

  let(:user_two) { User.create(
    first_name: "Sonic",
    last_name: "The Hedgehog",
    username: "Sonic",
    email: "sonic@gmail.com",
    password: "password"
    )
  }

  scenario "admin can view a list of users" do
    login_as_user(user_one)
    user_two
    visit "/users"

    expect(page).to have_content("Sam Cole")
    expect(page).to have_content("Sonic The Hedgehog")
  end

  scenario "admin can delete users" do
    login_as_user(user_one)
    user_two
    visit "/users"

    expect(page).to have_content("Delete")

    click_on("#{user_two.id}")
    expect(page).to_not have_content("Sonic The Hedgehog")
  end

  xscenario "admin can change admin status of users" do

  end

  scenario "admin can delete any bar" do

  end

  scenario "admin can delete any review" do

  end
end
