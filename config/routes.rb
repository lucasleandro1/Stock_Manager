Rails.application.routes.draw do
  root to: "home#index"

  devise_for :users
  resources :products
  resources :categories
  resources :stock_movements do
    member do
      delete "remove_file/:arquivo_id", to: "stock_movements#remove_file", as: "remove_file"
    end
  end
  resources :customers
end
