class ReviewsController < ApplicationController
    
    def index
        @reviews = Review.all
        @user = current_user
    end

    def new
        if user_signed_in?
            @review = Review.new(user_id: current_user.id, game_id: params[:game_id])
            # binding.pry
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
        if user_signed_in?
            review = Review.find(params[:id])
            review.delete
            redirect_to reviews_path
        else
            go_log_in
        end
    end

    private
    def review_params
        params.require(:review).permit(:title, :content, :score, :user_id, :game_id)
    end

end
