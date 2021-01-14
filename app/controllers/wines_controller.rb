require './config/environment'
require "./app/models/wine"

class WinesController < ApplicationController

    def index
        @wines = Wine.where(:user_id => current_user.id)
        # render template: 'foods/index'
        
    end

    
    def new
        # binding.pry
        @wine = Wine.new
        @wine.user_id = current_user.id
        @pairings = @wine.pairings.build
        # @food = @pairings.build_food
        
    end

    def show
        # binding.pry
        @wine = Wine.find(params[:id])
    end

    def create
        binding.pry
        @wine = Wine.new(wine_params)
        
        # @wine.update_attributes(wine_params)       
        binding.pry
        # @wine.user_id = current_user.id
        if @wine.save
            pairing = Pairing(wine_id: @wine.id, food_id: wine_params())
            # p = Pairing.where(:wine_=@wine.id, :food_id = wine_params)
            # binding.pry
            # p = Pairing.last
            # p.pairing_type = wine_params[:pairings_attributes]["0"][:pairing_type]
            # p.save
            redirect_to @wine, notice: "Successfully created Wine"
        else
            # binding.pry
            render :new
        end
    end

    def update
        binding.pry
        @wine = Wine.find(params[:id])
        @wine.update(wine_params)
        @food = Food.find(params[:food_id])
        # redirect_to wine_food_path(wine_params[:foods_attributes][:])
        render template: 'foods/show'
    end

    private

    def wine_params
        params.require(:wine).permit(:id, :wine_name, :color, :grape, :avg_price, :acidity, :sweetness, :user_id, food_ids:[],\
        foods_attributes: [:id, :food_name, :food_acidity, :food_sweetness], pairing_ids:[], pairings_attributes: [:pairing_type])
    end

end
