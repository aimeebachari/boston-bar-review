class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :value, presence: true


end
