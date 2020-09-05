class UsersController < ApplicationController

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
      @user = User.find_by(email: params[:user][:email])
       if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        render "show"
      else 
        redirect_to login_path 
      end 
    end 

    private 
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :contact)
    end 
end
