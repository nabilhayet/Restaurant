Rails.application.routes.draw do
  
  get '/user/signup' => 'users#new'
  post '/user/signup' => 'users#create'
  get '/user/login' => 'users#login'
  post '/user/login' => 'users#signin'
  get '/users/:id' => 'users#profile', as: 'user_profile'
  get '/logout' => 'application#logout'

  get '/admin/signup' => 'admins#new'
  post '/admin/signup' => 'admins#create'
  get '/admin/login' => 'admins#login'
  post '/admin/login' => 'admins#signin'
  get '/admins/:id' => 'admins#profile', as: 'admin_profile'


  get '/user/home' => 'users#home'
  get '/admin/home' => 'admins#home'
  get '/auth/facebook/callback' => 'users#github'
  root 'application#welcome'

  resources :admins, only: [:show] do 
    resources :cafes, only: [:index, :show, :new, :create, :update, :edit, :destroy]
  end 

  resources :admins, only: [:show] do
    resources :foods, only: [:index, :show, :new, :create, :update, :edit, :destroy]
  end 

    resources :users, only: [:show] do 
      resources :bookings, only: [:index, :show, :new, :create, :update, :edit, :destroy]
    end 

    resources :cafes, only: [:show] do 
      resources :cafes_food, only: [:index, :show, :new, :create, :update, :edit, :destroy]
    end 

  resources :bookings, only: [:index, :show]
  resources :cafes, only: [:index, :show]
  # resources :cafes_food, only: [:index, :show]
  resources :foods, only: [:index, :show]
  resources :cafes_food, only: [:index, :show]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
