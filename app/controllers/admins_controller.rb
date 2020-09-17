class AdminsController < ApplicationController

    def home 
    end 

    def new 
        @admin = Admin.new 
    end 
   
    def create
      @admin = Admin.new(admin_params)
        if @admin.valid?
          @admin.save
          session[:admin_id] = @admin.id
          redirect_to admin_profile_path(@admin)
        else
          render "new"
        end 
    end 
   
    def profile 
      if is_logged_in?
        if current_user_type != "User"
          @admin = current_user
          render "profile"
        else
          @user = current_user
          redirect_to user_profile_path(@user)
        end
      else
        redirect_to '/'
      end
    end 
   
    def login
      @admin = Admin.new 
    end 
   
    def signin
      @admin = Admin.find_by(email: params[:admin][:email])
        if @admin && @admin.authenticate(params[:admin][:password])
          session[:admin_id] = @admin.id
          redirect_to admin_profile_path(@admin)
        else 
          redirect_to admin_login_path 
        end 
    end 
   
    private 
      def admin_params
        params.require(:admin).permit(:name, :email, :password, :password_confirmation)
      end 
end
