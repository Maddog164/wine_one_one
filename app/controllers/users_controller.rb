require './config/environment'
require "./app/models/user"

class UsersController < ApplicationController

    def create
        binding.pry
        User.create(user_params)
    end

    private

    def user_params
        params.require(:user).permit(:user_name, :password, :password_confirmation)
    end
end
