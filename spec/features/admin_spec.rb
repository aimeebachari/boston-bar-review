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

  let(:bar_one) { Bar.create(
    name: "JJ's",
    address: "123 Summer Street",
    city: "Boston",
    state: "MA",
    zip: "02999",
    url: "www.jjs.com",
    description: "A great bar downtown!",
    user: user_two
    )
  }

  DatabaseCleaner.start

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

  scenario "non-admin's can't access the users page" do
    login_as_user(user_two)
    visit "/users"

    expect(page).to have_content("You don't have permission to access this page!")
  end

  scenario "admin can delete any bar" do
    login_as_user(user_one)
    bar_one


  end

  scenario "admin can delete any review" do

  end

  # xscenario "admin can change admin status of users" do
  #
  # end
  DatabaseCleaner.clean
end
