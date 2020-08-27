class ReviewsController < ApplicationController
    
    def index

    end

    def show

    end

    def create

    end
    
    def update

    end

    def destroy

    end

    private

    def review_params
        params.require(:review).permit(:body, :movie_id, :user_id)
    end

end
