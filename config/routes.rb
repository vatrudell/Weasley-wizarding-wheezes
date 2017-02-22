Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'items#index'
  resources :items, only: [:index, :show]


  resources :carts, only: [:create]
  get '/cart', to: 'carts#show'
  get '/:name', to: 'categories#show', as: 'category'
end
