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
                   redirect_to admin_path(@admin)
               else
                   render "new"
               end 
       end 
   
       def show
           @admin = Admin.find_by(params[:id])
       end 
   
       def login
           @admin = Admin.new 
       end 
   
       def signin
         @admin = Admin.find_by(email: params[:admin][:email])
          if @admin && @admin.authenticate(params[:admin][:password])
           session[:admin_id] = @admin.id
           render "show"
         else 
           redirect_to admin_login_path 
         end 
       end 
   
       private 
       def admin_params
           params.require(:admin).permit(:name, :email, :password, :password_confirmation)
       end 
end
