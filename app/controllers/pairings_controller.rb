require './config/environment'
require "./app/models/wine"

class WinesController < ApplicationController

    def index
        if params[:wine_id]
            @pairings = Wine.find(params[:wine_id]).pairings
        else
            @pairings = Pairings.all
        end
    end

    def show
        @pairing = Pairing.find(params[:id])
    end


end