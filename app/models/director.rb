class Director < ApplicationRecord
  has_many :movies, dependent: :restrict_with_error
end
