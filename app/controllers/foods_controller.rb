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
        binding.pry
        @food = Food.find(params[:id])
    end
  
    def new
        binding.pry
        if params[:wine_id] && !Wine.exists?(params[:wine_id])
            redirect_to wines_path, alert: "Wine not found"
        else
            # @food = Food.new
            @wine = Wine.find(params[:wine_id])
            # @food = Food.new(wine_id: params[:wine_id])
            @pairings = @wine.pairings.build
        end
        binding.pry
    end

    def create
        binding.pry
        @food = Food.create(food_params)
        # @wine = Wine.find(params[:wine_id])
        # @pairing = @food.pairings.build
        # @pairing.wine_id = @wine.id
        # @pairing.pairing_type = params[:pairings][:pairing_type]
        # @pairing.save
        binding.pry
        if @food.save
            binding.pry
            redirect_to wine_foods_path, notice: "Successfully created Pairing"
        else
            # binding.pry
            render :new
        end
    end

    def update
        binding.pry
        @food = Food.find(params[:id])
        @food.update(food_params)
        redirect_to_food_path(@food)
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

    # def food_params
    #     params.require(:wine).permit(:id, :wine_name, :color, :grape, :avg_price, :acidity, :sweetness, :user_id, food_ids:[],\
    #     foods_attributes: [:id, :food_name, :food_acidity, :food_sweetness], pairings_attributes: [:id, :pairing_type])
    # end

end
