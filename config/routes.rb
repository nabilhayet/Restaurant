Rails.application.routes.draw do
  
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'users#login'
  post '/login' => 'users#signin'
  get '/logout' => 'application#logout'
  root 'application#home'

  resources :users, only: [:show] do 
    resources :bookings, only: [:index, :show, :new, :create, :update, :edit, :destroy]
  end 
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
