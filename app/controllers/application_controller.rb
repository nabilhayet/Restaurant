class ApplicationController < ActionController::Base
    helper_method :current_user 

    # OmniAuth.config.on_failure = Proc.new do |env|
    #     UsersController.action(:omniauth_failure).call(env)
    #     #this will invoke the omniauth_failure action in UsersController.
    # end

    def home 
    end 

    def welcome
    end 

    def current_user
        if session.key?("user_id")
            @user = User.find_by_id(session[:user_id])
        else 
            @admin = Admin.find_by_id(session[:admin_id])
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
