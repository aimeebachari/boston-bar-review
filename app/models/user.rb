class User < ApplicationRecord
  has_many :bars
  has_many :votes

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
