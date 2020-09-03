class BookingsController < ApplicationController

    def index
        if params[:user_id]
          @user = current_user
          @bookings = User.find(params[:user_id]).bookings
        else
          @bookings = Booking.all
        end
      end

    def show 
        @user = current_user
        @booking = Booking.find_by(params[:id])
    end 

    def new 
     @user = current_user 
    #  @booking = Booking.new(user_id: params[:user_id])
     @booking = @user.bookings.build

    end 

    def create
        @user = current_user 
        @booking = Booking.new(booking_params)
        if @booking.save
          redirect_to user_booking_path(@user, @booking)
        else
          render :new
        end
    end

    def edit
        if params[:user_id]
          @user = User.find_by(id: params[:user_id])
          if @user.nil?
            redirect_to user_path, alert: "User not found."
          else
            @booking = @user.bookings.find_by(id: params[:id])
            redirect_to user_bookings_path(user), alert: "Booking not found." if @booking.nil?
          end
        else
          @booking = Booking.find(params[:id])
        end
      end

      def update
        @user = current_user 
        @booking = Booking.find(params[:id])
        @booking.update(booking_params)
        redirect_to user_booking_path(@user,@booking)
      end

    def destroy 
     @user = current_user 
     @booking = Booking.find(params[:id])
     @booking.delete
     redirect_to user_bookings_path(@user)

    end 

    private

  def booking_params
    params.require(:booking).permit(:cafe_id, :user_id, :date, :time, :table_num)
  end
end
