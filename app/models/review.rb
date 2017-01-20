class Review < ApplicationRecord
  belongs_to :user
  belongs_to :bar

  validates :rating, presence: true, numericality: { only_integer: true }
end
