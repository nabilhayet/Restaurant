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
            @food = Food.find_by(name: params[:food][:name])
            @cafe = Cafe.find_by_id(params[:food][:cafe_ids].last)
                @cafe_food = CafeFood.all.select do |cf|
                    (cf.cafe_id==@cafe.id && cf.food_id==@food.id)
                end 
            if @cafe_food.empty?
                render "new"
            else 
                @food = Food.new(food_params)
                    if @food.save
                        render "show"
                    else
                        render :new
                    end
            end 
        else 
            redirect_to login_path
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
