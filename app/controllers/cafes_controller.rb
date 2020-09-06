class CafesController < ApplicationController

    def index 
        @cafes = Cafe.all 
    end 

    def show 
        @cafe = Cafe.find_by(params[:id])
    end 

    def new 
        if is_logged_in?
            @admin = current_user 
            @cafe = @admin.cafes.build
          else 
            redirect_to login_path 
          end 
    end 

    def create 
          @admin = current_user 
          @cafe = Cafe.new(cafe_params)
          if @cafe.save
            redirect_to cafe_path(@cafe)
          else
            render :new
          end
    end 

    def edit 

    end 

    def update 

    end 

    def destroy 

    end 
    private

  def cafe_params
    params.require(:cafe).permit(:name, :street, :city, :state, :zipcode)
  end
end
