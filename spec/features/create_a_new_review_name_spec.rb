require 'rails_helper'
require "database_cleaner"

DatabaseCleaner.strategy = :truncation

RSpec.feature 'user can add reviews' do
  DatabaseCleaner.start

  scenario 'successfully without description' do
    visit '/bars'
    click_on "JJ's"
    click_on 'Add Review'

    choose '5'
    click_on 'Submit'

    expect(page).to have_content("Review created successfully!")
  end

  scenario 'successfully with description' do
    visit '/bars'
    click_on "JJ's"
    click_on 'Add Review'

    choose '5'
    fill_in 'Review', with: 'So cheap and stuff'
    click_on 'Submit'

    expect(page).to have_content('So cheap and stuff')
  end

  scenario 'missing rating' do
    visit '/bars'
    click_on "JJ's"
    click_on 'Add Review'

    fill_in 'Review', with: 'So cheap and stuff'
    click_on 'Submit'

    expect(page).to have_content("Rating can't be blank")
    expect(find_field('Review').value).to eq('So cheap and stuff')
  end
  DatabaseCleaner.clean
end

RSpec.feature 'user can edit reviews' do
  DatabaseCleaner.start
  scenario 'successfully' do
    visit '/bars'
    click_on "JJ's"

    click_on 'Add Review'

    choose '5'
    fill_in 'Review', with: 'So cheap and stuff'
    click_on 'Submit'

    expect(page).to have_content('Edit')

    click_on 'Edit'
    choose '4'
    click_on 'Submit'

  end
  DatabaseCleaner.clean
end

RSpec.feature 'user can delete reviews' do
  DatabaseCleaner.start
  scenario 'successfully' do

  end
  DatabaseCleaner.clean
end
