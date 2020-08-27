class API::V1::MoviesController < ApplicationController
    before_action :set_movie, only: [:show, :update, :destroy]
    skip_before action :authenticate, only: [:index, :show]
    #GET /movies

    def index
        @movies = Movie.all
        redner json: @movies
    end

    #GET /movie/v1
    def show
        render json: {movie: @movies }
    end

    #POST /movies
    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            render json: @movie
        else
            render json: @movie.errors, status: :unprocessable_entity
    end

    #PATCH/PUT /movies/v1
    def update
        if @movie.update(movie_params)
            render json: @movie
        else
            render json: @movie.errors, status: :unprocessable_entity
    end

    #DELETE /movie/v1
    def destroy
        @movies.destroy
    end

    private
    #Methods we place in private can only be accessedby other methods on our movie controller

    def set_movie
        @Movie = Movie.find(params[:id])
    end

    def movie_params
        params.require(:movie).permit(:title, :description, :parental_rating, :year, :total_gross, :duration, :image, :cast, :director)
    end


end
