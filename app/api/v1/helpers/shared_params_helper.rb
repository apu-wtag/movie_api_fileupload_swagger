module V1
  module Helpers
    module SharedParamsHelper
      extend Grape::API::Helpers
      params :movie_attributes do
        optional :title, type: String, desc: "Title of the movie"
        optional :description, type: String, desc: "Description of the movie"
        optional :release_date, type: Date, desc: "Release date"
        optional :genre, type: String, desc: "Genre of the movie"
        optional :director_id, type: Integer, desc: "ID of the director"
        optional :poster, type: File , desc: "Poster of the movie (Image File)"
      end
      params :director_attributes do
        optional :name, type: String, desc: "Name of the director"
        optional :dob, type: Date, desc: "Date of birth"
      end
    end
  end
end