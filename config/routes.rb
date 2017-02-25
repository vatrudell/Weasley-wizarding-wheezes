Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/internal_server_error'

  root 'items#index'
  resources :items, only: [:index, :show]

  resources :users, only: [:new, :index, :create]

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  namespace :admin do
    get "/dashboard", to: "orders#index"
  end
  get '/dashboard', to: "users#show"

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  resources :carts, only: [:create]
  put '/cart', to: "carts#update"
  get '/cart', to: 'carts#show'
  delete '/cart', to: 'carts#remove'
  get '/:name', to: 'categories#show', as: 'category'
end
