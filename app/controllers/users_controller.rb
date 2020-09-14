class UsersController < ApplicationController

    def home 

    end 

    def new 
        @user = User.new 
    end 

    def create
       @user = User.new(user_params)
        if @user.valid?
            @user.save
            session[:user_id] = @user.id
            redirect_to user_profile_path 
        else
            render "new"
        end 
    end 

    def login
        @user = User.new 
    end 

    def signin
            @user = User.find_by(email: params[:user][:email])
                if @user && @user.authenticate(params[:user][:password])
                    session[:user_id] = @user.id
                    render "profile"
                else 
                    redirect_to user_login_path 
                end 
        
    end 

    def github
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
            
            u.name = auth['info']['name']
            u.email = auth['info']['email']
            u.password_digest = auth['info']['password']
        end
        session[:user_id] = @user.id
        binding.pry 
        render "profile"
    end 

    # def omniauth_failure
    #     redirect_to user_login_path
    #     #redirect wherever you want.
    # end

    def profile 
        if is_logged_in?
            if current_user_type != "Admin"
              @user = current_user
              binding.pry 
              render "profile"
            else
              @admin = current_user
              redirect_to admin_path(@admin)
            end
        else
            redirect_to '/'
        end
    end 

    

    

    private 

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :contact)
    end 

    def auth
        request.env['omniauth.auth']
    end
end
