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
            redirect_to new_game_path 
        end
    end

    def show 
        @game = Game.find(params[:id])
    end 

    def edit
        if user_signed_in?
            @game = Game.find(params[:id])
            # redirect_to edit_game_path(@game)
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
            game.destroy
            redirect_to root_path 
        else
            go_log_in
        end
    end 

    private
        def game_params
            params.require(:game).permit(:name, :description)
        end

end
