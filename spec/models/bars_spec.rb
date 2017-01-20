require "rails_helper"
require "database_cleaner"

DatabaseCleaner.strategy = :truncation

user_one = User.create(first_name: "Sam", last_name: "Cole", username: "Sammo", email: "123@gmail.com", encrypted_password: "ththth")
bar_one = Bar.create(name: "JJ's", address: "123 Summer Street", city: "Boston", state: "MA", zip: "02111", url: "", description: "", user: user_one)

RSpec.describe Bar, :type => :model do
  DatabaseCleaner.start

  it "is valid with a name" do
    expect(bar_one.name).to eq("JJ's")
  end

  it "is valid with a address" do
    expect(bar_one.address).to eq("123 Summer Street")
  end

  it "is valid with a city" do
    expect(bar_one.city).to eq("Boston")
  end

  it "is valid with a state" do
    expect(bar_one.state).to eq("MA")
  end

  it "is valid with a zip code" do
    expect(bar_one.zip).to eq("02111")
  end

  it "is not valid without a name" do
    bad_bar = Bar.new(name: nil)
    expect(bad_bar).to_not be_valid
  end

  it "is not valid without an address" do
    bad_bar = Bar.new(address: nil)
    expect(bad_bar).to_not be_valid
  end

  it "is not valid without a city" do
    bad_bar = Bar.new(city: nil)
    expect(bad_bar).to_not be_valid
  end

  it "is not valid without a state" do
    bad_bar = Bar.new(state: nil)
    expect(bad_bar).to_not be_valid
  end

  it "is not valid without a zip code" do
    bad_bar = Bar.new(zip: nil)
    expect(bad_bar).to_not be_valid
  end
  DatabaseCleaner.clean
end
