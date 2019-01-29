class GamesController < ApplicationController
    require 'pry'

    def index 
        @games = Game.all
    end 

    def new
        if user_signed_in?
            @game = Game.new
        else
            go_log_in
        end
    end

    def create
        game = Game.new(game_params)
        if game.save
            redirect_to root_path
        else 
            flash[:alert] = "This game has already been created!"
            redirect_to new_game_path 
        end
    end

    def show 
        @game = Game.find(params[:id])
    end 

    def edit
        if user_signed_in?
            @game = Game.find(params[:id])
            unless current_user == @game.users.first
                flash[:alert] = "Only the Game Creator can Edit!"
                redirect_to game_path(@game)
            end
        else
            go_log_in
        end
    end

    def update
        game = Game.find(params[:id])
        game.update(game_params)
        if game.save
            redirect_to game_path(game)
        else
            
            redirect_to edit_game_path(game)
        end
    end
    

    def destroy
        if user_signed_in?
            game = Game.find(params[:id])
            # binding.pry
            if current_user == game.users.first
                game.delete
                flash[:alert] = "Your game #{game.name} has been deleted"
                redirect_to root_path
            else 
                flash[:alert] = "Only the Game Creator can delete it"
                redirect_to game_path(game)
            end
        else
            go_log_in
        end
    end 

    private
        def game_params
            params.require(:game).permit(:name, :description)
        end

end
