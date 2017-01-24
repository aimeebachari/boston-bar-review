class Review < ApplicationRecord
  belongs_to :user
  belongs_to :bar

  validates :up_votes, numericality: true
  validates :down_votes, numericality: true
  validates :rating, presence: true, numericality: { only_integer: true }
end
