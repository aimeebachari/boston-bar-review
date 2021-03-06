class Bar < ApplicationRecord
  has_many :reviews
  belongs_to :user

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true, numericality: true, length: { is: 5 }
  validates :description, length: { maximum: 300 }

  def self.search(term)
    if term
      where('LOWER (name) LIKE ?', "%#{term.downcase}%")
    else
      all
    end
  end
end
