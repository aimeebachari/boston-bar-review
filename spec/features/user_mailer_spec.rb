require "rails_helper"

feature "email" do

  let(:user_one) { User.create(
    first_name: "Sam",
    last_name: "Cole",
    username: "Sammo",
    email: "123@gmail.com",
    password: "password")
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
    user: user_one
    )
  }
  xscenario "bar creator receives email when someone reviews a bar" do
    bar_one
    login_as_user(user_two)
    visit '/'
    click_on "JJ's"

    click_on "Add Review"
    fill_in "Review", with: "Wonderful!"
    choose "4"
    click_on "Submit Review"

    expect(page).to have_content("Wonderful!")
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  scenario "users don't get an email when they review their own bar" do
    bar_one
    login_as_user(user_one)
    visit '/'
    click_on "JJ's"

    click_on "Add Review"
    fill_in "Review", with: "Wonderful!"
    choose "4"
    click_on "Submit Review"

    expect(page).to have_content("Wonderful!")
    expect(ActionMailer::Base.deliveries.count).to eq(0)
  end
end
