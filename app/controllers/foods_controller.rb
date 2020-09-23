class FoodsController < ApplicationController

    def index
        if is_logged_in?
          @admin = current_user
          if params[:admin_id]
            @foods = Admin.find(params[:admin_id]).foods 
          else
            @foods = @admin.foods 
          end
        else 
            redirect_to admin_login_path 
        end 
      end
  
      def show 
        if is_logged_in?
          @admin = current_user
          @food = Food.find_by(params[:id])
          if @food.admin.id != @admin.id 
              redirect_to admin_profile_path(@admin)
          end 
        else 
          redirect_to admin_login_path 
        end 
      end 
  
      def new 
        if is_logged_in?
          @admin = current_user 
          @food = @admin.foods.build
        else 
          redirect_to admin_login_path 
        end 
      end 
  
      def create
          @admin = current_user 
          @food = Food.new(food_params)
          if @food.save
            redirect_to admin_food_path(@admin, @food)
          else
            render :new
          end
      end
  
      def edit
        if is_logged_in?
          if params[:admin_id]
            @admin = Admin.find_by(id: params[:admin_id])
            if @admin.nil?
              redirect_to admin_profile_path(@admin), alert: "Admin not found."
            else
              @food = @admin.foods.find_by(id: params[:id])
              redirect_to admin_foods_path(@admin), alert: "Food not found." if @food.nil?
            end
          else
            @admin = current_user
            @food = Food.find(params[:id])
              if @food.admin != @admin
                redirect_to admin_profile_path(@admin)
              end 
          end
        else 
          redirect_to admin_login_path 
        end 
      end
  
        def update
          @admin = current_user 
          @food = Food.find(params[:id])
          @food.update(food_params)
          redirect_to admin_food_path(@admin, @food)
        end
  
      def destroy 
        if is_logged_in?
          @admin = current_user 
          @food = Food.find(params[:id])
          @food.delete
          redirect_to admin_foods_path(@admin)
        else 
          redirect_to admin_login_path
        end 
      end 
  
   private

    def food_params
        params.require(:food).permit(:name, :category, :fat, :calories, :admin_id)
    end
end
