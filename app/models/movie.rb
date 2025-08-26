class Movie < ApplicationRecord
  belongs_to :director
  has_many :reviews, dependent: :destroy
  has_many :castings, dependent: :destroy
  has_many :actors, through: :castings
  has_one_attached :poster
end
