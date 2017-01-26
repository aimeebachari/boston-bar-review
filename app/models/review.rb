class Review < ApplicationRecord
  belongs_to :user
  belongs_to :bar
  has_many :votes

  validates :score, numericality: true
  validates :rating, presence: true, numericality: { only_integer: true }

  def update_score!
    # binding.pry
    # votes = review.votes
    # sum = 0
    # votes.each do |vote|
    #   sum += vote.value
    # end
    # sum
    update(score: votes.sum(:value))
  end

end
