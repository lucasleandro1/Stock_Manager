Rails.application.routes.draw do
  root to: "home#index"

  devise_for :users
  resources :products
  resources :categories
  resources :stock_movements
end
