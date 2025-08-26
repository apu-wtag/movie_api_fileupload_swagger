host = Rails.env.development? ? "localhost:3000" : "your-production-domain.com"

Rails.application.routes.default_url_options[:host] = host
