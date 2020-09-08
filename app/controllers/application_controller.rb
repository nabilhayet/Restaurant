class ApplicationController < ActionController::Base
    helper_method :current_user 

    def home 
    end 

    def welcome
    end 

    def current_user
        if session.key?("user_id")
            @user = User.find_by_id(session[:user_id])
            @user 
        else 
            @admin = Admin.find_by_id(session[:admin_id])
            @admin 
        end 
    end 

    def current_user_type
        current_user.class.name
    end

    def is_logged_in?
        if session.key?("user_id")
            !!session[:user_id]
        else 
            !!session[:admin_id]
        end 
    end 

    def logout 
        session.clear
        redirect_to root_path 
    end 
end
