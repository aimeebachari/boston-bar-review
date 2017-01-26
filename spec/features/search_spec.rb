require 'rails_helper'
require "database_cleaner"

DatabaseCleaner.strategy = :truncation

feature "search" do
  let(:user_one) { User.create(
    first_name: "Sam",
    last_name: "Cole",
    username: "Sammo",
    email: "123@gmail.com",
    password: "password")
  }

  let(:bar_one) { Bar.create(
    name: "JJ's",
    address: "123 Summer Street",
    city: "Boston",
    state: "MA",
    zip: "02999",
    url: "www.jjs.com",
    description: "A great bar downtown!",
    user: user_one
    )
  }
  let(:bar_two) { Bar.create(
    name: "Great Bar",
    address: "123 Summer Street",
    city: "Boston",
    state: "MA",
    zip: "02111",
    user: user_one
    )
  }

  DatabaseCleaner.start

  scenario "searches for a bar successfully" do
    login_as_user(user_one)
    bar_one
    bar_two
    visit "/"

    expect(page).to have_content("Great Bar")
    expect(page).to have_content("JJ's")

    fill_in "term", with: "great"
    click_on "Search"

    expect(page).to have_content("Great Bar")
    expect(page).to_not have_content("JJ's")
  end

  scenario "searches for a bar with no matches" do
    login_as_user(user_one)
    bar_one
    bar_two
    visit "/"

    expect(page).to have_content("Great Bar")
    expect(page).to have_content("JJ's")

    fill_in "term", with: "Random Nonsense"
    click_on "Search"

    expect(page).to_not have_content("Great Bar")
    expect(page).to_not have_content("JJ's")
  end

  DatabaseCleaner.clean
end
