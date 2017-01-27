require 'rails_helper'
require "database_cleaner"

DatabaseCleaner.strategy = :truncation

RSpec.feature 'user can add reviews' do

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

  DatabaseCleaner.start

  scenario 'successfully without description' do
    login_as_user(user_one)
    visit bar_path(bar_one)
    click_on 'Add Review'

    choose '5'
    click_on 'Submit Review'

    expect(page).to have_content("Review created successfully!")
  end

  scenario 'successfully with description' do
    login_as_user(user_one)
    visit bar_path(bar_one)
    click_on 'Add Review'

    choose '5'
    fill_in 'Review', with: 'So cheap and stuff'
    click_on 'Submit Review'

    expect(page).to have_content('So cheap and stuff')
  end

  scenario 'missing rating' do
    login_as_user(user_one)
    visit bar_path(bar_one)
    click_on 'Add Review'

    fill_in 'Review', with: 'So cheap and stuff'
    click_on 'Submit Review'

    expect(page).to have_content("Rating can't be blank")
    expect(find_field('Review').value).to eq('So cheap and stuff')
  end
  DatabaseCleaner.clean
end

RSpec.feature 'user can edit reviews' do
  DatabaseCleaner.start

  let(:user_one) { User.create(
    first_name: "Sam",
    last_name: "Cole",
    username: "Sammo",
    email: "123@gmail.com",
    password: "password"
  )}

  let(:user_two) { User.create(
    first_name: "Sterling",
    last_name: "Archer",
    username: "Dutchess",
    email: "archer@gmail.com",
    password: "things"
  )}

  let(:bar_one) { Bar.create(
    name: "JJ's",
    address: "123 Summer Street",
    city: "Boston",
    state: "MA",
    zip: "02999",
    url: "www.jjs.com",
    description: "A great bar downtown!",
    user: user_one
  )}

  let(:review_one) {Review.create(
    body: "This is a review",
    rating: "5",
    user: user_one,
    bar: bar_one,
    )}

  scenario 'successfully' do
    login_as_user(user_one)
    visit bar_path(bar_one)

    click_on 'Add Review'

    choose '5'
    fill_in 'Review', with: 'So cheap and stuff'
    click_on 'Submit Review'

    expect(page).to have_content('So cheap and stuff')

    click_on "Edit"

    fill_in "Review", with: 'Only kinda cheap and stuff'
    click_on "Submit Review"

    expect(page).to have_content('Only kinda cheap and stuff')
    expect(page).to_not have_content('So cheap and stuff')
  end

  scenario "can't edit if they didn't create" do
    login_as_user(user_one)
    visit bar_path(bar_one)
    click_on 'Add Review'

    choose '5'
    fill_in 'Review', with: 'So cheap and stuff'
    click_on 'Submit Review'

    click_on 'Logout'

    login_as_user(user_two)
    visit bar_path(bar_one)
    Capybara.exact = true
    expect(page).to_not have_link("Edit")
  end

  scenario "get kicked back if they manually enter URL and didn't create" do




    login_as_user(user_two)
    visit "/bars/#{bar_one.id}/reviews/#{review_one.id}/edit"

    expect(page).to have_content("You don't have permission to edit this review!")
  end
  DatabaseCleaner.clean
end

RSpec.feature 'user can destroy reviews' do
  DatabaseCleaner.start

  let(:user_one) { User.create(
    first_name: "Sam",
    last_name: "Cole",
    username: "Sammo",
    email: "123@gmail.com",
    password: "password")
  }

  let(:user_two) { User.create(
    first_name: "Sterling",
    last_name: "Archer",
    username: "Dutchess",
    email: "archer@gmail.com",
    password: "things"
  )}

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

  scenario 'user deletes a review' do
    login_as_user(user_one)
    visit bar_path(bar_one)

    click_on 'Add Review'

    choose '5'
    fill_in 'Review', with: 'This will delete'
    click_on 'Submit Review'

    expect(page).to have_content('This will delete')

    click_on 'Edit Bar'
    click_on 'Delete'

    expect(page).to_not have_content('This will delete')

  end

scenario 'can not delete a review they didnt write' do
    login_as_user(user_one)
    visit bar_path(bar_one)
    click_on 'Add Review'

    choose '5'
    fill_in 'Review', with: 'So cheap and stuff'
    click_on 'Submit Review'

    click_on 'Logout'

    login_as_user(user_two)
    visit bar_path(bar_one)

    expect(page).to_not have_link("Delete")
  end
  DatabaseCleaner.clean
end
