class CafesFoodController < ApplicationController


    def index
        if is_logged_in?
          @admin = current_user
          if params[:cafe_id]
            @cafe_foods = Cafe.find(params[:cafe_id]).cafe_foods
          else
            redirect_to admin_profile_path
          end
        else 
            redirect_to admin_login_path 
        end 
    end

    def show 
        if is_logged_in?
            @admin = current_user
            @cafe_food = CafeFood.find_by(params[:id])
            if @cafe_food != nil 
                @cafe_food_cafe_id = @cafe_food.cafe_id 
                    if !@admin.cafe_ids.include?(@cafe_food_cafe_id)
                        redirect_to user_profile_path
                    end
            else 
                redirect_to admin_profile_path
            end 
        else 
            redirect_to admin_login_path 
        end 
    end 

    def new 
        if is_logged_in?
            @admin = current_user 
            @cafe = Cafe.find_by_id(params[:cafe_id])
            @cf = @cafe.cafe_foods.build 
          else 
            redirect_to admin_login_path 
          end 
    end 


      def create
        @admin = current_user 
        @cafe = Cafe.find_by_id(params[:cafe_id])
        @cf = CafeFood.new(cafe_food_params)
            if @cf.save
                redirect_to cafe_cafes_food_path(@cafe, @cf)
            else
                render :new
            end
    end

    private

  def cafe_food_params
    params.require(:cafe_food).permit(:cafe_id, :food_id, :price)
  end

end
