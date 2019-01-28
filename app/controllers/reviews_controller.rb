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
    end

    def show
    end

    def destroy
    end

end
