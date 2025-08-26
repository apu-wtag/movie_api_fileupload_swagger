module V1
  class Directors < Grape::API
    helpers V1::Helpers::SharedParamsHelper do
      def director
        Director.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        error!({ error: "Director not found" }, 404)
      end
    end
    resource :directors do
      desc "Return a list of all directors.", {
        summary: "Get all directors",
        detail: "Returns a list of all directors, including a nested list of their movies.",
        success: {
          model: V1::Entities::DirectorEntity,
          examples: {
            'application/json': {
              value: [
                { id: 1, name: "Christopher Nolan", date_of_birth: "1970-07-30", movies: [{ id: 1, title: "Inception", genre: "Sci-Fi", release_date: "2010-07-16" }] },
                { id: 2, name: "Denis Villeneuve", date_of_birth: "1967-10-03", movies: [{ id: 3, title: "Dune", genre: "Sci-Fi", release_date: "2021-10-22" }] }
              ]
              # summary: 'Example Directors List'
            }
          }
        },
        is_array: true,
        produces: ["application/json"],
        tags: ["directors"]
      }
      get do
        directors = Director.includes(:movies).all
        present directors, with: V1::Entities::DirectorEntity
      end
      desc "Create a new director.", {
        summary: "Create a director",
        detail: "Creates a new director record.",
        success: V1::Entities::DirectorEntity,
        failure: [
          { code: 400, message: "Bad Request / Validation error" },
          { code: 422, message: "Unprocessable Entity" }
        ],
        produces: ["application/json"],
        tags: ["directors"]
      }
      params do
        use :director_attributes
        requires :name, :dob
      end
      post do
        director_params = declared(params, include_missing: false)
        director = Director.create!(director_params)
        present director, with: V1::Entities::DirectorEntity
      end
      route_param :id do
        desc "Return a specific director.", {
          summary: "Get a single director",
          detail: "Returns all details for a single director, including their movies.",
          success: {
            model: V1::Entities::DirectorEntity,
            examples: {
              'application/json': {
                value: { id: 1, name: "Christopher Nolan", date_of_birth: "1970-07-30", movies: [{ id: 1, title: "Inception", genre: "Sci-Fi", release_date: "2010-07-16" }, { id: 2, title: "The Dark Knight", genre: "Action", release_date: "2008-07-18" }] },
                summary: "Example Director Response"
              }
            }
          },
          failure: [{ code: 404, message: "Director not found" }],
          produces: ["application/json"],
          tags: ["directors"]
        }
        get do
          present director, with: V1::Entities::DirectorEntity
        end
        desc "Update an existing director.", {
          summary: "Update a director",
          detail: "Updates one or more attributes of an existing director.",
          success: V1::Entities::DirectorEntity,
          failure: [
            { code: 400, message: "Bad Request / Validation error" },
            { code: 404, message: "Director not found" }
          ],
          produces: ["application/json"],
          tags: ["directors"]
        }
        params do
          use  :director_attributes
        end
        patch do
          update_params = declared(params, include_missing: false)
          director.update!(update_params)
          present director, with: V1::Entities::DirectorEntity
        end
        desc "Update an existing director.", {
          summary: "Update a director",
          detail: "Updates one or more attributes of an existing director.",
          success: V1::Entities::DirectorEntity,
          failure: [
            { code: 400, message: "Bad Request / Validation error" },
            { code: 404, message: "Director not found" }
          ],
          produces: ["application/json"],
          tags: ["directors"]
        }
        delete do
          director.destroy!
          status 204
        end
      end
    end
  end
end