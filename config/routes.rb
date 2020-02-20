Rails.application.routes.draw do
  resources :comments
  resources :posts
  devise_for :users, controllers: {
    confirmations: 'confirmations'
  }
  resources :dashboard, only: [:index]
  resources :home, only: [:index]
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
