module V1
  module Entities
    class ActorEntity < Grape::Entity
      expose :id
      expose :name
      expose :dob, as: :date_of_birth
    end
  end
end