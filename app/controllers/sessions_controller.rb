class SessionsController < ApplicationController

    #logging user in, logging user out, omniauth

    def new
    end

    def omniauth #log users in with omniauth

    end

    def create
        # binding.pry
        user = User.find_by(user_name: params[:user][:user_name])
        user = user.try(:authenticate, params[:user][:password])
        return redirect_to(controller: 'sessions', action: 'new') unless user
        session[:user_id] = user.id
        @user = user
        redirect_to controller: 'wines', action: 'index'
    end

    def destroy
        session.delete :user_id
        redirect_to '/'
    end

end