class ApplicationController < ActionController::Base
    helper_method :current_user 

    def home 
    end 

    def welcome
    end 

    def current_user
        @user = User.find_by_id(session[:user_id])
    end 

    def is_logged_in?
        !!session[:user_id]
    end 

    def logout 
        session.clear
        redirect_to root_path 
    end 
end
