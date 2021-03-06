Rails.application.routes.draw do
  root "static_pages#home"
  
  resources :carts, only: [:create, :new, :update, :destroy]
  resources :orders, only: [:new, :create, :index, :edit, :update]
  resources :products
  
  namespace :admin do
    resources :orders, only: [:index, :edit, :update]
    resources :products
    
    root "static_pages#dashboard"
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
