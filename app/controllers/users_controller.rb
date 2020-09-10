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
            redirect_to user_path(@user)
        else
            render "new"
        end 
    end 

    def show
        @user = User.find_by(params[:id])
    end 

    def login
        @user = User.new 
    end 

    def signin
        binding.pry 
        if auth.present? && auth.has_key?("uid")
            @user = User.find_or_create_by(uid: auth['uid']) do |u|
                u.name = auth['info']['name']
                u.email = auth['info']['email']
            end
           session[:user_id] = @user.id
           ender 'show'
        else 
            @user = User.find_by(email: params[:user][:email])
            if @user && @user.authenticate(params[:user][:password])
                    session[:user_id] = @user.id
                    render "show"
                else 
                    redirect_to user_login_path 
                end 
        end 
    end 

    private 

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :contact)
    end 

    def auth
        request.env['omniauth.auth']
    end
end
