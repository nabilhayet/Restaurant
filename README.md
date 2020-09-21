# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



1.Project title : The name of this project is Restaurant. This project lets a user or an admin to sign-up and log-in. After logged in, a user can make a booking on a particular date at a fixed time by selecting an existing cafe in the system. An admin can also log into the system and view the existing cafes. Adding or deleting a cafe or a food item option is available to the admin.

2.Motivation : This project was created to provide a platform which will allow both user and admin to perform any task on a common platform. Instead of creating two separate application for both, I decided to build something that would connect the both classes.

3.Tech/framework used Built with 1.Ruby on Rails 2.HTML 3.CSS 4.SQL

Features --A user can sign-up. --A user can log-in. --A user can make a booking. --Display details of the booking for a particular user. --Display a single booking of a user. --Update a booking for a particular user. --Delete a booking for a particular user. --An admin can sign-up. --An admin can log-in. --Display details of the cafe for a particular admin. --Display a single cafe. --Update a cafe for a particular admin. --Delete a cafe for a particular admin. --Display details of the food for a particular admin. --Display a single food item. --Update a food for a particular admin. --Delete a food for a particular admin.

Code Example For this project, activerecord, sqlite3, rake, bcrypt, omniauth-github, omniauth, dotenv-rails, omniauth-facebook, thin gems were used.

Code Snippet :

def login
        @user = User.new 
    end 

    def signin
        @user = User.find_by(email: params[:user][:email])
            if @user && @user.authenticate(params[:user][:password])
                session[:user_id] = @user.id
                redirect_to user_profile_path
            else 
                redirect_to user_login_path 
            end 
    end 

def new 
      if is_logged_in?
        @user = current_user 
        @booking = @user.bookings.build
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

Installation -- https://github.com/nabilhayet/Restaurant.git

Reference
-- https://learn.co/tracks/online-software-engineering-structured/rails/crud-with-rails/rails-generators -- https://learn.co/tracks/online-software-engineering-structured/rails/validations-and-forms/validations-with-form_for -- https://learn.co/tracks/online-software-engineering-structured/rails/associations-and-rails/basic-nested-forms-lab -- https://learn.co/tracks/online-software-engineering-structured/rails/routes-and-resources/routing-and-nested-resources -- https://learn.co/tracks/online-software-engineering-structured/rails/auth/sessions-controller.

Tests -- Type 'rails s' -- To sign-up as user click on User link. -- To sign-up as an admin click on Admin link. -- To go to the index view of all the bookings from profile page of a user click on 'view all bookings'. -- To update a booking click on 'update' in the index view of all the bookings. -- To delete any particular booking click on 'delete' in the index view of all the bookings.

Credits -- https://learn.co/tracks/online-software-engineering-structured/rails/auth/omniauth