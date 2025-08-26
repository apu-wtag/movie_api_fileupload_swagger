# Movie API with Rails and Grape

A robust, versioned, and well-documented RESTful API for managing a movie database. This project is built with Ruby on Rails in API-only mode and uses the Grape framework to define a clean and efficient API structure.

---

## Features

* **CRUD Operations:** Full Create, Read, Update, and Delete functionality for movies, directors, and reviews.
* **Rich Associations:** Manages complex relationships (one-to-many, many-to-many) between movies, directors, actors, and reviews.
* **File Uploads:** Supports movie poster image uploads using Rails' built-in Active Storage.
* **Interactive API Documentation:** Automatically generated, interactive Swagger UI for easy API exploration and testing.

---

## Tech Stack

* **Backend:** Ruby on Rails 8 (API-only)
* **API Framework:** Grape
* **Database:** PostgreSQL
* **File Storage:** Active Storage (local disk for development)
* **API Documentation:** `grape-swagger`, `grape-swagger-entity`, `grape-swagger-rails`
* **Pagination:** Kaminari

---

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:

* Ruby (version 3.4.x recommended)
* Rails (version 8.0.x recommended)
* PostgreSQL

---

## Getting Started

Follow these steps to get the application up and running on your local machine.

1.  **Clone the repository:**
    ```bash
    git clone <your-repository-url>
    cd movie-api
    ```

2.  **Install dependencies:**
    ```bash
    bundle install
    ```

3.  **Configure the database:**
    Ensure your PostgreSQL server is running. Then, create the application's database:
    ```bash
    rails db:create
    ```

4.  **Run database migrations:**
    This will set up all the necessary tables and relationships.
    ```bash
    rails db:migrate
    ```

5.  **Seed the database with initial data:**
    This will populate the database with sample movies, directors, and reviews.
    ```bash
    rails db:seed
    ```

6.  **Start the Rails server:**
    ```bash
    rails s
    ```
    The API will now be running at `http://localhost:3000`.

---

## API Endpoints

The API is versioned and all endpoints are prefixed with `/api/v1`.

### Main Resources:

* **Movies:** `GET, POST /movies` and `GET, PATCH, DELETE /movies/:id`
* **Directors:** `GET, POST /directors` and `GET, PATCH, DELETE /directors/:id`

### Nested Resources:

* **Reviews:** `GET, POST /movies/:id/reviews`

For a complete and interactive list of all available endpoints, parameters, and example responses, please visit the Swagger documentation.

---

## How to Use the API

### Interactive Documentation (Swagger UI)

The easiest way to explore and test the API is through the interactive Swagger documentation. With the server running, navigate to:

**`http://localhost:3000/swagger`**

From this UI, you can view all endpoints, see expected request/response models, and execute API calls directly from your browser.

### API Clients

You can also use any API client, such as [Postman](https://www.postman.com/) or `curl`, to interact with the endpoints.

**Example: Get all movies**
```bash
curl http://localhost:3000/api/v1/movies