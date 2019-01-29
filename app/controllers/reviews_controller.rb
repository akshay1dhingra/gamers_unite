class ReviewsController < ApplicationController
    
    def index
        @reviews = Review.all
        @user = current_user
        @games = Game.all
        # binding.pry
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

    def edit
        if user_signed_in?
            @review = Review.find(params[:id])
            unless current_user == @review.user
                flash[:alert] = "Only the Creator of this Review can edit it!"
            redirect_to game_review_path(@review.game, @review)
            end
        else 
            logged_in
        end   
    end

    def update
        @review = Review.find(params[:id])
        @review.update(review_params)
        if @review.save
            redirect_to game_review_path(@review.game, @review)
        else
            flash[:alert] = review.e
            redirect_to edit_game_review_path(@review.game, @review)
        end
    end

    def destroy
        if user_signed_in?
            review = Review.find(params[:id])
            if current_user == review.user
                review.delete
            end
            redirect_to reviews_path
        else
            flash[:alert] = "This is not your review to delete"
            go_log_in
        end
    end

    def descending_order 
        @reviews = Review.all
    end 

    private
    def review_params
        params.require(:review).permit(:title, :content, :score, :user_id, :game_id)
    end

end
