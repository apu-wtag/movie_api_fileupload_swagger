module V1
  module Entities
    class ReviewEntity < Grape::Entity
      expose :id
      expose :rating
      expose :comment
    end
  end
end