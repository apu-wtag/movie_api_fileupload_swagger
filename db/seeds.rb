# db/seeds.rb
Casting.destroy_all
Review.destroy_all
Movie.destroy_all
Director.destroy_all
Actor.destroy_all

# Directors
nolan = Director.create!(name: 'Christopher Nolan', dob: '1970-07-30')
villeneuve = Director.create!(name: 'Denis Villeneuve', dob: '1967-10-03')

# Actors
leo = Actor.create!(name: 'Leonardo DiCaprio', dob: '1974-11-11')
bale = Actor.create!(name: 'Christian Bale', dob: '1974-01-30')
chalamet = Actor.create!(name: 'Timothée Chalamet', dob: '1995-12-27')

# Movies
inception = Movie.create!(title: 'Inception', description: 'A thief who steals corporate secrets...', release_date: '2010-07-16', genre: 'Sci-Fi', director: nolan)
dark_knight = Movie.create!(title: 'The Dark Knight', description: 'When the menace known as the Joker...', release_date: '2008-07-18', genre: 'Action', director: nolan)
dune = Movie.create!(title: 'Dune', description: 'Feature adaptation of Frank Herbert\'s novel...', release_date: '2021-10-22', genre: 'Sci-Fi', director: villeneuve)

# Castings (linking actors to movies with roles)
Casting.create!([
                  { movie: inception, actor: leo, role: 'Cobb' },
                  { movie: dark_knight, actor: bale, role: 'Batman' },
                  { movie: dune, actor: chalamet, role: 'Paul Atreides' }
                ])

# Reviews
Review.create!([
                 { movie: inception, rating: 5, comment: 'Mind-bendingly brilliant!' },
                 { movie: inception, rating: 4, comment: 'A true classic.' },
                 { movie: dark_knight, rating: 5, comment: 'A masterpiece of the genre.' }
               ])

puts "Seeded database with new relational data."
