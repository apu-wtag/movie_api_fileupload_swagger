module V1
  class Base < Grape::API
    version "v1", using: :path
    format :json
    prefix :api
    rescue_from ActiveRecord::RecordInvalid do |e|
      error!({ error: e.record.errors.full_messages }, 422)
    end
    rescue_from ActiveRecord::RecordNotFound do |e|
      error!({ error: e.message }, 404)
    end
    rescue_from ActiveRecord::InvalidForeignKey do |_e|
      error!({ error: "Invalid reference id" }, 422)
    end

    mount V1::Movies
    mount V1::Directors

    add_swagger_documentation(
      api_version: "v1",
      hide_documentation_path: true,
      mount_path: "/swagger_doc",
      info: {
        title: "Movie API",
        description: "A simple API for managing movies."
      }
    )
  end
end