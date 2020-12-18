require './config/environment'
require "./app/models/wine"

class WinesController < ApplicationController

    def index
        @wines = Wine.where(:user_id => current_user.id)
        binding.pry
        # redirect_to 'index'
    end

    def new
        @wine = Wine.new
        @wine.user_id = current_user.id
    end

    def show
        binding.pry
        @wine = Wine.find(params[:id])
    end

    def create
        @wine = Wine.new(wine_params)
        @wine.user_id = current_user.id
        if @wine.save
            redirect_to wine_path(@wine)
        else
            redirect_to new_wine_path
        end
    end


    private

    def wine_params
        params.require(:wine).permit(:wine_name, :color, :grape, :avg_price, :acidity, :sweetness, :user_id)
    end

end
