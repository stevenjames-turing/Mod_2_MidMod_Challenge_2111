class MoviesController < ApplicationController

    def show
        @movie = Movie.find(params[:id])
    end
    
    def update
        @movie = Movie.find(params[:id])
        if params[:actor] != nil 
            @actor = Actor.find_by_name(params[:actor])
            ActorMovie.create!(movie_id: @movie.id, actor_id: @actor.id)
        end
        redirect_to "/movies/#{@movie.id}/"
    end
end