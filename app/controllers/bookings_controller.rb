class BookingsController < ApplicationController

    def index 

    end 

    def show 
        @booking = Booking.find_by(params[:id])
    end 

    def new 
     @booking = Booking.new(user_id: params[:user_id])
    end 

    def create
        @booking = Booking.new(booking_params)
        binding.pry
        if @booking.save
          redirect_to booking_path(@booking)
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

  def booking_params
    params.require(:booking).permit(:cafe_id, :user_id, :date, :time, :table_num)
  end
end
