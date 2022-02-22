require 'rails_helper'

RSpec.describe Movie do
  describe 'relationships' do
    it { should belong_to :studio }
    it { should have_many :actor_movies }
    it { should have_many(:actors).through(:actor_movies) }
  end

  before(:each) do 
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
  end

  describe 'instance methods' do 
    describe '.sorted_actors' do 
      it 'sorts actors by age from youngest to oldest' do
         expect(@movie_1.sorted_actors).to eq([@actor_2, @actor_3, @actor_1])
      end
    end

    describe '.actor_average_age' do 
      it 'calculates average age for actors in movie' do
        expect(@movie_1.actor_average_age).to eq(30.67)
      end
    end
  end
end