Rails.application.routes.draw do
  root 'events#index'

  devise_for :users
  
  resources :users, only: %i[show edit update]
  resources :events do
    resources :comments, only: %i[create destroy]
    resources :subscriptions, only: %i[create destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
