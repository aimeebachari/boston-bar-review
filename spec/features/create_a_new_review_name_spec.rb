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

  scenario 'successfully' do
    login_as_user(user_one)
    visit bar_path(bar_one)

    click_on 'Add Review'

    choose '5'
    fill_in 'Review', with: 'So cheap and stuff'
    click_on 'Submit Review'

    click_on 'Add Review'

    choose '3'
    fill_in 'Review', with: 'So cheap and stuff'
    click_on 'Submit Review'

    expect(page).to have_content('Edit')

    page.first(:link, "Edit").click
    choose '4'
    click_on 'Submit Review'


    expect(page).to have_content('3.5')
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

    click_on 'Delete'

    expect(page).to_not have_content('This will delete')

  end
  DatabaseCleaner.clean
end
