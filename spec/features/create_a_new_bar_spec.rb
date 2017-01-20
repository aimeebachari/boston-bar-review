require "rails_helper"
require "database_cleaner"

DatabaseCleaner.strategy = :truncation



RSpec.feature "User creates a new bar" do
  DatabaseCleaner.start

  let(:user_one) { User.create(
    first_name: "Sam",
    last_name: "Cole",
    username: "Sammo",
    email: "123@gmail.com",
    password: "password"
    )
  }

  scenario "successful bar creation" do
    login_as_user(user_one)
    visit bars_path
    expect(page).to have_content "New Bar Form"

    fill_in "Name", with: "JJ's"
    fill_in "Address", with: "123 Summer Street"
    fill_in "City", with: "Boston"
    fill_in "State", with: "MA"
    fill_in "Zip", with: "02111"
    fill_in "Url", with: "www.jjs.com"
    fill_in "Description", with: "A great bar downtown!"

    click_button "Add Bar"

    expect(page).to have_content "Bar created successfully!"
    expect(page).to have_content "JJ's"
  end

  scenario "successful bar creation" do
    login_as_user(user_one)
    visit bars_path
    expect(page).to have_content "New Bar Form"

    fill_in "Name", with: "JJ's"
    fill_in "City", with: "Boston"
    fill_in "State", with: "MA"
    fill_in "Zip", with: "02111"
    fill_in "Url", with: "www.jjs.com"
    fill_in "Description", with: "A great bar downtown!"

    click_button "Add Bar"

    field = find_field("Name")
    expect(field.value).to eq("JJ's")
    expect(page).to have_content "Address can't be blank"
  end

  scenario "failed bar creation" do
    login_as_user(user_one)
    visit bars_path
    expect(page).to have_content "New Bar Form"

    click_button "Add Bar"

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Address can't be blank"
    expect(page).to have_content "City can't be blank"
    expect(page).to have_content "State can't be blank"
    expect(page).to have_content "Zip can't be blank"
    expect(page).to have_content "Zip is not a number "
    expect(page).to have_content "Zip is the wrong length (should be 5 characters)"
  end
  DatabaseCleaner.clean
end

feature "can delete a bar" do
  DatabaseCleaner.start

  let(:user_one) { User.create(
    first_name: "Sam",
    last_name: "Cole",
    username: "Sammo",
    email: "123@gmail.com",
    password: "password"
  )}

  let(:bar) { Bar.create(
    name: "Sample Bar",
    address: "1 Main St.",
    city: "Boston",
    state: "MA",
    zip: "02111",
    user: user_one
  )}

  scenario "successfully" do
    login_as_user(user_one)
    bar
    visit "/bars"

    expect(page).to have_content("Sample Bar")

    click_on "Sample Bar"
    click_on "Edit Bar"
    click_on "Delete"

    expect(page).to_not have_content("Sample Bar")
  end
end

RSpec.feature "User edits a bar" do
  DatabaseCleaner.start

    let(:user_one) { User.create(
      first_name: "Sam",
      last_name: "Cole",
      username: "Sammo",
      email: "123@gmail.com",
      password: "password"
      )
    }

    let(:bar_one) { Bar.create(
      name: "Happy Bar",
      address: "123 Abc Street",
      city: "Boston",
      state: "MA",
      zip: "02111",
      user: user_one
      )
    }

  scenario "successful edit" do
    login_as_user(user_one)
    bar_one
    visit bars_path

    click_on "Happy Bar"

    expect(page).to have_content "123 Abc Street"

    click_on "Edit Bar"

    fill_in "Address", with: "321 ZZZ Street"

    click_on "Submit"

    expect(page).to_not have_content "123 Abc Street"
    expect(page).to have_content "321 ZZZ Street"
  end
  DatabaseCleaner.clean
end
