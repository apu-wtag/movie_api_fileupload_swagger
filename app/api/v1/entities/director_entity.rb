require_relative "movie_entity"
module V1
  module Entities
    class DirectorEntity < Grape::Entity
      expose :id, documentation: { type: "integer", desc: "Director ID" }
      expose :name, documentation: { type: "String", desc: "Director Name" }
      expose :dob, as: :date_of_birth, documentation: { type: "Date", desc: "Director Date of Birth" }
      expose :movies, using: V1::Entities::MovieEntity, documentation: { type: "MovieEntity", desc: "Movies of the director" }
    end
  end
end
