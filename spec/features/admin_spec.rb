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

  let(:review_one) {Review.create(
    body: "This is a review",
    rating: "5",
    user: user_two,
    bar: bar_one,
    )}

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
    bar_one
    login_as_user(user_one)

    expect(page).to have_content("JJ's")

    click_on("JJ's")

    expect(page).to have_content("Edit Bar")

    click_on("Edit Bar")
    click_on("Delete")

    expect(page).to_not have_content("JJ's")
  end

  scenario "admin can delete any review" do
    bar_one
    review_one
    login_as_user(user_two)
    click_on("JJ's")

    expect(page).to have_content("This is a review")

    expect(page).to have_content("Delete")

    click_on("Delete")

    expect(page).to_not have_content("This is a review")
  end

  
  DatabaseCleaner.clean
end
