class FoodsController < ApplicationController

    def index 
        if is_logged_in? 
              @admin = current_user
              @cafe = Cafe.find_by_id(params[:cafe_id])
              @foods = @cafe.foods 
            
        else 
            redirect_to root_path 
        end 
    end

    def show
        @admin = current_user 
        @cafe = Cafe.find_by_id(params[:cafe_id])
        @food = Food.find_by_id(params[:id])
    end 

    def new 
        if is_logged_in?
            @admin = current_user 
            @cafe = Cafe.find_by_id(params[:cafe_id])
            @food = @cafe.foods.build
        else 
            redirect_to login_path 
        end 
    end 

    def create
        if is_logged_in?
            @admin = current_user 
            @cafe = Cafe.find_by_id(params[:cafe_id])
            @food = Food.new(food_params)
            if @food.save
                redirect_to cafe_food_path(@cafe,@food)
            else
                render :new
            end
        end
    end 


    def edit

    end 

    def update

    end 

    def destroy 

    end 

    private

  def food_params
    params.require(:food).permit(:cafe_ids, :name, :category, :price, :fat, :calories)
  end
end
