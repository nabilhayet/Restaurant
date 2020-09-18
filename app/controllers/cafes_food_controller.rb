class CafesFoodController < ApplicationController


    def index
        if is_logged_in?
          @admin = current_user
          if params[:cafe_id]
            @cafes_food = Cafe.find(params[:cafe_id]).cafe_foods
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
            # @cafe = Cafe.find_by_id(params[:cafe_id])
            @cafe_food = CafeFood.find_by(params[:id])
            if @cafe_food != nil 
                @cafe_food_cafe_id = @cafe_food.cafe_id 
                    if !@admin.cafe_ids.include?(@cafe_food_cafe_id)
                        redirect_to admin_profile_path
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

    def edit
        if is_logged_in?
          if params[:cafe_id]
            @cafe = Cafe.find_by(id: params[:cafe_id])
            if @cafe.nil?
              redirect_to admin_profile_path, alert: "Cafe not found."
            else
              @cafes_food = @cafe.cafe_foods.find_by(id: params[:id])
              redirect_to cafe_cafes_food_index_path(@cafe), alert: "Cafe Food not found." if @cafes_food.nil?
            end
          else
            @admin = current_user
            @cafes_food = CafeFood.find_by_id(params[:id])
              if !@admin.cafe_ids.include?(@cafes_food.cafe_id)
                redirect_to admin_profile_path
              end 
          end
        else 
          redirect_to admin_login_path 
        end 
      end
  
        def update
          @admin = current_user 
          @cafes_food = CafeFood.find(params[:id])
          @cafes_food.update(cafe_food_params)
          redirect_to cafe_cafes_food_path(@cafes_food.cafe, @cafes_food)
        end
  
      def destroy 
        if is_logged_in?
          @admin = current_user 
          @cafe = Cafe.find_by(id: params[:cafe_id])
          @cafes_food = @cafe.cafe_foods.find_by(id: params[:id])
          @cafes_food.delete
          redirect_to cafe_cafes_food_index_path(@cafe)
        else 
          redirect_to admin_login_path
        end 
      end 
  

    private

  def cafe_food_params
    params.require(:cafe_food).permit(:cafe_id, :food_id, :price)
  end

end
