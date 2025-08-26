module V1
  class Movies < Grape::API
    include Grape::Kaminari
    helpers V1::Helpers::SharedParamsHelper do
      def movie
        Movie.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        error!({ error: "Movie not found" }, 404)
      end
    end
    resource :movies do
      desc "Return a paginated list of movies.", {
        summary: "Get all movies",
        detail: "Returns a paginated list of all movies in the database. Use the `page` and `per_page` params to navigate through the results.",
        success: {
          model: V1::Entities::MovieEntity,
          examples: {
            'application/json': {
              value: [
                { id: 1, title: "Inception", genre: "Sci-Fi", release_date: "2010-07-16" },
                { id: 2, title: "The Dark Knight", genre: "Action", release_date: "2008-07-18" }
              ]
            }
          }
        },
        is_array: true,
        produces: ["application/json"],
        tags: ["movies"]
      }
      params do
        use :pagination, per_page: 2, max_per_page: 5
      end
      get do
        movies = Movie.includes(:director).all
        present paginate(movies), with: V1::Entities::MovieEntity
      end
      desc "Create a new movie.", {
        summary: "Create a movie",
        detail: "Creates a new movie record. The request body should be multipart/form-data if uploading a poster.",
        success: V1::Entities::MovieDetailEntity,
        failure: [
          { code: 400, message: "Bad Request / Validation error" },
          { code: 422, message: "Unprocessable Entity" }
        ],
        consumes: ["multipart/form-data"],
        produces: ["application/json"],
        tags: ["movies"]
      }
      params do
        use :movie_attributes
        requires :title, :description, :release_date, :genre, :director_id
      end
      post do
        movie_params = declared(params, include_missing: false).except(:poster)
        poster_file = params[:poster]
        movie = Movie.create!(movie_params)
        if poster_file
          movie.poster.attach(
            io: poster_file[:tempfile], filename: poster_file[:filename],content_type: poster_file[:type]
          )
        end
        present movie, with: V1::Entities::MovieDetailEntity
      end
      route_param :id do
        desc "Return a specific movie.", {
          summary: "Get a single movie",
          detail: "Returns all details for a single movie, including its director, actors, and reviews.",
          success: {
            code: 200,
            model: V1::Entities::MovieDetailEntity,
            examples: {
              'application/json': {
                value: {
                  id: 1,
                  title: "Inception",
                  genre: "Sci-Fi",
                  release_date: "2010-07-16",
                  description: "A thief who steals corporate secrets through the use of dream-sharing technology...",
                  director: { id: 1, name: "Christopher Nolan", date_of_birth: "1970-07-30" },
                  actors: [{ id: 1, name: "Leonardo DiCaprio", date_of_birth: "1974-11-11" }],
                  reviews: [{ id: 1, rating: 5, comment: "Mind-bendingly brilliant!" }],
                  poster_url: "http://localhost:3000/rails/active_storage/blobs/redirect/..."
                },
                summary: "Example Detailed Response"
              }
            }
          },
          failure: [{ code: 404, message: "Movie not found" }],
          produces: ["application/json"],
          tags: ["movies"]
        }
        get do
          present movie, with: V1::Entities::MovieDetailEntity
        end
        desc "Update an existing movie.", {
          summary: "Update a movie",
          detail: "Updates one or more attributes of an existing movie. Can be used to upload or change a poster.",
          success: V1::Entities::MovieDetailEntity,
          failure: [
            { code: 400, message: "Bad Request / Validation error" },
            { code: 404, message: "Movie not found" }
          ],
          consumes: ["application/json", "multipart/form-data"],
          produces: ["application/json"],
          tags: ["movies"]
        }
        params do
          use :movie_attributes
        end
        patch do
          update_params = declared(params, include_missing: false).except(:poster)
          poster_file = params[:poster]
          movie.update!(update_params)
          if poster_file
            movie.poster.attach(
              io: poster_file[:tempfile], filename: poster_file[:filename],content_type: poster_file[:type]
            )
          end
          present movie, with: V1::Entities::MovieDetailEntity
        end
        desc "Delete an existing movie.", {
          summary: "Delete a movie",
          detail: "Permanently deletes a movie and its associated reviews and castings.",
          failure: [{ code: 404, message: "Movie not found" }],
          success_code: 204,
          tags: ["movies"]
        }
        delete do
          movie.destroy!
          status 204
        end
        #reviews resource
        resource :reviews do
          desc "Return all reviews for a specific movie.", {
            summary: "Get movie reviews",
            detail: "Returns a list of all reviews associated with a given movie ID.",
            success: {
              model: V1::Entities::ReviewEntity,
              examples: {
                'application/json': {
                  value: [
                    { id: 1, rating: 5, comment: "Mind-bendingly brilliant!" },
                    { id: 2, rating: 4, comment: "A true classic." }
                  ],
                  summary: "Example Reviews List"
                }
              }
            },
            failure: [{ code: 404, message: "Movie not found" }],
            is_array: true,
            produces: ["application/json"],
            tags: ["reviews"]
          }
          get do
            present movie.reviews, with: V1::Entities::ReviewEntity
          end
          desc "Return all reviews for a specific movie.", {
            summary: "Get movie reviews",
            detail: "Returns a list of all reviews associated with a given movie ID.",
            success: {
              model: V1::Entities::ReviewEntity,
              examples: {
                'application/json': {
                  value: [
                    { id: 1, rating: 5, comment: "Mind-bendingly brilliant!" },
                    { id: 2, rating: 4, comment: "A true classic." }
                  ],
                  summary: "Example Reviews List"
                }
              }
            },
            failure: [{ code: 404, message: "Movie not found" }],
            is_array: true,
            produces: ["application/json"],
            tags: ["reviews"]
          }
          params do
            requires :rating, type: Integer, values: 1..5, documentation: { type: 'integer', desc: 'Rating (1-5)', example: 5 }
            requires :comment, type: String, documentation: { type: 'string', desc: 'The review comment', example: 'Absolutely fantastic!' }
          end

          post do
            review_params = declared(params, include_missing: false)
            review = movie.reviews.create!(review_params)
            present review, with: V1::Entities::ReviewEntity
          end
        end
      end
    end
  end
end
