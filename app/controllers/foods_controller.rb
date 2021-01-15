require './config/environment'
require "./app/models/food"

class FoodsController < ApplicationController

    
    def index
        if params[:wine_id]
            @foods = Wine.find(params[:wine_id]).foods
        else
            @foods = Food.all
        end
    end
    
    def show
        
        @food = Food.find(params[:id])
        @pairing = Pairing.where(food_id = params[:id]).last
    end
  
    def new
        
        if params[:wine_id] && !Wine.exists?(params[:wine_id])
            redirect_to wines_path, alert: "Wine not found"
        else
            @wine = Wine.find(params[:wine_id])
            @pairings = @wine.pairings.build
        end
        
    end

    def create
        
        @food = Food.create(food_params)
        
        binding.pry
        if @food.save
            binding.pry
            redirect_to wine_foods_path, notice: "Successfully created Pairing"
        else
            
            render :new
        end
    end

    def update
        binding.pry
        @food = Food.find(params[:id])
        @food.update(food_params)
        redirect_to_food_path(@food)
    end

    def change_pairing_type(id)
        
        pairing = Pairing.find(id)
        if pairing.pairing_type == "Congruent"
            pairing.pairing_type = "Contrasting"
        else
            pairing.pairirng_type = "Congruent"
        end
        pairing.save
       

    end

    def edit
        if params[:wine_id]
            wine = Wine.find_by(id:params[wine_id])
            if wine.nil?
                redirect_to wines_path, alert: "Wine not found"
            else
                @food = wine.foods.find_by(id: params[:id])
                redirect_to wine_foods_path(wine), alert: "Food not found" if @food.nil?
            end
        else
            @food = Food.find(params[:id])
        end
    end


    private

    def food_params
        params.require(:food).permit(:food_name, :food_sweetness, :food_acidity, :wine_id, pairing_ids:[], pairings_attributes: [:pairing_type])
    end

end
