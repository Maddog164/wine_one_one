require './config/environment'
require "./app/models/wine"

class WinesController < ApplicationController

    def index
        # binding.pry
        @wines = Wine.where(:user_id => current_user.id)
        
    end

    def new
        # binding.pry
        @wine = Wine.new
        @wine.user_id = current_user.id
        @pairings = @wine.pairings.build
        # @food = @pairings.build_food
        
        binding.pry
        
    end

    def show
        # binding.pry
        @wine = Wine.find(params[:id])
    end

    def create
        binding.pry
        @wine = Wine.new(wine_params)
               
        binding.pry
        # @wine.user_id = current_user.id
        if @wine.save
            # binding.pry
            p = Pairing.last
            p.pairing_type = wine_params[:pairings_attributes]["0"][:pairing_type]
            p.save
            redirect_to @wine, notice: "Successfully created Wine"
        else
            # binding.pry
            render :new
        end
    end

    private

    def wine_params
        params.require(:wine).permit(:id, :wine_name, :color, :grape, :avg_price, :acidity, :sweetness, :user_id, food_ids:[],\
        foods_attributes: [:id, :food_name, :food_acidity, :food_sweetness], pairings_attributes: [:id, :pairing_type])
    end

end
