require './config/environment'
require "./app/models/food"

class FoodsController < ApplicationController

    def new
        # binding.pry
        @food = Food.new(wine_id: params[:wine_id])
        @wine = Wine.find(id = params[:wine_id])
        binding.pry
    end


    private

    def food_params
        params.require(:food).permit(:food_name, :food_sweetness, :food_acidity, wine_ids: [])
    end
end
