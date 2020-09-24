class BookingsController < ApplicationController

    def index
      if is_logged_in?
        if params[:user_id]
          @user = User.find_by(id: params[:user_id])
          if @user.nil?
            redirect_to user_profile_path(@user), alert: "User not found."
          else 
            if @user != current_user
               redirect_to user_profile_path(current_user)
            else 
                @bookings = current_user.bookings
                filtering_with_date_or_table_num
            end 
          end 
        else
          @bookings = current_user.bookings 
          filtering_with_date_or_table_num
        end
      else 
          redirect_to user_login_path 
      end 
    end

    def show 
      if is_logged_in?
        @user = current_user
        @booking = Booking.find_by(params[:id])
        if @booking.user != @user 
            redirect_to user_profile_path(@user)
        end 
      else 
        redirect_to user_login_path 
      end 
    end 

    def new 
      if is_logged_in?
        if params[:user_id]
          @user = User.find_by(id: params[:user_id])
          if @user.nil?
            redirect_to user_profile_path(current_user), alert: "User not found."
          else 
            if @user != current_user
               redirect_to user_profile_path(current_user)
            else 
              @user = current_user
              @booking = @user.bookings.build
            end 
          end 
        else 
          user_profile_path(current_user)
        end 
      else 
        redirect_to user_login_path 
      end 
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
      if is_logged_in?
        if params[:user_id]
          @user = User.find_by(id: params[:user_id])
          if @user.nil?
            redirect_to user_profile_path(current_user), alert: "User not found."
          else
            @booking = @user.bookings.find_by(id: params[:id])
            redirect_to user_bookings_path(@user), alert: "Booking not found." if @booking.nil?
          end
        else
          @user = current_user
          @booking = Booking.find(params[:id])
            if @booking.user != @user 
              redirect_to user_profile_path(@user)
            end 
        end
      else 
        redirect_to user_login_path 
      end 
    end

      def update
        @user = current_user 
        @booking = Booking.find(params[:id])
        @booking.update(booking_params)
        redirect_to user_booking_path(@user,@booking)
      end

    def destroy 
      if is_logged_in?
        if params[:user_id]
          @user = User.find_by(id: params[:user_id])
          if @user.nil?
            redirect_to user_profile_path(current_user), alert: "User not found."
          else
            @booking = @user.bookings.find_by(id: params[:id])
            if @booking.nil?
              redirect_to user_bookings_path(@user), alert: "Booking not found."
            else 
              @booking.delete
              redirect_to user_bookings_path(@user)
            end 
          end 
        else
          @user = current_user
          @booking = Booking.find(params[:id])
            if @booking.user != @user 
              redirect_to user_profile_path(@user)
            else 
              @booking.delete
              redirect_to user_bookings_path(@user)
            end 
        end 
     else 
        redirect_to user_login_path
      end 
    end 

  private

  def booking_params
    params.require(:booking).permit(:cafe_id, :user_id, :date, :time, :table_num)
  end

  def filtering_with_date_or_table_num
    if !params[:date].blank?
      @bookings = current_user.bookings.with_date
    elsif !params[:table_num].blank?
      @bookings = current_user.bookings.with_table_num
    else 
      @bookings = current_user.bookings
    end 
  end 
end
