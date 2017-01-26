require 'rails_helper'

DatabaseCleaner.strategy = :truncation

feature "user show page" do

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

  scenario "user has a link to their profile page" do
    login_as_user(user_one)

    expect(page).to have_content("View profile")
  end

  scenario "profile page has user information" do
    login_as_user(user_one)
    click_on("View profile")

    expect(page).to have_content("Sam Cole")
    expect(page).to have_content("Sammo")
    expect(page).to have_content("123@gmail.com")
  end

  scenario "profile page lists all the bars the user has created as links to show page" do
    bar_one
    login_as_user(user_one)
    click_on("View profile")

    expect(page).to have_content("JJ's")

    click_on("JJ's")

    expect(page).to have_content("123 Summer Street")
    expect(page).to have_content("A great bar downtown!")
  end
end
