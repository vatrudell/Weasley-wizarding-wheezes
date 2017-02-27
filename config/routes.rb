Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/internal_server_error'

  root 'items#index'
  resources :items, only: [:index, :show]

  resources :orders, only: [:index, :show, :create]

  resources :users, except: [:show]

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  namespace :admin do
    get "/dashboard", to: "orders#index"
    put "/dashboard", to: "orders#sort_orders"

    resources :orders, only: [:show, :update]
    resources :items, only: [:index, :edit, :new, :create, :update]
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
