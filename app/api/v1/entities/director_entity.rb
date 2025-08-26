require_relative 'movie_entity'
module V1
  module Entities
    class DirectorEntity < Grape::Entity
      expose :id
      expose :name
      expose :dob, as: :date_of_birth
      expose :movies, using: V1::Entities::MovieEntity
    end
  end
end