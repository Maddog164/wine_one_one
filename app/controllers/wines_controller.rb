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
        # pairing = @wine.pairings.build
        # pairing.foods.build
        # @wine.pairings.build
        # binding.pry
    end

    def show
        # binding.pry
        @wine = Wine.find(params[:id])
    end

    def create
        binding.pry
        @wine = Wine.new(wine_params)
        # if wine_params[:foods_attributes]["0"] != nil && wine_params[:foods_attributes]["0"] != []
        #     food = @wine.foods.build(wine_params[:foods_attributes]["0"])
        #     food.save
        #     newfood = true

        # end
        # # if wine_params[:foods_attributes]["1"] != nil && wine_params[:foods_attributes]["1"] != []
        # #     @wine.foods.build(wine_params[:foods_attributes]["1"])
        # # end
        # if wine_params[:pairings_attributes]["0"] != nil && wine_params[:pairings_attributes]["0"] != []
        #     pairing = @wine.pairings.build(wine_params[:pairings_attributes]["0"])
        #     pairing.save
        # end
        # if wine_params[:pairings_attributes]["1"] != nil && wine_params[:pairings_attributes]["1"] != []
        #     pairing = @wine.pairings.build(wine_params[:pairings_attributes]["1"])
        #     pairing.save

        # end
        # if newfood
        #     new_pairing = pairing.food.build(food.id)
        #     new_pairing.save
        # end
        
        binding.pry
        # @wine.user_id = current_user.id
        if @wine.save
            # binding.pry
            redirect_to @wine, notice: "Successfully created Wine"
        else
            # binding.pry
            render :new
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
        params.require(:wine).permit(:wine_name, :color, :grape, :avg_price, :acidity, :sweetness, :user_id, food_ids:[],\
        foods_attributes: [:id, :food_name, :food_sweetness, :food_acidity], pairing_ids:[], pairings_attributes: [:id, :pairing_type])
    end

end
