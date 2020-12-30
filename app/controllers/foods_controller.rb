require './config/environment'
require "./app/models/food"

class FoodsController < ApplicationController

    
    def show
        @food = Food.find(params[:id])
    end
    
    def new
        binding.pry
        @food = Food.new
        @wine = Wine.find(id = params[:wine_id])
        if params[:wine_id]
            @pairing = Pairing.new(wine_id: params[:wine_id])
        end
        binding.pry
    end


    private

    def food_params
        params.require(:food).permit(:food_name, :food_sweetness, :food_acidity, wine_ids: [], pairings_attributes: [:pairing_type])
    end
end
