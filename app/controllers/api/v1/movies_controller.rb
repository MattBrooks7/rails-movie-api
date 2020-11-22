class Api::V1::MoviesController < ApplicationController
    before_action :set_movie, only: [:show, :update, :destroy]
    skip_before_action :authenticate, only: [:index, :show]
    
    #GET /movies
    def index
        @movies = Movie.all
        render json: @movies
    end

    #GET /movie/1
    def show
        @reviews = Review.where(movie_id: params[:id])
        render json: {movie: @movies, reviews: @reviews}
    end

    #POST /movies
    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            render json: @movie
        else
            render json: @movie.errors, status: :unprocessable_entity   
        end
    end

    #PATCH/PUT /movies/1
    def update
        if @movie.update(movie_params)
            render json: @movie
        else
            render json: @movie.errors, status: :unprocessable_entity
        end
    end

    #DELETE /movie/1
    def destroy
        @movie.destroy
    end


# Get our Amazon S3 keys for image uploads
    def get_upload_credentials
        @accessKey = ENV['S3_ACCESS']
        @secretKey = ENV['S3_SECRET']
        render json: {acessKey: @accessKey, secretKey: @secretKey}
    end

    private
    #Methods we place in private can only be accessed by other methods on our movie controller

    def set_movie
        @movie = Movie.find(params[:id])
    end

    def movie_params
        params.require(:movie).permit(:title, :description, :parental_rating, :year, :total_gross, :duration, :image, :cast, :director)
    end
    
end
