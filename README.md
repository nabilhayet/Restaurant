![GitHub Repo stars](https://img.shields.io/github/stars/nabilhayet/Restaurant) ![GitHub forks](https://img.shields.io/github/forks/nabilhayet/Restaurant) ![GitHub followers](https://img.shields.io/github/followers/nabilhayet) ![Bitbucket open issues](https://img.shields.io/bitbucket/issues/nabilhayet/Restaurant)                                          
                                                       Restaurant
                                                      
The name of this project is Restaurant. This project lets a user or an admin to sign-up and log-in. After logged in, a user can make a booking on a particular date at a fixed time by selecting an existing cafe in the system. An admin can also log into the system and view the existing cafes. Adding or deleting a cafe or a food item option is available to the admin.

<a href="https://www.youtube.com/watch?v=UWaRqHpO8fU&t=2s">Demo</a>
                               
## Features
* Sign in/Sign up option for users and admins
* Sign in/Sign up option via third party for users
* Full CRUD capabilities for userss such as
* Make a new reservation
* View all existing reservations on this application
* Edit/Delete only the reservations make by the logged in user
* Full CRUD capabilities for admins such as
* Add a new restaurant
* View all existing restaurants on this application
* Edit/Delete only the restaurants added by the logged in admin

## Tech Stack
This web app makes use of the following:

* Ruby [2.6.1]
* Rails [~> 6.0.2] - MVC Web Framework
* SQLite3 [~> 1.4] - Database
* Bulma-Rails [~> 0.8.0] - Integrates Bulma with the rails asset pipeline, a modern CSS framework based on Flexbox.
* BCrypt [~> 3.1.7] - Gem for encryption

## Installing
* Clone this repo to your local machine git clone <this-repo-url>
* run bundle install to install required dependencies
* run rails db:create to create a database locally.
* run rails db:migrate to create tables into the database.
* run rails db:seed to create seed data.
* run rails s to run the server.
        
## Challenges
* Signing up via third party for the user was not working in the beginning with github.So i switched from github to facebook for omni-auth.
* Making sure to prevent a user from accessing other user's info took some time.
* Following restful routes pattern for nested routes was not easy.
* Create a connection between restaurant and food felt like a mountain to climb.

## Future Implementation
* Adding nested form to make our app more efficient
* Redesign database to make tables more standard
* Insert images while adding new food

Code Example For this project, activerecord, sqlite3, rake, bcrypt, omniauth-github, omniauth, dotenv-rails, omniauth-facebook, thin gems were used.

## Code Snippet

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



