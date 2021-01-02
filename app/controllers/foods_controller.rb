require './config/environment'
require "./app/models/food"

class FoodsController < ApplicationController

    
    def show
        @food = Food.find(params[:id])
    end
    
    def new
        binding.pry
        @food = Food.new
        @wine = Wine.find(params[:wine_id])
        @pairing = Pairing.new(wine_id: params[:wine_id])
        binding.pry
    end

    def create
        binding.pry
        @food = Food.new(food_params)
        binding.pry
        if @food.save
            binding.pry
            redirect_to @wine, notice: "Successfully created Pairing"
        else
            # binding.pry
            render :new
        end
    end


    private

    def food_params
        params.require(:food).permit(:food_name, :food_sweetness, :food_acidity, wine: [:id], pairings_attributes: [:id, :pairing_type])
    end

end
