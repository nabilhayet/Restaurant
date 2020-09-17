class CafesController < ApplicationController

    def index 
        if is_logged_in?
            if params[:admin_id]
              @admin = current_user
              @cafes = Admin.find(params[:admin_id]).cafes
            else
              @admin = current_user
              @cafes = @admin.cafes 
            end
        else 
          redirect_to admin_login_path 
        end 
    end

    def show 
      if is_logged_in?
        @admin = current_user
        @cafe = Cafe.find_by(params[:id])
          if @cafe.admin != @admin
            redirect_to admin_profile_path
          end 
      else 
        redirect_to admin_login_path 
      end 
    end 


    def new 
      if current_user_type != "User"
        if is_logged_in?
            @admin = current_user 
            @cafe = @admin.cafes.build 
        else 
            redirect_to admin_login_path
        end 
      else 
          redirect_to user_login_path
      end 
    end 

    def create 
        @admin = current_user 
        @cafe = Cafe.new(cafe_params)
        if @cafe.save
          render "show"
        else
          render "new"
        end
    end 

    def edit
        if is_logged_in?
          if params[:admin_id]
            @admin = Admin.find_by(id: params[:admin_id])
            if @admin.nil?
              redirect_to admin_login_path, alert: "Admin not found."
            else
              @cafe = @admin.cafes.find_by(id: params[:id])
              redirect_to admin_cafes_path(@admin), alert: "Cafe not found." if @cafe.nil?
            end
          else
            @admin = current_user
            @cafe = Cafe.find(params[:id])
            if @cafe.admin != @admin 
              redirect_to admin_profile_path
            end 
          end
        else 
          redirect_to admin_login_path
        end 
      end
  
        def update
          @admin = current_user 
          @cafe = Cafe.find(params[:id])
          @cafe.update(cafe_params)
          redirect_to admin_cafe_path(@admin,@cafe)
        end
  
      def destroy 
        @admin = current_user 
        @cafe = Cafe.find(params[:id])
        @cafe.delete
        redirect_to admin_cafes_path(@cafe)
      end 
  
    private

  def cafe_params
    params.require(:cafe).permit(:admin_id, :name, :street, :city, :state, :zipcode)
  end
end
