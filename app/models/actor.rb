class Actor < ApplicationRecord
    has_many :actor_movies
    has_many :movies, through: :actor_movies

    def co_actors
        co_actors = []
        movies.each do |movie|
            movie.actors.each do |actor|
                if actor.id != id
                    co_actors << actor
                end
            end
        end
        co_actors.uniq
    end
end