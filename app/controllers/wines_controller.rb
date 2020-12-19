require './config/environment'
require "./app/models/wine"

class WinesController < ApplicationController

    def index
        @wines = Wine.where(:user_id => current_user.id)
        binding.pry
        # redirect_to 'index'
    end

    def new
        @wine = Wine.new
        @wine.user_id = current_user.id
    end

    def show
        binding.pry
        @wine = Wine.find(params[:id])
    end

    def create
        @wine = Wine.new(wine_params)
        # @wine.user_id = current_user.id
        if @wine.save
            binding.pry
            redirect_to @wine
        else
            binding.pry
            redirect_to controller: 'wines', action: 'index'
        end
    end

    # def pairings_index
    #     @wine = Wine.find(params[:id])
    #     @pairings = @wine.pairings
    #     render template: 'pairings/index'
    # end

    # def pairing
    #     @wine = Wine.find(params[:id])
    #     @pairing = @wine.pairings.find(params[:wine_id])
    #     render template: 'pairings/show'
    # end'


    private

    def wine_params
        params.require(:wine).permit(:wine_name, :color, :grape, :avg_price, :acidity, :sweetness, :user_id)
    end

end
