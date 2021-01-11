class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session

    before_action :current_user

    # helper_method :current_user, :logged_in?

    def current_user
        @user = (User.find_by(id: session[:user_id]) || User.new)
        # binding.pry
    end

    def logged_in?
        # binding.pry
        current_user.id != nil
    end

    def require_logged_in
        return redirect_to(controller: 'sessions', action: 'new') unless logged_in?
    end

    

    
end
