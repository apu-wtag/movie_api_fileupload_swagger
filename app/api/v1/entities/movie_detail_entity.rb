require_relative "movie_entity"
require_relative "director_entity"
require_relative "actor_entity"
require_relative "review_entity"
module V1
  module Entities
    class MovieDetailEntity < MovieEntity
      expose :description, documentation: { type: "string", desc: "Description of the movie" }
      # belong to
      expose :director, using: V1::Entities::DirectorEntity, documentation: { type: "DirectorEntity", desc: "Director of the movie"}
      # has many
      expose :actors, using: V1::Entities::ActorEntity, documentation: { type: "ActorEntity", desc: "Actors of the movie"}
      expose :reviews, using: V1::Entities::ReviewEntity, documentation: { type: "ReviewEntity", desc: "Reviews of the movie"}
    end
  end
end
