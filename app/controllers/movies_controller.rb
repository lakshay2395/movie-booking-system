class MoviesController < ApplicationController

    before_action -> { fetch_all }, only: [:index]
    before_action -> { fetch_movie }, only: [:show, :destroy, :update] 
    before_action -> { update_movie_details_before_save }, only: [:update]

    MOVIE_NOT_FOUND = 'No movie found for id %s'.freeze

    def index
        render json: @movies, status: :ok
    end

    def show
        if @movie
            render json: @movie, status: :ok
        else
            handle_error(MOVIE_NOT_FOUND % [id],:not_found)
        end
    end

    def create
       movie = Movie.new(name: name, director_name: director_name, release_date: release_date,is_active: is_active) 
       if movie.valid?
            movie.save! 
            render json: movie, status: :created
       else
            handle_error(movie.errors.messages,:internal_server_error)
       end
    end

    def destroy
        if @movie
            @movie.destroy!
            render json: nil, status: :no_content
        else
            handle_error(MOVIE_NOT_FOUND % [id],:not_found)
        end
    end 

    def update
        if @movie.valid?
            @movie.save!
            render json: @movie, status: :ok
        else 
            handle_error(@movie.errors.messages,:internal_server_error)
        end
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
        @movie.name = name
        @movie.director_name = director_name
        @movie.release_date = release_date
        @movie.is_active = is_active
    end
    
end