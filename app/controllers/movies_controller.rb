# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action -> { fetch_all }, only: [:index]
  before_action -> { fetch_movie }, only: %i[show destroy update]
  before_action -> { update_movie_details_before_save }, only: [:update]

  MOVIE_NOT_FOUND = 'No movie found for id %s'

  def index
    index_model(@movies)
  end

  def show
    show_model(@movie, format(MOVIE_NOT_FOUND, id), :not_found)
  end

  def create
    movie = Movie.new(name: name, director_name: director_name, release_date: release_date, is_active: is_active)
    create_model(movie)
  end

  def destroy
    destroy_model(@movie, format(MOVIE_NOT_FOUND, id), :method_not_allowed)
  end

  def update
    update_model(@movie, format(MOVIE_NOT_FOUND, id), :method_not_allowed)
  end

  private

  def id
    params[:id]
  end

  def name
    params[:name]
  end

  def director_name
    params[:director_name]
  end

  def release_date
    params[:release_date]
  end

  def is_active
    params[:is_active]
  end

  def fetch_movie
    @movie = Movie.find_by(id: id)
  end

  def fetch_all
    @movies = Movie.all
  end

  def update_movie_details_before_save
    if @movie
      @movie.name = name
      @movie.director_name = director_name
      @movie.release_date = release_date
      @movie.is_active = is_active
    end
  end
end
