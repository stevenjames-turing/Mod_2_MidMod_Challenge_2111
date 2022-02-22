class Movie < ApplicationRecord
  belongs_to :studio
  has_many :actor_movies
  has_many :actors, through: :actor_movies

  def sorted_actors 
    actors.order(age: :asc)
  end

  def actor_average_age
    if actors.count >= 1
      actors.sum(:age).fdiv(actors.count).round(2)
      # actors.average(:age).round(2)
    end
  end
end