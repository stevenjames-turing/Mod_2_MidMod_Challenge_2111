require 'rails_helper'

RSpec.describe 'movies show' do

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
    it 'displays movie info' do
        visit "/movies/#{@movie_1.id}/"
        
        expect(page).to have_content(@movie_1.title)
        expect(page).to have_content(@movie_1.creation_year)
        expect(page).to have_content(@movie_1.genre)
        expect(page).to_not have_content(@movie_2.title)
    end
    
    it 'has list of actors and average age of all actors' do 
        visit "/movies/#{@movie_1.id}/"
        
        within "#actors" do 
            expect(page).to have_content(@actor_1.name)
            expect(page).to have_content(@actor_2.name)
            expect(page).to have_content(@actor_3.name)
            expect(page).to_not have_content(@actor_4.name)
            
            expect(@actor_2.name).to appear_before(@actor_1.name)
            expect(@actor_2.name).to appear_before(@actor_3.name)
            expect(@actor_3.name).to appear_before(@actor_1.name)
            expect(@actor_1.name).to_not appear_before(@actor_2.name)
        end
        
        within "#actor_stats" do 
            expect(page).to have_content(@movie_1.actor_average_age)
        end
    end
    
    it 'can add actor to a movie' do 
        visit "/movies/#{@movie_3.id}/"

        expect(page).to have_content(@actor_5.name)
        expect(page).to_not have_content(@actor_1.name)
        expect(page).to_not have_content(@actor_2.name)
        expect(page).to_not have_content(@actor_3.name)
        expect(page).to_not have_content(@actor_4.name)
        
        expect(page).to have_content("Add Actor")
        fill_in 'actor', with: "#{@actor_1.name}"
        click_button 'Submit'
        expect(current_path).to eq("/movies/#{@movie_3.id}/")
        
        expect(page).to have_content(@actor_1.name)
    end

    
end