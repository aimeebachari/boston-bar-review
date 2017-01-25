class Review < ApplicationRecord
  belongs_to :user
  belongs_to :bar
  has_many :votes

  validates :votes, numericality: true
  validates :rating, presence: true, numericality: { only_integer: true }

  def update_score!
    update(votes: votes.sum(:value))
  end

end
