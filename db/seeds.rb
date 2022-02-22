# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActorMovie.destroy_all
Actor.destroy_all
Movie.destroy_all
Studio.destroy_all


@studio_1 = Studio.create!(name: "Studio 1", location: "Hollywood")
@studio_2 = Studio.create!(name: "Studio 2", location: "Denver")
@studio_3 = Studio.create!(name: "Studio 3", location: "New York City")
@movie_1 = @studio_1.movies.create!(title: "Movie 1", creation_year: 1987, genre: "Comedy")
@movie_2 = @studio_1.movies.create!(title: "Movie 2", creation_year: 1990, genre: "Action")
@movie_3 = @studio_2.movies.create!(title: "Movie 3", creation_year: 1999, genre: "Action")
@movie_4 = @studio_3.movies.create!(title: "Movie 4", creation_year: 2012, genre: "Thriller")
@actor_1 = Actor.create!(name: "Actor 1", age: 36)
@actor_2 = Actor.create!(name: "Actor 2", age: 25)
@actor_3 = Actor.create!(name: "Actor 3", age: 31)
@actor_4 = Actor.create!(name: "Actor 4", age: 40)
@actor_5 = Actor.create!(name: "Actor 5", age: 28)
@actor_movie_1 = ActorMovie.create!(movie_id: @movie_1.id, actor_id: @actor_1.id) 
@actor_movie_2 = ActorMovie.create!(movie_id: @movie_1.id, actor_id: @actor_2.id) 
@actor_movie_3 = ActorMovie.create!(movie_id: @movie_1.id, actor_id: @actor_3.id) 
@actor_movie_4 = ActorMovie.create!(movie_id: @movie_2.id, actor_id: @actor_1.id) 
@actor_movie_5 = ActorMovie.create!(movie_id: @movie_2.id, actor_id: @actor_4.id) 
@actor_movie_5 = ActorMovie.create!(movie_id: @movie_3.id, actor_id: @actor_5.id) 