class CafesController < ApplicationController

    def index 
      if is_logged_in?
        if params[:admin_id]
          @admin = Admin.find_by(id: params[:admin_id])
          if @admin.nil?
            redirect_to admin_profile_path(@admin), alert: "Admin not found."
          else 
            if @admin != current_user
               redirect_to admin_profile_path(current_user)
            else 
                @cafes = current_user.cafes
            end 
          end 
        else
          @cafes = current_user.cafes
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
            redirect_to admin_profile_path(@admin)
          end 
      else 
        redirect_to admin_login_path 
      end 
    end 


    def new 
      if is_logged_in?
        if params[:admin_id]
          @admin = Admin.find_by(id: params[:admin_id])
          if @admin.nil?
            redirect_to admin_profile_path(current_user), alert: "Admin not found."
          else 
            if @admin != current_user
               redirect_to admin_profile_path(current_user)
            else 
              @admin = current_user
              @cafe = @admin.cafes.build 
            end 
          end 
        else 
          admin_profile_path(current_user)
        end 
      else 
        redirect_to admin_login_path 
      end 
    end

    def create 
        @admin = current_user 
        @cafe = Cafe.new(cafe_params)
        if @cafe.save
          redirect_to admin_cafe_path(@admin,@cafe)
        else
          render "new"
        end
    end 

    def edit
        if is_logged_in?
          if params[:admin_id]
            @admin = Admin.find_by(id: params[:admin_id])
            if @admin.nil?
              redirect_to admin_profile_path(current_user), alert: "Admin not found."
            else
              @cafe = @admin.cafes.find_by(id: params[:id])
              redirect_to admin_cafes_path(@admin), alert: "Cafe not found." if @cafe.nil?
            end
          else
            @admin = current_user
            @cafe = Cafe.find(params[:id])
            if @cafe.admin != @admin 
              redirect_to admin_profile_path(@admin)
            end 
          end
        else 
          redirect_to admin_login_path
        end 
      end
  
        def update
          @admin = current_user 
          @cafe = Cafe.find_by_id(params[:id])
          @cafe.update(cafe_params)
          redirect_to admin_cafe_path(@admin,@cafe)
        end
  
        def destroy 
          if is_logged_in?
            if params[:admin_id]
              @admin = Admin.find_by(id: params[:admin_id])
              if @admin.nil?
                redirect_to admin_profile_path(current_user), alert: "Admin not found."
              else
                @cafe = @admin.cafes.find_by(id: params[:id])
                if @cafe.nil?
                  redirect_to admin_cafes_path(@admin), alert: "Cafe not found."
                else 
                  @cafe.delete
                  redirect_to admin_cafes_path(@admin)
                end 
              end 
            else
              @admin = current_user
              @cafe = Cafe.find(params[:id])
                if @cafe.admin != @admin
                  redirect_to admin_profile_path(@admin)
                else 
                  @cafe.delete
                  redirect_to admin_cafes_path(@admin)
                end 
            end 
         else 
            redirect_to admin_login_path
          end 
        end 

    private

  def cafe_params
    params.require(:cafe).permit(:admin_id, :name, :street, :city, :state, :zipcode)
  end
end
