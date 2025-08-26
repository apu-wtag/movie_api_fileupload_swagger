module V1
  module Entities
    class MovieEntity < Grape::Entity
      expose :id, documentation: { type: "integer", desc: "Movie ID" }
      expose :title, documentation: { type: "string", desc: "Title of the movie" }
      # expose :description, documentation: { type: 'string', desc: 'Description of the movie' }
      expose :release_date, documentation: { type: "string", format: "date", desc: "Release date of the movie (YYYY-MM-DD)" }
      expose :genre, documentation: { type: "string", desc: "Genre of the movie" }
      expose :poster_url, documentation: { type: "string", desc: "URL of the movie poster", required: false }

      private
      def poster_url
        if object.poster.attached?
          Rails.application.routes.url_helpers.rails_blob_url(object.poster, only_path: false)
        end
      end
    end
  end
end