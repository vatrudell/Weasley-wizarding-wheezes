Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :items, only: [:index]
  resources :carts, only: [:create]
  put '/cart', to: "carts#update"
  get '/cart', to: 'carts#show'
  root 'items#index'
end
