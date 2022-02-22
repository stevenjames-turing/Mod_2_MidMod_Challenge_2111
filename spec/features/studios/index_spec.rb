require 'rails_helper'

RSpec.describe 'studio index' do
    it 'displays each studios name, location, and title of all moves for each studio' do
        studio_1 = Studio.create!(name: "Studio 1", location: "Hollywood")
        studio_2 = Studio.create!(name: "Studio 2", location: "Denver")
        studio_3 = Studio.create!(name: "Studio 3", location: "New York City")
        movie_1 = studio_1.movies.create!(title: "Movie 1", creation_year: 1987, genre: "Comedy")
        movie_2 = studio_1.movies.create!(title: "Movie 2", creation_year: 1990, genre: "Action")
        movie_3 = studio_2.movies.create!(title: "Movie 3", creation_year: 1999, genre: "Action")
        movie_4 = studio_3.movies.create!(title: "Movie 4", creation_year: 2012, genre: "Thriller")

        visit "/studios/"

        within "##{studio_1.id}" do 
            expect(page).to have_content(studio_1.name)
            expect(page).to have_content(studio_1.location)
            expect(page).to have_content(movie_1.title)
            expect(page).to have_content(movie_2.title)
            expect(page).to_not have_content(studio_2.name)
            expect(page).to_not have_content(movie_3.title)
        end
        
        within("##{studio_2.id}") do 
            expect(page).to have_content(studio_2.name)
            expect(page).to have_content(studio_2.location)
            expect(page).to have_content(movie_3.title)
            expect(page).to_not have_content(studio_3.name)
            expect(page).to_not have_content(movie_4.title)
        end
        
        within("##{studio_3.id}") do 
            expect(page).to have_content(studio_3.name)
            expect(page).to have_content(studio_3.location)
            expect(page).to have_content(movie_4.title)
            expect(page).to_not have_content(studio_1.name)
            expect(page).to_not have_content(movie_2.title)
        end
        
        expect(page).to_not have_content(movie_1.genre)
        expect(page).to_not have_content(movie_2.creation_year)
    end
end