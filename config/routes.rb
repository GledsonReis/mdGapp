Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  get 'profile/:id', to: 'profile#index', as: :profile
  get 'follow/:id', to: 'follows#create', as: :follow
  delete 'unfollow/:id', to: 'follows#destroy', as: :unfollow
  resources :comments
  resources :posts
  devise_for :users, controllers: {
    confirmations: :confirmations,
    registrations: :registrations
  }
  resources :chatrooms do
    resources :messages
  end
  resources :messages
  resources :dashboard, only: [:index]
  resources :home, only: [:index]
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
