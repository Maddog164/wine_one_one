require './config/environment'
require "./app/models/wine"

class WinesController < ApplicationController

    def show
        binding.pry
        @wine = Wine.find(params[:id])
    end
end
