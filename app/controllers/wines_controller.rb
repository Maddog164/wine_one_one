require './config/environment'
require "./app/models/wine"

class WinesController < ApplicationController
    before_action :require_login

    def index
        if !params[:wine_name]
            @wines = current_user.wines
        else
            @wines = Wine.short_wines(params[:wine_name])
        end
    end

    
    def new
        @wine = Wine.new
        @wine.user_id = current_user.id
    end

    def show
        if Wine.find(params[:id]).user_id != current_user.id
            redirect_to root_path
        else
            @wine = Wine.find(params[:id])
        end
    end

    def create
        @wine = Wine.new(wine_params)
        if @wine.save
            redirect_to @wine, notice: "Successfully created Wine"
        else
            render :new
        end
    end

    def update
        @wine = Wine.find(params[:id])
        if !Pairing.find_by(wine_id: params[:id]).blank? && @wine.food_exists?(wine_params[:pairings_attributes]["0"][:food_attributes]["food_name"])
            #wine and food pairing already exists
            redirect_to @wine, notice: "Pairing already exists"
        else
            @wine.update(wine_params)
            #wine and food pairing doesn't exists, so need to create pairing
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
