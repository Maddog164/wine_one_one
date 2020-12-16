require './config/environment'
require "./app/models/food"

class FoodsController < ApplicationController

    def new
	    @food = Food.new(wine_id: params[:wine_id])
    end


    private

    def food_params
        params.require(:food).permit(:food_name, :food_sweetness, :food_acidity, :wine_id)
    end
end
