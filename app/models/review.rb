class Review < ApplicationRecord
  belongs_to :user
  belongs_to :bar
  has_many :votes

  validates :score, numericality: true
  validates :rating, presence: true, numericality: { only_integer: true }

  def update_score!
    update(score: votes.sum(:value))
  end

end
