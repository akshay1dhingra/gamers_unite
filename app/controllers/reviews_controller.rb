class ReviewsController < ApplicationController
    
    def index
        @reviews = Review.all
        @user = current_user
    end

    def new
        if user_signed_in?
            @review = Review.new
        else 
            go_log_in
        end
    end

    def create
        @review = Review.new(review_params)
        if @review.save
            redirect_to game_review_path(@review.game, @review)
        else
            redirect_to new_game_review_path(@review.game)
        end
    end

    def show
        @review = Review.find(params[:id])
    end

    def destroy
    end

    private
    def review_params
        params.require(:review).permit(:title, :content, :score, :user_id, :game_id)
    end

end
