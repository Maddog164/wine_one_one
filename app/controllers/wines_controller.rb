require './config/environment'
require "./app/models/wine"

class WinesController < ApplicationController

    def show
        binding.pry
        @wine = Wine.find(params[:id])
    end

    def create
        Wine.create(wine_params)
    end


    private

    def wine_params
        params.require(:wine).permit(:wine_name, :color, :grape, :avg_price, :acidity, :sweetness, :user_id)
    end

end
