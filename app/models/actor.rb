class Actor < ApplicationRecord
  has_many :castings, dependent: :destroy
  has_many :movies, through: :castings
end
