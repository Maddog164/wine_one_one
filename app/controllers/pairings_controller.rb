require './config/environment'
require "./app/models/wine"

class PairingsController < ApplicationController

    
    
    def index
        if params[:wine_id]
            @pairings = Wine.find(params[:wine_id]).pairings
            @wine = Wine.find(params[:wine_id])
        else
            @pairings = Pairing.all
        end
    end

    def new
        # binding.pry
        @wine = Wine.find(params[:wine_id])
        @pairings = @wine.pairings.build
        # @pairing = Pairing.new
        # @wine.user_id = current_user.id
        # pairing = @wine.pairings.build
        # pairing.foods.build
        # @wine.pairings.build
        # binding.pry
    end

    def create
        @pairing = Pairing.create(pairing_params)
        # binding.pry
        if @pairing.save
            # binding.pry
            redirect_to @pairing, notice: "Created a New Pairing"
        else
            # binding.pry
            render :new
        end
    end

    def update
        # binding.pry
        @pairing = Pairing.find(params[:id])
        @pairing.update(pairing_params)
        # binding.pry
        @food = Food.find(@pairing.food_id)
        # binding.pry
        redirect_to wine_food_path(@food, @food.id)
    end

    def show
        @pairing = Pairing.find(params[:id])
    end

    private

    def pairing_params
        params.require(:pairing).permit(:pairing_type, :id, :wine_id, food_ids: [], foods_attributes: [:id, :food_name, :food_sweetness, :food_acidity])

    end

    # params.require(:wine).permit(:wine_name, :color, :grape, :avg_price, :acidity, :sweetness, :user_id, food_ids:[],\
    #     foods_attributes: [:id, :food_name, :food_sweetness, :food_acidity], pairing_ids:[], pairings_attributes: [:id, :pairing_type])
end