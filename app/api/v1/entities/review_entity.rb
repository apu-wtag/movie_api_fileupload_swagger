module V1
  module Entities
    class ReviewEntity < Grape::Entity
      expose :id, documentation: { type: "Integer", desc: "Review id" }
      expose :rating, documentation: { type: "Integer", desc: "Rating of the movie" }
      expose :comment, documentation: { type: "String", desc: "Comment" }
    end
  end
end
