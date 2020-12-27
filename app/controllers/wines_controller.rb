require './config/environment'
require "./app/models/wine"

class WinesController < ApplicationController

    def index
        # binding.pry
        @wines = Wine.where(:user_id => current_user.id)
        # binding.pry
        # redirect_to 'index'
    end

    def new
        # binding.pry
        @wine = Wine.new
        @wine.user_id = current_user.id
        # binding.pry
    end

    def show
        # binding.pry
        @wine = Wine.find(params[:id])
    end

    def create
        # binding.pry
        @wine = Wine.new(wine_params)
        # @wine.user_id = current_user.id
        if @wine.save
            # binding.pry
            redirect_to @wine
        else
            # binding.pry
            redirect_to controller: 'wines', action: 'index'
        end
    end

    # def parings_index
    #     if params[:wine-id]
    #         @pairings = Wine.find(params[:wine_id]).pairings
    #     else
    #         @pairings = Pairing.all
    #     end
    # end

    private

    def wine_params
        params.require(:wine).permit(:wine_name, :color, :grape, :avg_price, :acidity, :sweetness, :user_id, food_ids: [])
    end

end
