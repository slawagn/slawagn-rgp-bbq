Rails.application.routes.draw do
  resources :photos
  root 'events#index'

  devise_for :users, controllers: {
    registrations: 'devise/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  resources :users, only: %i[show edit update]
  resources :events do
    resources :comments, only: %i[create destroy]
    resources :subscriptions, only: %i[create destroy]
    resources :photos, only: %i[create destroy]

    post :show, on: :member
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
