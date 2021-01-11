class SessionsController < ApplicationController

    #logging user in, logging user out, omniauth

    def new
        # binding.pry
    end

    def omniauth #log users in with omniauth
        @user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
            u.user_name = auth['info']['first_name']
            u.email = auth['info']['email']
            u.password = SecureRandom.hex(16)
        end# @user = User.create_from_omniauth(auth)

        binding.pry
        # session[:user_id] = user.id       
        if @user.valid?
            binding.pry
            session[:user_id] = @user.id
            redirect_to wines_path
        else
            binding.pry
            flash[:message] = user.errors.full_messages.join(", ")
            redirect_to login_path 
        end
    end

    
    def create
        binding.pry
        user = User.find_by(user_name: params[:user][:user_name])
        user = user.try(:authenticate, params[:user][:password])
        return redirect_to(controller: 'sessions', action: 'new') unless user
        binding.pry
        session[:user_id] = user.id
        @user = user
        binding.pry
        redirect_to controller: 'wines', action: 'index'
    end

    def destroy
        session.delete :user_id
        # reset_session
        # @current_user = nil
        redirect_to '/'
    end

    private

    def auth
        request.env['omniauth.auth']
    end

end