require './config/environment'
require "./app/models/wine"

class WinesController < ApplicationController

    def index
        @wines = Wine.where(:user_id => current_user.id)
               
    end

    
    def new
        @wine = Wine.new
        @wine.user_id = current_user.id
        @pairings = @wine.pairings.build
             
    end

    def show
        @wine = Wine.find(params[:id])
    end

#wines/id/foods/id - details about the food, as well as the pairing type (optional: all the other wines that are also paired with it)
#wines/id - hyper link list of foods that are paired with it, no details


    def create
        binding.pry
        if !Wine.find_by(wine_name: wine_params[:wine_name])
            binding.pry
            @wine = Wine.new(wine_params)
        else
            @wine = Wine.find_by(wine_name: wine_params[:wine_name])
        end
        @wine = Wine.new(wine_params)
        if @wine.save
           redirect_to @wine, notice: "Successfully created Wine"
        else
            render :new
        end
    end

    def update
        binding.pry
        @wine = Wine.find_by(params[:id])
        if !Pairing.find_by(wine_id: params[:id]).blank? && !@wine.foods.where(food_name: wine_params[:foods_attributes]["0"]["food_name"]).blank?
            #wine and food pairing already exists
            @food = Food.find_by(food_name: wine_params[:foods_attributes]["0"]["food_name"])
            render :action => :show, :alert => "Pairing already exists"
        else
            binding.pry
            @wine.update(wine_params) #wine and food pairing doesn't exists, so need to create pairing
             # @food = Food.find(params[:food_id])
            @food = Food.find_by(food_name: wine_params[:foods_attributes]["0"]["food_name"])
            @pairing = Pairing.where(wine_id: params[:id],food_id: @food.id)
            @pairing[0].pairing_type = wine_params[:pairings_attributes]["0"]["pairing_type"]
            @pairing = @pairing[0].save
            
            render :action => :show, :alert => "Pairing created"
        end
    end

    private

    def wine_params
        params.require(:wine).permit(:id, :wine_name, :color, :grape, :avg_price, :acidity, :sweetness, :user_id, food_ids:[],\
        foods_attributes: [:id, :food_name, :food_acidity, :food_sweetness], pairings_attributes: [:pairing_type])
    end

end
