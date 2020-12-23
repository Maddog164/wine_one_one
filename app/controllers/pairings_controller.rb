require './config/environment'
require "./app/models/wine"

class WinesController < ApplicationController

    
    
    def index
        if params[:wine_id]
            @pairings = Wine.find(params[:wine_id]).pairings
            @wine = Wine.find(params[:wine_id])
        else
            @pairings = Pairing.all
        end
    end

    def create
        Pairing.create(pairing_params)
    end

    def show
        @pairing = Pairing.find(params[:id])
    end

    private

    def pairing_params
        params.require(:pairing).permit(:wine, wine_ids: [], :food, food_ids: [])
    end

end