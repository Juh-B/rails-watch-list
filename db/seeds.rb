# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

require 'open-uri'
require 'json'

# DELETE PRE-EXISTING RECORDS
print 'Cleaning up database...'
Bookmark.destroy_all
Movie.destroy_all
List.destroy_all
puts 'Cleaned!'

# GET INFO AND CREATING MOVIES FROM API
print 'Getting movies from API...'
movie_url = 'http://tmdb.lewagon.com/movie/top_rated'
movie_serialized = URI.open(movie_url).read
top_movies = JSON.parse(movie_serialized)
puts 'Done!'

print 'Creating top movies...'
top_movies['results'].each do |movie|
  title = movie['title']
  overview = movie['overview']
  poster_url = "https://image.tmdb.org/t/p/w300#{movie['poster_path']}"
  rating = movie['vote_average'].to_f

  Movie.create!(title: title, overview: overview, poster_url: poster_url, rating: rating)
end
puts 'Created!'

# CREATING MOVIES - SEEDS
print 'Creating more movies...'
Movie.create!(title: 'Wonder Woman 1984', overview: 'Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s', poster_url: "https://image.tmdb.org/t/p/w300/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
Movie.create!(title: 'Titanic', overview: '101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.', poster_url: "https://image.tmdb.org/t/p/w300/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
Movie.create!(title: "Ocean's Eight", overview: 'Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.', poster_url: "https://image.tmdb.org/t/p/w300/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)
puts 'Created!'

# CREATING THE FIRST LIST
print 'Creating a list...'
List.create!(name: 'Favorites')
puts 'Created!'
