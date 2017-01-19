require "spec_helper"

user_one = User.create(first_name: "Sam", last_name: "Cole", username: "Sammo", email: "123@gmail.com", encrypted_password: "ththth")
bar_one = Bar.create(name: "JJ's", address: "123 Summer Street", city: "Boston", state: "MA", zip: "02111", url: "", description: "", user: user_one)
review = Review.create(user: user_one, bar: bar_one, body: "This is a cool bar with $2 PBRs.", rating: 5)

RSpec.describe Review, :type => :model do

  it "is valid with a user" do
    expect(review.user).to eq(user_one)
  end

  it "is valid with a bar" do
    expect(review.bar).to eq(bar_one)
  end

  it "is valid with a body" do
    expect(review.body).to eq("This is a cool bar with $2 PBRs.")
  end

  it "is valid with rating" do
    expect(review.rating).to eq(5)
  end

  it "is not valid without a rating" do
    bad_review = Review.new(rating: nil)
    expect(bad_review).to_not be_valid
  end
end
