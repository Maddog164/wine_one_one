class SessionsController < ApplicationController

    #logging user in, logging user out, omniauth

    def new
    end

    def omniauth #log users in with omniauth
        @user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
            u.user_name = auth['info']['first_name']
            u.email = auth['info']['email']
            u.password = SecureRandom.hex(16)
        end

          
        if @user.valid?
            session[:user_id] = @user.id
            redirect_to wines_path
        else
            flash[:message] = user.errors.full_messages.join(", ")
            redirect_to login_path 
        end
    end

    
    def create
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

    private

    def auth
        request.env['omniauth.auth']
    end

end