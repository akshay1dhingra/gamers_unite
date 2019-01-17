class GamesController < ApplicationController
    require 'pry'

    def index 
        # binding.pry
        @games = Game.all
    end 

    def new 
        if user_signed_in?
            @game = Game.new
        else
            redirect_to root_path
        end
    end 

    def create
        raise.params
        @game = Game.new(game_params)
        if @game.save
            redirect_to game_path(@game)
        else 
            render :new
        end 
    end 

    def show 
        @game = Game.find(params[:id])
    end 

    def update 
    end

    def create
    end

    def destroy
    end 

    private

    def game_params
        params.require(:game).permit(
        :name, 
        :description)
    end

end
