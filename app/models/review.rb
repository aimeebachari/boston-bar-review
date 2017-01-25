class Review < ApplicationRecord
  belongs_to :user
  belongs_to :bar
  has_many :votes

  validates :up_votes, numericality: true
  validates :down_votes, numericality: true
  validates :rating, presence: true, numericality: { only_integer: true }

  def update_score!
    update(votes: votes.sum(:value))
  end

end
