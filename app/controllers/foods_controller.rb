class FoodsController < ApplicationController

    def index 
        if is_logged_in? 
              @admin = current_user
              @cafe = @admin.cafes.find_by_id(params[:cafe_id])
              @foods = @cafe.foods 
        else 
            redirect_to root_path 
        end 
    end

    def show
        @admin = current_user 
        @cafe = @admin.cafes.find_by_id(params[:cafe_id]) 
        @food = Food.find_by_id(params[:id])
    end 

    def new 
        if is_logged_in?
            @admin = current_user 
            @food = Food.new 
        else 
            redirect_to login_path 
        end 
    end 

    def create
        if is_logged_in?
            @admin = current_user 
            @food = Food.new(food_params)
                if @food.save
                    redirect_to food_path(@food)
                else
                    render :new
                end 
        else        
            redirect_to login_path
        end 
    end 

    def edit
        if current_user_type != "User"
            if is_logged_in?
               @admin = current_user
               @food = Food.find_by_id(params[:id])
                 if @apt!=nil && @apt.patient_id == @patient.id
                    @doctor = Doctor.all
                    erb :'appointments/patient/edit'
                 else
                   flash.next[:message] = "You have no appointment to update of this number"
                   redirect '/profile/patient'
                 end
             else
               redirect '/'
             end
           else
             redirect '/profile/doctor'
           end
    end 

    def update
        @admin = current_user 
        @food = Food.find(params[:id])
        @food.update(food_params)
        redirect_to redirect_to food_path(@food)
      end

    def destroy 
      @admin = current_user 
      @food = Food.find(params[:id])
      @food.delete
      redirect_to foods_path
      
    end 

    private

    def food_params
        params.require(:food).permit(:name, :category, :price, :fat, :calories)
    end
end
