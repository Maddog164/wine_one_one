require './config/environment'
require "./app/models/wine"

class WinesController < ApplicationController
    before_action :require_login

    def index
        @wines = Wine.where(:user_id => current_user.id)
    end

    
    def new
        @wine = Wine.new
        @wine.user_id = current_user.id
        @pairings = @wine.pairings.build
             
    end

    def show
        # binding.pry
        if Wine.find(params[:id]).user_id != current_user.id
            redirect_to root_path
        else
            @wine = Wine.find(params[:id])
        end
    end

    def create
        binding.pry
        @wine = Wine.new(wine_params)
        if @wine.save
            binding.pry
           redirect_to @wine, notice: "Successfully created Wine"
        else
            render :new
        end
    end

    def update
        
        @wine = Wine.find(params[:id])
        binding.pry
        if !Pairing.find_by(wine_id: params[:id]).blank? && !@wine.foods.where(food_name: wine_params[:foods_attributes]["0"]["food_name"]).blank?
            #wine and food pairing already exists
            @food = Food.where(food_name: wine_params[:foods_attributes]["0"]["food_name"])
            redirect_to @wine, notice: "Pairing already exists"
        else
           binding.pry
            @wine.update(wine_params)
            # binding.pry
            #wine and food pairing doesn't exists, so need to create pairing
            # @food = Food.where(food_name: wine_params[:foods_attributes]["0"]["food_name"])
            # @pairing = Pairing.find_by(wine_id: params[:id],food_id: @food[0].id)
            # @pairing[0].pairing_type = wine_params[:pairings_attributes]["0"]["pairing_type"]
            # @pairing = @pairing[0].save
            redirect_to @wine, notice: "Pairing created"
        end
    end

    def destroy
        Wine.find(params[:id]).destroy
        redirect_to wines_path
    end

    private

    def require_login
        return head(:forbidden) unless session.include? :user_id
    end

    def wine_params
        params.require(:wine).permit(:id, :wine_name, :color, :grape, :avg_price, :acidity, :sweetness, :user_id, 
        {pairings_attributes: [:pairing_type, [food_attributes: [:food_name, :food_acidity, :food_sweetness]]]})
    end

end
