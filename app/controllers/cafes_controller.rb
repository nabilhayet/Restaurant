class CafesController < ApplicationController

    def index 
        if is_logged_in?
            if params[:admin_id]
              @admin = current_user
              @cafes = Admin.find(params[:admin_id]).cafes
            else
              @cafes = Cafe.all
            end
        else 
            redirect_to signin_path 
        end 
    end

    def show 
        if is_logged_in?
            @admin = current_user
            @cafe = Cafe.find_by(params[:id])
        else 
            redirect_to signin_path 
        end 
       
    end 

    def new 
        if is_logged_in?
            @admin = current_user 
            @cafe = @admin.cafes.build
        else 
            redirect_to signin_path 
        end 
    end 

    def create 
        @admin = current_user 
        @cafe = Cafe.new(cafe_params)
        if @cafe.save
          redirect_to admin_cafe_path(@admin, @cafe)
        else
          render :new
        end
    end 

    def edit
        if is_logged_in?
          if params[:admin_id]
            @admin = Admin.find_by(id: params[:admin_id])
            if @admin.nil?
              redirect_to admin_path, alert: "Admin not found."
            else
              @cafe = @admin.cafes.find_by(id: params[:id])
              redirect_to admin_cafes_path(@admin), alert: "Cafe not found." if @cafe.nil?
            end
          else
            @cafe = Cafe.find(params[:id])
          end
        else 
          redirect_to signin_path 
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
    params.require(:cafe).permit(:name, :street, :city, :state, :zipcode, :admin_id)
  end
end
