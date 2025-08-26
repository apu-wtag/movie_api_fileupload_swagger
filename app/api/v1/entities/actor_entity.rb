module V1
  module Entities
    class ActorEntity < Grape::Entity
      expose :id, documentation: { type: "integer", desc: "Actor ID" }
      expose :name, documentation: { type: "integer", desc: "Actor name" }
      expose :dob, as: :date_of_birth, documentation: { type: "Date", desc: "Actor Date of Birth" }
    end
  end
end
