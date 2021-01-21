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
        @wine = Wine.find(params[:wine_id])
        @pairings = @wine.pairings.build
    end

    def create
        @pairing = Pairing.create(pairing_params)
        if @pairing.valid?
            redirect_to @pairing, notice: "Created a New Pairing"
        else
            render :new
        end
    end

    def update
        @pairing = Pairing.find(params[:id])
        @pairing.update(pairing_params)
        @food = Food.find(@pairing.food_id)
        redirect_to wine_food_path(@food, @food.id)
    end

    def show
        @pairing = Pairing.find(params[:id])
    end

    private

    def pairing_params
        params.require(:pairing).permit(:pairing_type, :id, :wine_id, food_ids: [], foods_attributes: [:id, :food_name, :food_sweetness, :food_acidity])

    end

end