class Movie < ApplicationRecord
  belongs_to :studio
  has_many :actor_movies
  has_many :actors, through: :actor_movies

  def sorted_actors 
    actors.order(age: :asc)
  end

  def actor_average_age
    actors.average(:age).round(2)
  end
end