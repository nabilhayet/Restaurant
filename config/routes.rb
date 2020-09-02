Rails.application.routes.draw do
  
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'users#login'
  post '/login' => 'users#signin'
  root 'application#home'

  resources :bookings
  resources :cafes
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
